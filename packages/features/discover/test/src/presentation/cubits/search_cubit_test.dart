import 'package:bloc_test/bloc_test.dart';
import 'package:core_books/core_books.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:discover/discover.dart';
import 'package:discover/src/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCatalog extends Mock implements IBookCatalogService;

class _MockNavigation extends Mock implements IDiscoverNavigation;

void main() {
  const dune = Book(workId: 'OL1W', title: 'Dune');

  late _MockCatalog catalog;
  late _MockNavigation navigation;

  setUp(() {
    catalog = _MockCatalog();
    navigation = _MockNavigation();
  });

  SearchCubit buildCubit() => SearchCubit(catalog, navigation);

  group('SearchCubit', () {
    blocTest<SearchCubit, SearchState>(
      'debounces typing and searches once with the trimmed query',
      setUp: () =>
          when(() => catalog.search(any()))
              .thenAnswer((_) async => success([dune])),
      build: buildCubit,
      act: (cubit) => cubit
        ..queryChanged('du')
        ..queryChanged('dune '),
      wait: SearchCubit.debounce,
      expect: () => [
        const SearchLoading('dune'),
        const SearchResults('dune', [dune]),
      ],
      verify: (_) => verify(() => catalog.search('dune')).called(1),
    );

    blocTest<SearchCubit, SearchState>(
      'goes back to idle when the query is cleared',
      build: buildCubit,
      seed: () => const SearchResults('dune', [dune]),
      act: (cubit) => cubit.queryChanged('  '),
      expect: () => [const SearchIdle()],
    );

    blocTest<SearchCubit, SearchState>(
      'emits empty when nothing matches',
      setUp: () =>
          when(() => catalog.search(any()))
              .thenAnswer((_) async => success(const [])),
      build: buildCubit,
      act: (cubit) => cubit.search('zzzz'),
      expect: () => [const SearchLoading('zzzz'), const SearchEmpty('zzzz')],
    );

    blocTest<SearchCubit, SearchState>(
      'emits the failure message when the catalogue is unavailable',
      setUp: () =>
          when(() => catalog.search(any()))
              .thenAnswer((_) async => failure(const CatalogUnavailable())),
      build: buildCubit,
      act: (cubit) => cubit.search('dune'),
      expect: () => [
        const SearchLoading('dune'),
        const SearchFailure('dune', CatalogUnavailable()),
      ],
    );

    test('opening a result navigates to the book', () {
      buildCubit().openBook(dune);

      verify(() => navigation.openBook('OL1W')).called(1);
    });
  });
}
