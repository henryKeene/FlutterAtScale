import 'dart:async';

import 'package:core_books/core_books.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_books/src/domain/navigation/i_my_books_navigation.dart';

part 'my_books_state.dart';

@injectable
class MyBooksCubit extends Cubit<MyBooksState> {
  new(this._library, this._navigation) : super(const MyBooksLoading());

  final ILibraryService _library;
  final IMyBooksNavigation _navigation;
  StreamSubscription<List<ShelfEntry>>? _subscription;

  ReadingStatus get _filter => switch (state) {
    MyBooksLoaded(:final filter) => filter,
    _ => ReadingStatus.reading,
  };

  void watchShelf() {
    unawaited(_subscription?.cancel());
    _subscription = _library.watchShelf().listen(
      (entries) => emit(MyBooksLoaded(entries: entries, filter: _filter)),
      onError: (Object _) => emit(const MyBooksFailure()),
    );
  }

  void selectFilter(ReadingStatus filter) {
    if (state case final MyBooksLoaded loaded) {
      emit(loaded.copyWith(filter: filter));
    }
  }

  void openBook(Book book) => _navigation.openBook(book.workId);

  void openDiscover() => _navigation.openDiscover();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
