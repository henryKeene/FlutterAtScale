part of 'my_books_cubit.dart';

sealed class MyBooksState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class MyBooksLoading extends MyBooksState {
  const new();
}

final class MyBooksLoaded extends MyBooksState {
  const new({required this.entries, required this.filter});

  final List<ShelfEntry> entries;
  final ReadingStatus filter;

  List<ShelfEntry> get visible =>
      entries.where((entry) => entry.status == filter).toList();

  MyBooksLoaded copyWith({ReadingStatus? filter}) =>
      MyBooksLoaded(entries: entries, filter: filter ?? this.filter);

  @override
  List<Object?> get props => [entries, filter];
}

final class MyBooksFailure extends MyBooksState {
  const new();
}
