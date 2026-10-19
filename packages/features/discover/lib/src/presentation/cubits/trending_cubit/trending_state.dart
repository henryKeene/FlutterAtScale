part of 'trending_cubit.dart';

sealed class TrendingState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class TrendingLoading extends TrendingState {
  const new();
}

final class TrendingLoaded extends TrendingState {
  const new(this.books);

  final List<Book> books;

  @override
  List<Object?> get props => [books];
}

final class TrendingFailure extends TrendingState {
  const new(this.failure);

  final CatalogFailure failure;

  @override
  List<Object?> get props => [failure];
}
