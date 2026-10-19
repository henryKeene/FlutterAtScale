// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'reading_stats_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ReadingStatsLocalizationsEn extends ReadingStatsLocalizations {
  ReadingStatsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Reading stats';

  @override
  String get emptyTitle => 'Nothing to count yet';

  @override
  String get emptyMessage => 'Add a few books to your shelf to see your stats.';

  @override
  String get findABook => 'Find a book';

  @override
  String goalTitle(int year) {
    return '$year reading goal';
  }

  @override
  String goalProgress(int read, int goal) {
    String _temp0 = intl.Intl.pluralLogic(
      goal,
      locale: localeName,
      other: '$goal books',
      one: '1 book',
    );
    return '$read of $_temp0';
  }

  @override
  String booksToGo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count books to go',
      one: '1 book to go',
    );
    return '$_temp0';
  }

  @override
  String get goalReached => 'Goal reached. Nice work.';

  @override
  String get averageRating => 'Avg rating';

  @override
  String get finishedByMonth => 'Finished by month';
}
