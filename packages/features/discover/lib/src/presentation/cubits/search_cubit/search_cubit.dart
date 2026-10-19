import 'dart:async';

import 'package:core_books/core_books.dart';
import 'package:discover/src/domain/navigation/i_discover_navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  new(this._catalog, this._navigation) : super(const SearchIdle());

  static const debounce = Duration(milliseconds: 400);

  final IBookCatalogService _catalog;
  final IDiscoverNavigation _navigation;
  Timer? _debounce;

  void queryChanged(String query) {
    _debounce?.cancel();
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      emit(const SearchIdle());
      return;
    }
    _debounce = Timer(debounce, () => unawaited(search(trimmed)));
  }

  Future<void> search(String query) async {
    _debounce?.cancel();
    emit(SearchLoading(query));

    final result = await _catalog.search(query);
    if (isClosed || state.query != query) return;

    emit(
      result.fold(
        (books) =>
            books.isEmpty ? SearchEmpty(query) : SearchResults(query, books),
        (failure) => SearchFailure(query, failure),
      ),
    );
  }

  void openBook(Book book) => _navigation.openBook(book.workId);

  @override
  Future<void> close() async {
    _debounce?.cancel();
    await super.close();
  }
}
