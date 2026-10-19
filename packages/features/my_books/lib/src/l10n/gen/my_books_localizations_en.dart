// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'my_books_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class MyBooksLocalizationsEn extends MyBooksLocalizations {
  MyBooksLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'My books';

  @override
  String get emptyShelfTitle => 'Your shelf is empty';

  @override
  String get emptyShelfMessage =>
      'Find a book you are reading or want to read and add it here.';

  @override
  String get findABook => 'Find a book';

  @override
  String get emptyFilterTitle => 'Nothing here yet';

  @override
  String emptyFilterMessage(String shelf) {
    return 'Books you mark as \"$shelf\" show up here.';
  }

  @override
  String get loadFailed => 'We couldn\'t load your shelf.';
}
