import 'package:core_books/src/data/dtos/search_doc_dto.dart';
import 'package:core_books/src/data/dtos/work_dto.dart';
import 'package:core_books/src/domain/failures/catalog_failure.dart';
import 'package:core_books/src/domain/interfaces/i_book_catalog_service.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_network/core_network.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IBookCatalogService)
class OpenLibraryCatalogService implements IBookCatalogService {
  new(this._client);

  static const _searchFields =
      'key,title,author_name,cover_i,first_publish_year,subject';

  final IApiClient _client;

  @override
  Future<Result<List<Book>, CatalogFailure>> search(String query) async {
    final result = await _client.getJson(
      '/search.json',
      query: {'q': query, 'fields': _searchFields, 'limit': '20'},
    );
    return result
        .mapFailure(_toCatalogFailure)
        .map((json) => _books(json['docs']));
  }

  @override
  Future<Result<List<Book>, CatalogFailure>> trending() async {
    final result = await _client.getJson(
      '/trending/daily.json',
      query: {'limit': '12'},
    );
    return result
        .mapFailure(_toCatalogFailure)
        .map((json) => _books(json['works']));
  }

  @override
  Future<Result<Book, CatalogFailure>> book(String workId) async {
    final result = await _client.getJson('/works/$workId.json');
    return await result
        .mapFailure(_toCatalogFailure)
        .asyncFlatMap(_withAuthors);
  }

  Future<Result<Book, CatalogFailure>> _withAuthors(Json json) async {
    final work = WorkDto.fromJson(json);
    final authors = await Future.wait(work.authorKeys.take(3).map(_authorName));
    return success(work.toBook(authors: authors.nonNulls.toList()));
  }

  Future<String?> _authorName(String key) async {
    final result = await _client.getJson('$key.json');
    return result.getOrNull()?['name'] as String?;
  }

  List<Book> _books(Object? docs) => [
    if (docs is List)
      for (final doc in docs.whereType<Json>())
        SearchDocDto.fromJson(doc).toBook(),
  ];

  CatalogFailure _toCatalogFailure(NetworkFailure failure) => switch (failure) {
    ServerFailure(statusCode: 404) => const BookNotFound(),
    _ => const CatalogUnavailable(),
  };
}
