import 'package:core_books/src/domain/failures/library_failure.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_books/src/domain/models/reading_status.dart';
import 'package:core_books/src/domain/models/shelf_entry.dart';
import 'package:core_prelude/core_prelude.dart';

abstract interface class ILibraryService {
  Stream<List<ShelfEntry>> watchShelf();

  Future<ShelfEntry?> entryFor(String workId);

  Future<Result<ShelfEntry, LibraryFailure>> shelve(
    Book book, {
    required ReadingStatus status,
    int? rating,
    String? review,
  });

  Future<Result<void, LibraryFailure>> remove(String workId);
}
