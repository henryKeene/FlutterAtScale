import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'reading_stats_localizations_en.dart';
import 'reading_stats_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ReadingStatsLocalizations
/// returned by `ReadingStatsLocalizations.of(context)`.
///
/// Applications need to include `ReadingStatsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/reading_stats_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ReadingStatsLocalizations.localizationsDelegates,
///   supportedLocales: ReadingStatsLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ReadingStatsLocalizations.supportedLocales
/// property.
abstract class ReadingStatsLocalizations {
  ReadingStatsLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ReadingStatsLocalizations of(BuildContext context) {
    return Localizations.of<ReadingStatsLocalizations>(
      context,
      ReadingStatsLocalizations,
    )!;
  }

  static const LocalizationsDelegate<ReadingStatsLocalizations> delegate =
      _ReadingStatsLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Title of the reading stats page.
  ///
  /// In en, this message translates to:
  /// **'Reading stats'**
  String get title;

  /// Heading shown when the shelf is empty.
  ///
  /// In en, this message translates to:
  /// **'Nothing to count yet'**
  String get emptyTitle;

  /// Explains how to get stats.
  ///
  /// In en, this message translates to:
  /// **'Add a few books to your shelf to see your stats.'**
  String get emptyMessage;

  /// Button that opens Discover from the empty stats page.
  ///
  /// In en, this message translates to:
  /// **'Find a book'**
  String get findABook;

  /// Heading of the yearly goal card.
  ///
  /// In en, this message translates to:
  /// **'{year} reading goal'**
  String goalTitle(int year);

  /// Books finished out of the yearly goal.
  ///
  /// In en, this message translates to:
  /// **'{read} of {goal, plural, =1{1 book} other{{goal} books}}'**
  String goalProgress(int read, int goal);

  /// How many books are left to reach the goal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 book to go} other{{count} books to go}}'**
  String booksToGo(int count);

  /// Shown once the yearly goal is met.
  ///
  /// In en, this message translates to:
  /// **'Goal reached. Nice work.'**
  String get goalReached;

  /// Label under the average rating figure.
  ///
  /// In en, this message translates to:
  /// **'Avg rating'**
  String get averageRating;

  /// Heading of the monthly chart.
  ///
  /// In en, this message translates to:
  /// **'Finished by month'**
  String get finishedByMonth;
}

class _ReadingStatsLocalizationsDelegate
    extends LocalizationsDelegate<ReadingStatsLocalizations> {
  const _ReadingStatsLocalizationsDelegate();

  @override
  Future<ReadingStatsLocalizations> load(Locale locale) {
    return SynchronousFuture<ReadingStatsLocalizations>(
      lookupReadingStatsLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_ReadingStatsLocalizationsDelegate old) => false;
}

ReadingStatsLocalizations lookupReadingStatsLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ReadingStatsLocalizationsEn();
    case 'es':
      return ReadingStatsLocalizationsEs();
  }

  throw FlutterError(
    'ReadingStatsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
