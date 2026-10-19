import 'package:core_books/core_books.dart';
import 'package:discover/src/domain/navigation/i_discover_navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'trending_state.dart';

@injectable
class TrendingCubit extends Cubit<TrendingState> {
  new(this._catalog, this._navigation) : super(const TrendingLoading());

  final IBookCatalogService _catalog;
  final IDiscoverNavigation _navigation;

  Future<void> load() async {
    emit(const TrendingLoading());
    final result = await _catalog.trending();
    if (isClosed) return;
    emit(result.fold(TrendingLoaded.new, TrendingFailure.new));
  }

  void openBook(Book book) => _navigation.openBook(book.workId);
}
