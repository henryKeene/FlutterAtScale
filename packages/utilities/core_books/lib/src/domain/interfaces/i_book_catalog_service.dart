import 'package:core_books/src/domain/failures/catalog_failure.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_prelude/core_prelude.dart';

abstract interface class IBookCatalogService {
  Future<Result<List<Book>, CatalogFailure>> search(String query);

  Future<Result<List<Book>, CatalogFailure>> trending();

  Future<Result<Book, CatalogFailure>> book(String workId);
}
