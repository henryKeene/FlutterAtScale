import 'package:bloc_test/bloc_test.dart';
import 'package:book_details/book_details.dart';
import 'package:book_details/src/presentation/cubits/book_details_cubit/book_details_cubit.dart';
import 'package:core_books/core_books.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCatalog extends Mock implements IBookCatalogService;

class _MockLibraryService extends Mock implements ILibraryService;

class _MockNavigation extends Mock implements IBookDetailsNavigation;

void main() {
  const dune = Book(workId: 'OL1W', title: 'Dune', subjects: ['Ecology']);
  final shelved = ShelfEntry(
    book: dune,
    status: ReadingStatus.reading,
    updatedAt: DateTime(2026),
  );

  late _MockCatalog catalog;
  late _MockLibraryService library;
  late _MockNavigation navigation;

  setUp(() {
    catalog = _MockCatalog();
    library = _MockLibraryService();
    navigation = _MockNavigation();
    when(() => library.watchShelf()).thenAnswer((_) => const Stream.empty());
  });

  BookDetailsCubit buildCubit() =>
      BookDetailsCubit(catalog, library, navigation);

  group('BookDetailsCubit', () {
    blocTest<BookDetailsCubit, BookDetailsState>(
      'loads the book from the catalogue alongside its shelf entry',
      setUp: () {
        when(() => library.entryFor('OL1W')).thenAnswer((_) async => shelved);
        when(() => catalog.book('OL1W')).thenAnswer((_) async => success(dune));
      },
      build: buildCubit,
      act: (cubit) => cubit.load('OL1W'),
      expect: () => [
        const BookDetailsLoading(),
        BookDetailsLoaded(book: dune, entry: shelved),
      ],
    );

    blocTest<BookDetailsCubit, BookDetailsState>(
      'falls back to the saved copy when the catalogue is unavailable',
      setUp: () {
        when(() => library.entryFor('OL1W')).thenAnswer((_) async => shelved);
        when(() => catalog.book('OL1W'))
            .thenAnswer((_) async => failure(const CatalogUnavailable()));
      },
      build: buildCubit,
      act: (cubit) => cubit.load('OL1W'),
      expect: () => [
        const BookDetailsLoading(),
        BookDetailsLoaded(book: dune, entry: shelved, isOffline: true),
      ],
    );

    blocTest<BookDetailsCubit, BookDetailsState>(
      'fails when the book is neither online nor on the shelf',
      setUp: () {
        when(() => library.entryFor('OL1W')).thenAnswer((_) async => null);
        when(() => catalog.book('OL1W'))
            .thenAnswer((_) async => failure(const BookNotFound()));
      },
      build: buildCubit,
      act: (cubit) => cubit.load('OL1W'),
      expect: () => [
        const BookDetailsLoading(),
        const BookDetailsFailure(workId: 'OL1W', failure: BookNotFound()),
      ],
    );

    test('tapping a subject searches for it', () {
      buildCubit().searchSubject('Ecology');

      verify(() => navigation.searchSubject('Ecology')).called(1);
    });
  });
}
