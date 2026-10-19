import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'my_books_localizations_en.dart';
import 'my_books_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of MyBooksLocalizations
/// returned by `MyBooksLocalizations.of(context)`.
///
/// Applications need to include `MyBooksLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/my_books_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MyBooksLocalizations.localizationsDelegates,
///   supportedLocales: MyBooksLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the MyBooksLocalizations.supportedLocales
/// property.
abstract class MyBooksLocalizations {
  MyBooksLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MyBooksLocalizations of(BuildContext context) {
    return Localizations.of<MyBooksLocalizations>(
      context,
      MyBooksLocalizations,
    )!;
  }

  static const LocalizationsDelegate<MyBooksLocalizations> delegate =
      _MyBooksLocalizationsDelegate();

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

  /// Title of the My books page.
  ///
  /// In en, this message translates to:
  /// **'My books'**
  String get title;

  /// Heading shown when the user has no books at all.
  ///
  /// In en, this message translates to:
  /// **'Your shelf is empty'**
  String get emptyShelfTitle;

  /// Explains how to fill an empty shelf.
  ///
  /// In en, this message translates to:
  /// **'Find a book you are reading or want to read and add it here.'**
  String get emptyShelfMessage;

  /// Button that opens Discover from an empty shelf.
  ///
  /// In en, this message translates to:
  /// **'Find a book'**
  String get findABook;

  /// Heading shown when the selected shelf has no books.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get emptyFilterTitle;

  /// Explains what appears on an empty shelf. The placeholder is the shelf name.
  ///
  /// In en, this message translates to:
  /// **'Books you mark as \"{shelf}\" show up here.'**
  String emptyFilterMessage(String shelf);

  /// Error when the shelf cannot be read.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load your shelf.'**
  String get loadFailed;
}

class _MyBooksLocalizationsDelegate
    extends LocalizationsDelegate<MyBooksLocalizations> {
  const _MyBooksLocalizationsDelegate();

  @override
  Future<MyBooksLocalizations> load(Locale locale) {
    return SynchronousFuture<MyBooksLocalizations>(
      lookupMyBooksLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_MyBooksLocalizationsDelegate old) => false;
}

MyBooksLocalizations lookupMyBooksLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return MyBooksLocalizationsEn();
    case 'es':
      return MyBooksLocalizationsEs();
  }

  throw FlutterError(
    'MyBooksLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
