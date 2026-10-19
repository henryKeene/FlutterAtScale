import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:core_books/core_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_books/my_books.dart';
import 'package:my_books/src/presentation/cubits/my_books_cubit/my_books_cubit.dart';

class _MockLibraryService extends Mock implements ILibraryService;

class _MockNavigation extends Mock implements IMyBooksNavigation;

void main() {
  final reading = ShelfEntry(
    book: const Book(workId: 'OL1W', title: 'Dune'),
    status: ReadingStatus.reading,
    updatedAt: DateTime(2026),
  );
  final read = ShelfEntry(
    book: const Book(workId: 'OL2W', title: 'Emma'),
    status: ReadingStatus.read,
    updatedAt: DateTime(2026),
  );

  late _MockLibraryService library;
  late _MockNavigation navigation;
  late StreamController<List<ShelfEntry>> shelf;

  setUp(() {
    library = _MockLibraryService();
    navigation = _MockNavigation();
    shelf = StreamController.broadcast();
    when(() => library.watchShelf()).thenAnswer((_) => shelf.stream);
  });

  tearDown(() => shelf.close());

  MyBooksCubit buildCubit() => MyBooksCubit(library, navigation);

  group('MyBooksCubit', () {
    blocTest<MyBooksCubit, MyBooksState>(
      'emits the shelf filtered to books being read by default',
      build: buildCubit,
      act: (cubit) {
        cubit.watchShelf();
        shelf.add([reading, read]);
      },
      expect: () => [
        MyBooksLoaded(entries: [reading, read], filter: ReadingStatus.reading),
      ],
      verify: (cubit) {
        final state = cubit.state as MyBooksLoaded;
        expect(state.visible, [reading]);
      },
    );

    blocTest<MyBooksCubit, MyBooksState>(
      'keeps the selected filter when the shelf changes',
      build: buildCubit,
      act: (cubit) async {
        cubit.watchShelf();
        shelf.add([reading]);
        await Future<void>.delayed(Duration.zero);
        cubit.selectFilter(ReadingStatus.read);
        shelf.add([reading, read]);
      },
      skip: 2,
      expect: () => [
        MyBooksLoaded(entries: [reading, read], filter: ReadingStatus.read),
      ],
    );

    blocTest<MyBooksCubit, MyBooksState>(
      'emits a failure when the shelf cannot be read',
      build: buildCubit,
      act: (cubit) {
        cubit.watchShelf();
        shelf.addError(Exception('disk full'));
      },
      expect: () => [const MyBooksFailure()],
    );

    test('opening a book navigates to its details', () {
      buildCubit().openBook(reading.book);

      verify(() => navigation.openBook('OL1W')).called(1);
    });
  });
}
