import 'package:core_books/core_books.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'shelve_book_state.dart';

@injectable
class ShelveBookCubit extends Cubit<ShelveBookState> {
  new(this._library, this._flags) : super(const ShelveBookIdle());

  final ILibraryService _library;
  final IFeatureFlagService _flags;

  bool needsReview(ReadingStatus status) =>
      status == ReadingStatus.read && _flags.isEnabled(FeatureFlag.bookReviews);

  Future<void> shelve(
    Book book,
    ReadingStatus status, {
    int? rating,
    String? review,
  }) async {
    emit(const ShelveBookSaving());
    final previous = await _library.entryFor(book.workId);
    final result = await _library.shelve(
      book,
      status: status,
      rating: rating,
      review: review,
    );
    emit(
      result.fold(
        (entry) => ShelveBookSaved(entry, previous: previous),
        ShelveBookFailed.new,
      ),
    );
  }

  /// Puts the shelf back the way it was before the last save: the book goes
  /// back to its old shelf, with its old rating and review, or off the shelf
  /// if it was not on one.
  Future<void> undo() async {
    if (state case ShelveBookSaved(:final entry, :final previous)) {
      emit(const ShelveBookSaving());
      final result = previous == null
          ? await _library.remove(entry.book.workId)
          : (await _library.shelve(
              previous.book,
              status: previous.status,
              rating: previous.rating,
              review: previous.review,
            )).map((_) {});
      emit(result.fold((_) => const ShelveBookUndone(), ShelveBookFailed.new));
    }
  }
}
