import 'dart:async';

import 'package:core_books/src/domain/failures/library_failure.dart';
import 'package:core_books/src/domain/interfaces/i_library_service.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_books/src/domain/models/reading_status.dart';
import 'package:core_books/src/domain/models/shelf_entry.dart';
import 'package:core_prelude/core_prelude.dart';

/// How [FakeLibraryService] answers when the shelf is watched.
enum ShelfBehaviour {
  loads,

  /// Never answers, to show loading states.
  neverLoads,
  fails,
}

/// A shelf in memory. Books saved to it stay until it is seeded again, and
/// anything watching it hears about every change.
final class FakeLibraryService implements ILibraryService {
  ShelfBehaviour behaviour = ShelfBehaviour.loads;

  /// Whether saving or removing a book fails.
  bool failWrites = false;

  final Map<String, ShelfEntry> _entries = {};
  final _changes = StreamController<List<ShelfEntry>>.broadcast();

  List<ShelfEntry> get entries => _entries.values.toList();

  /// Replaces everything on the shelf with [entries].
  void seed(Iterable<ShelfEntry> entries) {
    _entries
      ..clear()
      ..addEntries(entries.map((entry) => MapEntry(entry.book.workId, entry)));
    _changes.add(this.entries);
  }

  @override
  Stream<List<ShelfEntry>> watchShelf() => switch (behaviour) {
    ShelfBehaviour.loads => _shelf(),
    ShelfBehaviour.neverLoads => const Stream.empty(),
    ShelfBehaviour.fails => Stream.error(const LibraryFailure()),
  };

  Stream<List<ShelfEntry>> _shelf() async* {
    yield entries;
    yield* _changes.stream;
  }

  @override
  Future<ShelfEntry?> entryFor(String workId) async => _entries[workId];

  @override
  Future<Result<ShelfEntry, LibraryFailure>> shelve(
    Book book, {
    required ReadingStatus status,
    int? rating,
    String? review,
  }) async {
    if (failWrites) return failure(const LibraryFailure());

    final entry = ShelfEntry(
      book: book,
      status: status,
      updatedAt: DateTime.now(),
      rating: rating,
      review: review,
    );
    _entries[book.workId] = entry;
    _changes.add(entries);
    return success(entry);
  }

  @override
  Future<Result<void, LibraryFailure>> remove(String workId) async {
    if (failWrites) return failure(const LibraryFailure());

    _entries.remove(workId);
    _changes.add(entries);
    return success(null);
  }
}
