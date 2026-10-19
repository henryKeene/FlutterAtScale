import 'package:core_books/core_books.dart';

sealed class BookDetailsFlowState {
  const new();
}

final class BookOverview extends BookDetailsFlowState {
  const new();
}

final class ChoosingShelf extends BookDetailsFlowState {
  const new(this.book);

  final Book book;
}

final class WritingReview extends BookDetailsFlowState {
  const new(this.book);

  final Book book;
}
