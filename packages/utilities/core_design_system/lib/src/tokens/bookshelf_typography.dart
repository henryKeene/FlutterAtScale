import 'package:material_ui/material_ui.dart';

/// The type scale: Material's 15 text styles, which [toTextTheme] turns
/// into the theme's [TextTheme].
abstract final class BookshelfTypography {
  /// Short, important text or numbers on large screens.
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
  );

  /// Short, important text or numbers on large screens.
  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
    letterSpacing: 0,
  );

  /// Short, important text or numbers.
  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
    letterSpacing: 0,
  );

  /// High emphasis text on small screens.
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
    letterSpacing: 0,
  );

  /// Big numbers, such as reading stats.
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
    letterSpacing: 0,
  );

  /// Book titles on the details page.
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0,
  );

  /// Page and empty state titles.
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.27,
    letterSpacing: 0,
  );

  /// Titles in lists, such as a book in search results.
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// Section headers.
  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );

  /// Long passages of text.
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  );

  /// Default body text, such as a book description.
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  );

  /// Supporting text, such as a publish year.
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
  );

  /// Buttons and tabs.
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );

  /// Chips and smaller buttons.
  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.5,
  );

  /// Small labels, such as chart axes and badges.
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.5,
  );

  /// Every text style, by name.
  static const Map<String, TextStyle> tokens = {
    'displayLarge': displayLarge,
    'displayMedium': displayMedium,
    'displaySmall': displaySmall,
    'headlineLarge': headlineLarge,
    'headlineMedium': headlineMedium,
    'headlineSmall': headlineSmall,
    'titleLarge': titleLarge,
    'titleMedium': titleMedium,
    'titleSmall': titleSmall,
    'bodyLarge': bodyLarge,
    'bodyMedium': bodyMedium,
    'bodySmall': bodySmall,
    'labelLarge': labelLarge,
    'labelMedium': labelMedium,
    'labelSmall': labelSmall,
  };

  /// What each token is for.
  static const Map<String, String> descriptions = {
    'displayLarge': 'Short, important text or numbers on large screens.',
    'displayMedium': 'Short, important text or numbers on large screens.',
    'displaySmall': 'Short, important text or numbers.',
    'headlineLarge': 'High emphasis text on small screens.',
    'headlineMedium': 'Big numbers, such as reading stats.',
    'headlineSmall': 'Book titles on the details page.',
    'titleLarge': 'Page and empty state titles.',
    'titleMedium': 'Titles in lists, such as a book in search results.',
    'titleSmall': 'Section headers.',
    'bodyLarge': 'Long passages of text.',
    'bodyMedium': 'Default body text, such as a book description.',
    'bodySmall': 'Supporting text, such as a publish year.',
    'labelLarge': 'Buttons and tabs.',
    'labelMedium': 'Chips and smaller buttons.',
    'labelSmall': 'Small labels, such as chart axes and badges.',
  };

  /// The Material text styles, from the tokens named after them.
  static TextTheme toTextTheme() => const TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
