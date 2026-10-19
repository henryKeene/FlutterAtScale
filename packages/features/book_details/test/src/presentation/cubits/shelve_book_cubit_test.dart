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

  setUp(() {
    library = _MockLibraryService();
    flags = _MockFeatureFlagService();
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
}
