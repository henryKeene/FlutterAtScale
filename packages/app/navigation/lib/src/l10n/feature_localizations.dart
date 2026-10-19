import 'package:book_details/book_details.dart';
import 'package:discover/discover.dart';
import 'package:flutter/widgets.dart';
import 'package:my_books/my_books.dart';
import 'package:navigation/src/l10n/gen/navigation_localizations.dart';
import 'package:reading_stats/reading_stats.dart';
import 'package:settings/settings.dart';

const List<LocalizationsDelegate<Object>> featureLocalizationsDelegates = [
  NavigationLocalizations.delegate,
  BookDetailsLocalizations.delegate,
  DiscoverLocalizations.delegate,
  MyBooksLocalizations.delegate,
  ReadingStatsLocalizations.delegate,
  SettingsLocalizations.delegate,
];
