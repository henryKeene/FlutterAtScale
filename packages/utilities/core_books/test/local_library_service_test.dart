import 'package:core_books/core_books.dart';
import 'package:core_books/src/data/services/local_library_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/in_memory_store.dart';

void main() {
  const dune = Book(workId: 'OL1W', title: 'Dune', authors: ['Frank Herbert']);
  const emma = Book(workId: 'OL2W', title: 'Emma', authors: ['Jane Austen']);

  late InMemoryStore store;
  late LocalLibraryService service;

  setUp(() {
    store = InMemoryStore();
    service = LocalLibraryService(store);
  });

  group('LocalLibraryService', () {
    test('starts with an empty shelf', () async {
      expect(await service.watchShelf().first, isEmpty);
    });

    test('shelves a book and can read it back', () async {
      final result = await service.shelve(dune, status: ReadingStatus.reading);

      expect(result.isSuccess, isTrue);
      final entry = await service.entryFor('OL1W');
      expect(entry?.book, dune);
      expect(entry?.status, ReadingStatus.reading);
    });

    test(
      're-shelving a book replaces its entry and moves it to the top',
      () async {
        await service.shelve(dune, status: ReadingStatus.wantToRead);
        await service.shelve(emma, status: ReadingStatus.reading);
        await service.shelve(dune, status: ReadingStatus.read, rating: 5);

        final shelf = await service.watchShelf().first;
        expect(shelf.map((entry) => entry.book.workId), ['OL1W', 'OL2W']);
        expect(shelf.first.status, ReadingStatus.read);
        expect(shelf.first.rating, 5);
      },
    );

    test('removes a book from the shelf', () async {
      await service.shelve(dune, status: ReadingStatus.reading);

      await service.remove('OL1W');

      expect(await service.entryFor('OL1W'), isNull);
    });

    test('broadcasts every change to watchers', () async {
      final shelves = service.watchShelf().map((shelf) => shelf.length);

      final expectation = expectLater(shelves, emitsInOrder([0, 1, 2]));
      await Future<void>.delayed(Duration.zero);
      await service.shelve(dune, status: ReadingStatus.reading);
      await service.shelve(emma, status: ReadingStatus.read);

      await expectation;
    });

    test('treats corrupt storage as an empty shelf', () async {
      store.values['library_shelf'] = 'not json';

      expect(await service.watchShelf().first, isEmpty);
    });
  });
}
