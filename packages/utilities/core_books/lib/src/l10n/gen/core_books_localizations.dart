import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'core_books_localizations_en.dart';
import 'core_books_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CoreBooksLocalizations
/// returned by `CoreBooksLocalizations.of(context)`.
///
/// Applications need to include `CoreBooksLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/core_books_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CoreBooksLocalizations.localizationsDelegates,
///   supportedLocales: CoreBooksLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the CoreBooksLocalizations.supportedLocales
/// property.
abstract class CoreBooksLocalizations {
  CoreBooksLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CoreBooksLocalizations of(BuildContext context) {
    return Localizations.of<CoreBooksLocalizations>(
      context,
      CoreBooksLocalizations,
    )!;
  }

  static const LocalizationsDelegate<CoreBooksLocalizations> delegate =
      _CoreBooksLocalizationsDelegate();

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

  /// Shelf for books the user is reading right now.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get readingStatusReading;

  /// Shelf for books the user plans to read.
  ///
  /// In en, this message translates to:
  /// **'Want to read'**
  String get readingStatusWantToRead;

  /// Shelf for books the user has finished.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get readingStatusRead;

  /// Shown in place of an author when a book has none.
  ///
  /// In en, this message translates to:
  /// **'Unknown author'**
  String get unknownAuthor;

  /// Error when the Open Library catalogue cannot be reached.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t reach Open Library. Check your connection and try again.'**
  String get catalogUnavailable;

  /// Error when Open Library has no book with the requested id.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find that book.'**
  String get bookNotFound;

  /// Error when a change to the user's shelf cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t update your shelf. Please try again.'**
  String get libraryFailure;
}

class _CoreBooksLocalizationsDelegate
    extends LocalizationsDelegate<CoreBooksLocalizations> {
  const _CoreBooksLocalizationsDelegate();

  @override
  Future<CoreBooksLocalizations> load(Locale locale) {
    return SynchronousFuture<CoreBooksLocalizations>(
      lookupCoreBooksLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_CoreBooksLocalizationsDelegate old) => false;
}

CoreBooksLocalizations lookupCoreBooksLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return CoreBooksLocalizationsEn();
    case 'es':
      return CoreBooksLocalizationsEs();
  }

  throw FlutterError(
    'CoreBooksLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
