import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'discover_localizations_en.dart';
import 'discover_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of DiscoverLocalizations
/// returned by `DiscoverLocalizations.of(context)`.
///
/// Applications need to include `DiscoverLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/discover_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: DiscoverLocalizations.localizationsDelegates,
///   supportedLocales: DiscoverLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the DiscoverLocalizations.supportedLocales
/// property.
abstract class DiscoverLocalizations {
  DiscoverLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static DiscoverLocalizations of(BuildContext context) {
    return Localizations.of<DiscoverLocalizations>(
      context,
      DiscoverLocalizations,
    )!;
  }

  static const LocalizationsDelegate<DiscoverLocalizations> delegate =
      _DiscoverLocalizationsDelegate();

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

  /// Title of the Discover page.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get title;

  /// Hint in the search field.
  ///
  /// In en, this message translates to:
  /// **'Title, author or subject'**
  String get searchHint;

  /// Tooltip on the button that clears the search.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearSearch;

  /// Heading shown before the user searches.
  ///
  /// In en, this message translates to:
  /// **'Find your next book'**
  String get idleTitle;

  /// Explains what can be searched.
  ///
  /// In en, this message translates to:
  /// **'Search Open Library by title, author or subject.'**
  String get idleMessage;

  /// Heading shown when a search finds nothing.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get noMatchesTitle;

  /// Explains that a search found nothing. The placeholder is what the user searched for.
  ///
  /// In en, this message translates to:
  /// **'Nothing on Open Library matched \"{query}\".'**
  String noMatchesMessage(String query);

  /// Heading above the list of trending books.
  ///
  /// In en, this message translates to:
  /// **'Trending today'**
  String get trendingToday;
}

class _DiscoverLocalizationsDelegate
    extends LocalizationsDelegate<DiscoverLocalizations> {
  const _DiscoverLocalizationsDelegate();

  @override
  Future<DiscoverLocalizations> load(Locale locale) {
    return SynchronousFuture<DiscoverLocalizations>(
      lookupDiscoverLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_DiscoverLocalizationsDelegate old) => false;
}

DiscoverLocalizations lookupDiscoverLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return DiscoverLocalizationsEn();
    case 'es':
      return DiscoverLocalizationsEs();
  }

  throw FlutterError(
    'DiscoverLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
