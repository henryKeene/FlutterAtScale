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
  const new(this.entry);

  final ShelfEntry entry;

  @override
  List<Object?> get props => [entry];
}

final class ShelveBookFailed extends ShelveBookState {
  const new(this.failure);

  final LibraryFailure failure;

  @override
  List<Object?> get props => [failure];
}
