import 'package:core_books/src/domain/failures/catalog_failure.dart';
import 'package:core_books/src/domain/interfaces/i_book_catalog_service.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_books/src/fakes/sample_books.dart';
import 'package:core_prelude/core_prelude.dart';

/// How [FakeBookCatalogService] answers.
enum CatalogBehaviour {
  loads,

  /// Answers after [FakeBookCatalogService.latency], to show loading states.
  slow,
  notFound,
  offline,
}

/// A catalogue of [books] that answers the way [behaviour] says.
final class FakeBookCatalogService implements IBookCatalogService {
  new({this.books = SampleBooks.all});

  final List<Book> books;
  CatalogBehaviour behaviour = CatalogBehaviour.loads;
  Duration latency = const Duration(seconds: 3);

  @override
  Future<Result<Book, CatalogFailure>> book(String workId) async {
    await _wait();
    final book = books.where((it) => it.workId == workId).firstOrNull;

    return switch ((behaviour, book)) {
      (CatalogBehaviour.offline, _) => failure(const CatalogUnavailable()),
      (CatalogBehaviour.notFound, _) ||
      (_, null) => failure(const BookNotFound()),
      (_, final Book book) => success(book),
    };
  }

  @override
  Future<Result<List<Book>, CatalogFailure>> search(String query) async {
    await _wait();
    if (behaviour == CatalogBehaviour.offline) {
      return failure(const CatalogUnavailable());
    }
    final words = query.toLowerCase();
    return success([
      for (final book in books)
        if (book.title.toLowerCase().contains(words)) book,
    ]);
  }

  @override
  Future<Result<List<Book>, CatalogFailure>> trending() => search('');

  Future<void> _wait() => behaviour == CatalogBehaviour.slow
      ? Future.delayed(latency)
      : Future.value();
}
