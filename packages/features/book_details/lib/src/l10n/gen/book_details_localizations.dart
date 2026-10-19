import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'book_details_localizations_en.dart';
import 'book_details_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of BookDetailsLocalizations
/// returned by `BookDetailsLocalizations.of(context)`.
///
/// Applications need to include `BookDetailsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/book_details_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: BookDetailsLocalizations.localizationsDelegates,
///   supportedLocales: BookDetailsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the BookDetailsLocalizations.supportedLocales
/// property.
abstract class BookDetailsLocalizations {
  BookDetailsLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static BookDetailsLocalizations of(BuildContext context) {
    return Localizations.of<BookDetailsLocalizations>(
      context,
      BookDetailsLocalizations,
    )!;
  }

  static const LocalizationsDelegate<BookDetailsLocalizations> delegate =
      _BookDetailsLocalizationsDelegate();

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

  /// Tooltip on the button that removes the book from the shelf.
  ///
  /// In en, this message translates to:
  /// **'Remove from shelf'**
  String get removeFromShelf;

  /// Shown when the book comes from the shelf because Open Library is unreachable.
  ///
  /// In en, this message translates to:
  /// **'Showing your saved copy'**
  String get savedCopyTitle;

  /// Explains why the saved copy is shown.
  ///
  /// In en, this message translates to:
  /// **'Open Library could not be reached.'**
  String get savedCopyMessage;

  /// Heading above the book description.
  ///
  /// In en, this message translates to:
  /// **'About this book'**
  String get aboutThisBook;

  /// Heading above the subject chips.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjects;

  /// Button that starts adding the book to a shelf.
  ///
  /// In en, this message translates to:
  /// **'Add to shelf'**
  String get addToShelf;

  /// Button that moves a shelved book to another shelf.
  ///
  /// In en, this message translates to:
  /// **'Change shelf'**
  String get changeShelf;

  /// Confirmation after a book is shelved. The placeholder is the shelf name.
  ///
  /// In en, this message translates to:
  /// **'Moved to {shelf}'**
  String movedTo(String shelf);

  /// When the book first came out.
  ///
  /// In en, this message translates to:
  /// **'First published {year}'**
  String firstPublished(int year);

  /// Heading of the review card and title of the review page.
  ///
  /// In en, this message translates to:
  /// **'Your review'**
  String get yourReview;

  /// Skips writing a review.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Question at the top of the review page. The placeholder is the book title.
  ///
  /// In en, this message translates to:
  /// **'How was {title}?'**
  String reviewPrompt(String title);

  /// Hint in the review text field.
  ///
  /// In en, this message translates to:
  /// **'What did you think?'**
  String get reviewHint;

  /// Button that saves the rating and review.
  ///
  /// In en, this message translates to:
  /// **'Save review'**
  String get saveReview;
}

class _BookDetailsLocalizationsDelegate
    extends LocalizationsDelegate<BookDetailsLocalizations> {
  const _BookDetailsLocalizationsDelegate();

  @override
  Future<BookDetailsLocalizations> load(Locale locale) {
    return SynchronousFuture<BookDetailsLocalizations>(
      lookupBookDetailsLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_BookDetailsLocalizationsDelegate old) => false;
}

BookDetailsLocalizations lookupBookDetailsLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return BookDetailsLocalizationsEn();
    case 'es':
      return BookDetailsLocalizationsEs();
  }

  throw FlutterError(
    'BookDetailsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
