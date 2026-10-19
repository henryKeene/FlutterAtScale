import 'package:core_books/src/domain/failures/catalog_failure.dart';
import 'package:core_books/src/domain/failures/library_failure.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_books/src/domain/models/reading_status.dart';
import 'package:core_books/src/l10n/gen/core_books_localizations.dart';
import 'package:flutter/widgets.dart';

extension ReadingStatusText on ReadingStatus {
  String label(BuildContext context) {
    final l10n = CoreBooksLocalizations.of(context);
    return switch (this) {
      ReadingStatus.reading => l10n.readingStatusReading,
      ReadingStatus.wantToRead => l10n.readingStatusWantToRead,
      ReadingStatus.read => l10n.readingStatusRead,
    };
  }
}

extension BookText on Book {
  String byline(BuildContext context) => authors.isEmpty
      ? CoreBooksLocalizations.of(context).unknownAuthor
      : authors.join(', ');
}

extension CatalogFailureText on CatalogFailure {
  String describe(BuildContext context) {
    final l10n = CoreBooksLocalizations.of(context);
    return switch (this) {
      CatalogUnavailable() => l10n.catalogUnavailable,
      BookNotFound() => l10n.bookNotFound,
    };
  }
}

extension LibraryFailureText on LibraryFailure {
  String describe(BuildContext context) =>
      CoreBooksLocalizations.of(context).libraryFailure;
}
