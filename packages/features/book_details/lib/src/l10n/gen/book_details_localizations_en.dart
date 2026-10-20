// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'book_details_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class BookDetailsLocalizationsEn extends BookDetailsLocalizations {
  BookDetailsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get removeFromShelf => 'Remove from shelf';

  @override
  String get savedCopyTitle => 'Showing your saved copy';

  @override
  String get savedCopyMessage => 'Open Library could not be reached.';

  @override
  String get aboutThisBook => 'About this book';

  @override
  String get subjects => 'Subjects';

  @override
  String get addToShelf => 'Add to shelf';

  @override
  String get changeShelf => 'Change shelf';

  @override
  String movedTo(String shelf) {
    return 'Moved to $shelf';
  }

  @override
  String firstPublished(int year) {
    return 'First published $year';
  }

  @override
  String get yourReview => 'Your review';

  @override
  String get skip => 'Skip';

  @override
  String reviewPrompt(String title) {
    return 'How was $title?';
  }

  @override
  String get reviewHint => 'What did you think?';

  @override
  String get saveReview => 'Save review';

  @override
  String get undo => 'Undo';
}
