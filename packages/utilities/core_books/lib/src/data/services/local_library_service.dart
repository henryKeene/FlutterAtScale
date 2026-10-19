import 'dart:async';
import 'dart:convert';

import 'package:core_books/src/domain/failures/library_failure.dart';
import 'package:core_books/src/domain/interfaces/i_library_service.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_books/src/domain/models/reading_status.dart';
import 'package:core_books/src/domain/models/shelf_entry.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILibraryService)
class LocalLibraryService implements ILibraryService {
  new(this._store);

  static const _key = 'library_shelf';

  final IKeyValueStore _store;
  final _changes = StreamController<List<ShelfEntry>>.broadcast();

  @override
  Stream<List<ShelfEntry>> watchShelf() async* {
    yield await _read();
    yield* _changes.stream;
  }

  @override
  Future<ShelfEntry?> entryFor(String workId) async {
    final entries = await _read();
    return entries.where((entry) => entry.book.workId == workId).firstOrNull;
  }

  @override
  Future<Result<ShelfEntry, LibraryFailure>> shelve(
    Book book, {
    required ReadingStatus status,
    int? rating,
    String? review,
  }) async {
    final entry = ShelfEntry(
      book: book,
      status: status,
      updatedAt: DateTime.now(),
      rating: rating,
      review: review,
    );
    final entries = await _read();
    final result = await _write([
      entry,
      ...entries.where((existing) => existing.book.workId != book.workId),
    ]);
    return result.map((_) => entry);
  }

  @override
  Future<Result<void, LibraryFailure>> remove(String workId) async {
    final entries = await _read();
    return await _write([
      ...entries.where((entry) => entry.book.workId != workId),
    ]);
  }

  Future<List<ShelfEntry>> _read() async {
    final stored = await _store.readString(_key);
    if (stored == null) return const [];
    try {
      final decoded = jsonDecode(stored) as List<dynamic>;
      return [
        for (final json in decoded.cast<Map<String, dynamic>>())
          ShelfEntry.fromJson(json),
      ];
    } on FormatException {
      return const [];
    }
  }

  Future<Result<void, LibraryFailure>> _write(List<ShelfEntry> entries) async {
    try {
      final encoded = jsonEncode([for (final entry in entries) entry.toJson()]);
      await _store.writeString(_key, encoded);
    } on Exception {
      return failure(const LibraryFailure());
    }
    _changes.add(entries);
    return success(null);
  }
}
