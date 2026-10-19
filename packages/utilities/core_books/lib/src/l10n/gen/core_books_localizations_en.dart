// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'core_books_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CoreBooksLocalizationsEn extends CoreBooksLocalizations {
  CoreBooksLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get readingStatusReading => 'Reading';

  @override
  String get readingStatusWantToRead => 'Want to read';

  @override
  String get readingStatusRead => 'Read';

  @override
  String get unknownAuthor => 'Unknown author';

  @override
  String get catalogUnavailable =>
      'We couldn\'t reach Open Library. Check your connection and try again.';

  @override
  String get bookNotFound => 'We couldn\'t find that book.';

  @override
  String get libraryFailure =>
      'We couldn\'t update your shelf. Please try again.';
}
