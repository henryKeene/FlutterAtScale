part of 'shelve_book_cubit.dart';

sealed class ShelveBookState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class ShelveBookIdle extends ShelveBookState {
  const new();
}

final class ShelveBookSaving extends ShelveBookState {
  const new();
}

final class ShelveBookSaved extends ShelveBookState {
  const new(this.entry, {this.previous});

  final ShelfEntry entry;

  /// What was on the shelf before, so the save can be undone. Null when the
  /// book was not on a shelf.
  final ShelfEntry? previous;

  @override
  List<Object?> get props => [entry, previous];
}

/// The last save was undone, and the shelf is as it was before.
final class ShelveBookUndone extends ShelveBookState {
  const new();
}

final class ShelveBookFailed extends ShelveBookState {
  const new(this.failure);

  final LibraryFailure failure;

  @override
  List<Object?> get props => [failure];
}
