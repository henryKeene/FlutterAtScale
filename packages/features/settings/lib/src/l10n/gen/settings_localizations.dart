import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'settings_localizations_en.dart';
import 'settings_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SettingsLocalizations
/// returned by `SettingsLocalizations.of(context)`.
///
/// Applications need to include `SettingsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/settings_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SettingsLocalizations.localizationsDelegates,
///   supportedLocales: SettingsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the SettingsLocalizations.supportedLocales
/// property.
abstract class SettingsLocalizations {
  SettingsLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SettingsLocalizations of(BuildContext context) {
    return Localizations.of<SettingsLocalizations>(
      context,
      SettingsLocalizations,
    )!;
  }

  static const LocalizationsDelegate<SettingsLocalizations> delegate =
      _SettingsLocalizationsDelegate();

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

  /// Title of the settings page.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get title;

  /// Heading of the theme section.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Theme option that follows the device.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Light theme option.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Dark theme option.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Heading of the language section.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language option that follows the device.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// Heading of the reading goal section.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get readingSection;

  /// Label of the yearly reading goal setting.
  ///
  /// In en, this message translates to:
  /// **'Yearly goal'**
  String get yearlyGoal;

  /// The current yearly goal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 book} other{{count} books}}'**
  String goalBooks(int count);

  /// Tooltip on the button that lowers the goal.
  ///
  /// In en, this message translates to:
  /// **'Fewer'**
  String get fewerBooks;

  /// Tooltip on the button that raises the goal.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreBooks;

  /// Heading of the about section.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Label of the build environment row.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get environment;

  /// Entry point to the debug menu.
  ///
  /// In en, this message translates to:
  /// **'Developer options'**
  String get developerOptions;

  /// Explains what the developer options contain.
  ///
  /// In en, this message translates to:
  /// **'Feature flags and overrides'**
  String get developerOptionsSubtitle;

  /// Name of the development build.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get environmentDevelopment;

  /// Name of the staging build.
  ///
  /// In en, this message translates to:
  /// **'Staging'**
  String get environmentStaging;

  /// Name of the production build.
  ///
  /// In en, this message translates to:
  /// **'Production'**
  String get environmentProduction;
}

class _SettingsLocalizationsDelegate
    extends LocalizationsDelegate<SettingsLocalizations> {
  const _SettingsLocalizationsDelegate();

  @override
  Future<SettingsLocalizations> load(Locale locale) {
    return SynchronousFuture<SettingsLocalizations>(
      lookupSettingsLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_SettingsLocalizationsDelegate old) => false;
}

SettingsLocalizations lookupSettingsLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SettingsLocalizationsEn();
    case 'es':
      return SettingsLocalizationsEs();
  }

  throw FlutterError(
    'SettingsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
