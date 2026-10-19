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
    final result = await _library.shelve(
      book,
      status: status,
      rating: rating,
      review: review,
    );
    emit(result.fold(ShelveBookSaved.new, ShelveBookFailed.new));
  }
}
