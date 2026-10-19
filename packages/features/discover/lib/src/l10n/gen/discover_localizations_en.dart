// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'discover_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DiscoverLocalizationsEn extends DiscoverLocalizations {
  DiscoverLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Discover';

  @override
  String get searchHint => 'Title, author or subject';

  @override
  String get clearSearch => 'Clear';

  @override
  String get idleTitle => 'Find your next book';

  @override
  String get idleMessage => 'Search Open Library by title, author or subject.';

  @override
  String get noMatchesTitle => 'No matches';

  @override
  String noMatchesMessage(String query) {
    return 'Nothing on Open Library matched \"$query\".';
  }

  @override
  String get trendingToday => 'Trending today';
}
