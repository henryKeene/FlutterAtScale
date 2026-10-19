part of 'book_details_cubit.dart';

sealed class BookDetailsState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class BookDetailsLoading extends BookDetailsState {
  const new();
}

final class BookDetailsLoaded extends BookDetailsState {
  const new({required this.book, this.entry, this.isOffline = false});

  final Book book;
  final ShelfEntry? entry;
  final bool isOffline;

  BookDetailsLoaded withEntry(ShelfEntry? entry) =>
      BookDetailsLoaded(book: book, entry: entry, isOffline: isOffline);

  @override
  List<Object?> get props => [book, entry, isOffline];
}

final class BookDetailsFailure extends BookDetailsState {
  const new({required this.workId, required this.failure});

  final String workId;
  final CatalogFailure failure;

  @override
  List<Object?> get props => [workId, failure];
}
