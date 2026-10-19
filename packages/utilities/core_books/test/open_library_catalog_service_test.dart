import 'package:core_books/core_books.dart';
import 'package:core_books/src/data/services/open_library_catalog_service.dart';
import 'package:core_network/core_network.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockApiClient extends Mock implements IApiClient;

void main() {
  late _MockApiClient client;
  late OpenLibraryCatalogService service;

  setUp(() {
    client = _MockApiClient();
    service = OpenLibraryCatalogService(client);
  });

  void respond(String path, Result<Json, NetworkFailure> response) {
    when(() => client.getJson(path, query: any(named: 'query')))
        .thenAnswer((_) async => response);
  }

  group('search', () {
    test('maps search documents to books', () async {
      respond(
        '/search.json',
        success({
          'docs': [
            {
              'key': '/works/OL893414W',
              'title': 'Dune',
              'author_name': ['Frank Herbert'],
              'cover_i': 11481354,
              'first_publish_year': 1965,
              'subject': [
                'Science fiction',
                'nyt:mass-market-monthly=2021-11-07',
              ],
            },
          ],
        }),
      );

      final result = await service.search('dune');

      expect(result.getOrNull(), const [
        Book(
          workId: 'OL893414W',
          title: 'Dune',
          authors: ['Frank Herbert'],
          coverId: 11481354,
          firstPublishYear: 1965,
          subjects: ['Science fiction'],
        ),
      ]);
    });

    test('maps network failures to CatalogUnavailable', () async {
      respond('/search.json', failure(const ConnectionFailure()));

      final result = await service.search('dune');

      expect(
        result,
        failure<List<Book>, CatalogFailure>(const CatalogUnavailable()),
      );
    });
  });

  group('book', () {
    test('loads the work and resolves its author names', () async {
      respond(
        '/works/OL893414W.json',
        success({
          'key': '/works/OL893414W',
          'title': 'Dune',
          'authors': [
            {
              'author': {'key': '/authors/OL79034A'},
            },
          ],
          'description': {
            'type': '/type/text',
            'value': 'Spice.\r\nMore spice.',
          },
          'covers': [-1, 11481354],
          'subjects': ['Ecology'],
        }),
      );
      respond('/authors/OL79034A.json', success({'name': 'Frank Herbert'}));

      final result = await service.book('OL893414W');

      expect(
        result.getOrNull(),
        const Book(
          workId: 'OL893414W',
          title: 'Dune',
          authors: ['Frank Herbert'],
          coverId: 11481354,
          description: 'Spice.\nMore spice.',
          subjects: ['Ecology'],
        ),
      );
    });

    test('still returns the book when an author lookup fails', () async {
      respond(
        '/works/OL1W.json',
        success({
          'key': '/works/OL1W',
          'title': 'Mystery',
          'authors': [
            {
              'author': {'key': '/authors/OL1A'},
            },
          ],
        }),
      );
      respond('/authors/OL1A.json', failure(const TimeoutFailure()));

      final result = await service.book('OL1W');

      expect(result.getOrNull()?.authors, isEmpty);
    });

    test('maps a 404 to BookNotFound', () async {
      respond('/works/missing.json', failure(const ServerFailure(404)));

      final result = await service.book('missing');

      expect(result, failure<Book, CatalogFailure>(const BookNotFound()));
    });
  });
}
