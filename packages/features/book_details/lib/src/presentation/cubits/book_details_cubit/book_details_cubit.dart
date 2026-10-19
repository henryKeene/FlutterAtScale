import 'dart:async';

import 'package:book_details/src/domain/navigation/i_book_details_navigation.dart';
import 'package:core_books/core_books.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'book_details_state.dart';

@injectable
class BookDetailsCubit extends Cubit<BookDetailsState> {
  new(this._catalog, this._library, this._navigation)
    : super(const BookDetailsLoading());

  final IBookCatalogService _catalog;
  final ILibraryService _library;
  final IBookDetailsNavigation _navigation;
  StreamSubscription<List<ShelfEntry>>? _shelf;

  Future<void> load(String workId) async {
    emit(const BookDetailsLoading());

    final entry = await _library.entryFor(workId);
    final result = await _catalog.book(workId);
    if (isClosed) return;

    switch ((result, entry)) {
      case (Success(value: final book), _):
        emit(BookDetailsLoaded(book: book, entry: entry));
      case (Failure(), ShelfEntry(:final book)):
        emit(BookDetailsLoaded(book: book, entry: entry, isOffline: true));
      case (Failure(:final error), null):
        emit(BookDetailsFailure(workId: workId, failure: error));
    }

    await _shelf?.cancel();
    _shelf = _library.watchShelf().listen(
      (entries) => _onShelfChanged(workId, entries),
    );
  }

  Future<void> removeFromShelf() async {
    if (state case BookDetailsLoaded(:final book)) {
      await _library.remove(book.workId);
    }
  }

  void searchSubject(String subject) => _navigation.searchSubject(subject);

  void goBack() => _navigation.back();

  void _onShelfChanged(String workId, List<ShelfEntry> entries) {
    if (state case final BookDetailsLoaded loaded) {
      final entry = entries
          .where((entry) => entry.book.workId == workId)
          .firstOrNull;
      emit(loaded.withEntry(entry));
    }
  }

  @override
  Future<void> close() async {
    await _shelf?.cancel();
    await super.close();
  }
}
