part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const new([this.query = '']);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class SearchIdle extends SearchState {
  const new();
}

final class SearchLoading extends SearchState {
  const new(super.query);
}

final class SearchEmpty extends SearchState {
  const new(super.query);
}

final class SearchResults extends SearchState {
  const new(super.query, this.books);

  final List<Book> books;

  @override
  List<Object?> get props => [query, books];
}

final class SearchFailure extends SearchState {
  const new(super.query, this.failure);

  final CatalogFailure failure;

  @override
  List<Object?> get props => [query, failure];
}
