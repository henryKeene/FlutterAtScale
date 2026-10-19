import 'package:book_details/book_details.dart';
import 'package:core_di/core_di.dart';
import 'package:discover/discover.dart';
import 'package:my_books/my_books.dart';
import 'package:navigation/src/features/book_details_navigation.dart';
import 'package:navigation/src/features/discover_navigation.dart';
import 'package:navigation/src/features/my_books_navigation.dart';
import 'package:navigation/src/features/reading_stats_navigation.dart';
import 'package:navigation/src/features/settings_navigation.dart';
import 'package:reading_stats/reading_stats.dart';
import 'package:settings/settings.dart';

void initialize() {
  getIt
    ..registerFactory<IMyBooksNavigation>(MyBooksNavigation.new)
    ..registerFactory<IDiscoverNavigation>(DiscoverNavigation.new)
    ..registerFactory<IBookDetailsNavigation>(BookDetailsNavigation.new)
    ..registerFactory<IReadingStatsNavigation>(ReadingStatsNavigation.new)
    ..registerFactory<ISettingsNavigation>(SettingsNavigation.new);
}
