import 'package:bloc_test/bloc_test.dart';
import 'package:book_details/src/presentation/cubits/shelve_book_cubit/shelve_book_cubit.dart';
import 'package:core_books/core_books.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLibraryService extends Mock implements ILibraryService;

class _MockFeatureFlagService extends Mock implements IFeatureFlagService;

void main() {
  const dune = Book(workId: 'OL1W', title: 'Dune');
  final entry = ShelfEntry(
    book: dune,
    status: ReadingStatus.read,
    updatedAt: DateTime(2026),
    rating: 5,
  );

  late _MockLibraryService library;
  late _MockFeatureFlagService flags;

  setUpAll(() => registerFallbackValue(ReadingStatus.reading));

  setUp(() {
    library = _MockLibraryService();
    flags = _MockFeatureFlagService();
    when(() => library.entryFor(any())).thenAnswer((_) async => null);
  });

  ShelveBookCubit buildCubit() => ShelveBookCubit(library, flags);

  group('needsReview', () {
    test('is true for finished books when reviews are enabled', () {
      when(() => flags.isEnabled(FeatureFlag.bookReviews)).thenReturn(true);

      expect(buildCubit().needsReview(ReadingStatus.read), isTrue);
    });

    test('is false for finished books when reviews are disabled', () {
      when(() => flags.isEnabled(FeatureFlag.bookReviews)).thenReturn(false);

      expect(buildCubit().needsReview(ReadingStatus.read), isFalse);
    });

    test('is false for books that are not finished', () {
      when(() => flags.isEnabled(FeatureFlag.bookReviews)).thenReturn(true);

      expect(buildCubit().needsReview(ReadingStatus.reading), isFalse);
    });
  });

  group('shelve', () {
    blocTest<ShelveBookCubit, ShelveBookState>(
      'emits saving then saved with the new entry',
      setUp: () => when(
        () => library.shelve(
          dune,
          status: ReadingStatus.read,
          rating: 5,
          review: any(named: 'review'),
        ),
      ).thenAnswer((_) async => success(entry)),
      build: buildCubit,
      act: (cubit) => cubit.shelve(dune, ReadingStatus.read, rating: 5),
      expect: () => [const ShelveBookSaving(), ShelveBookSaved(entry)],
    );

    blocTest<ShelveBookCubit, ShelveBookState>(
      'emits the failure message when the shelf cannot be saved',
      setUp: () => when(
        () => library.shelve(
          dune,
          status: ReadingStatus.reading,
          rating: any(named: 'rating'),
          review: any(named: 'review'),
        ),
      ).thenAnswer((_) async => failure(const LibraryFailure())),
      build: buildCubit,
      act: (cubit) => cubit.shelve(dune, ReadingStatus.reading),
      expect: () => [
        const ShelveBookSaving(),
        const ShelveBookFailed(LibraryFailure()),
      ],
    );
  });

  group('undo', () {
    final reading = ShelfEntry(
      book: dune,
      status: ReadingStatus.reading,
      updatedAt: DateTime(2025),
      rating: 3,
      review: 'Slow going so far.',
    );

    blocTest<ShelveBookCubit, ShelveBookState>(
      'puts the book back on its old shelf, with its rating and review',
      setUp: () {
        when(() => library.entryFor(dune.workId))
            .thenAnswer((_) async => reading);
        when(
          () => library.shelve(
            dune,
            status: any(named: 'status'),
            rating: any(named: 'rating'),
            review: any(named: 'review'),
          ),
        ).thenAnswer((_) async => success(entry));
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.shelve(dune, ReadingStatus.read, rating: 5);
        await cubit.undo();
      },
      skip: 2,
      expect: () => [const ShelveBookSaving(), const ShelveBookUndone()],
      verify: (_) => verify(
        () => library.shelve(
          dune,
          status: ReadingStatus.reading,
          rating: 3,
          review: 'Slow going so far.',
        ),
      ).called(1),
    );

    blocTest<ShelveBookCubit, ShelveBookState>(
      'takes the book off the shelf when it was not on one',
      setUp: () {
        when(
          () => library.shelve(
            dune,
            status: any(named: 'status'),
            rating: any(named: 'rating'),
            review: any(named: 'review'),
          ),
        ).thenAnswer((_) async => success(entry));
        when(() => library.remove(dune.workId))
            .thenAnswer((_) async => success(null));
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.shelve(dune, ReadingStatus.read);
        await cubit.undo();
      },
      skip: 2,
      expect: () => [const ShelveBookSaving(), const ShelveBookUndone()],
      verify: (_) => verify(() => library.remove(dune.workId)).called(1),
    );

    blocTest<ShelveBookCubit, ShelveBookState>(
      'reports a failed undo',
      setUp: () {
        when(
          () => library.shelve(
            dune,
            status: any(named: 'status'),
            rating: any(named: 'rating'),
            review: any(named: 'review'),
          ),
        ).thenAnswer((_) async => success(entry));
        when(() => library.remove(dune.workId))
            .thenAnswer((_) async => failure(const LibraryFailure()));
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.shelve(dune, ReadingStatus.read);
        await cubit.undo();
      },
      skip: 2,
      expect: () => [
        const ShelveBookSaving(),
        const ShelveBookFailed(LibraryFailure()),
      ],
    );

    blocTest<ShelveBookCubit, ShelveBookState>(
      'does nothing when there is no save to undo',
      build: buildCubit,
      act: (cubit) => cubit.undo(),
      expect: () => <ShelveBookState>[],
    );
  });
}
