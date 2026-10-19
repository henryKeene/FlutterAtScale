import 'package:core_design_system/src/tokens/tokens.dart';
import 'package:material_ui/material_ui.dart';

/// Builds Flutter's [ThemeData] from the design tokens.
///
/// The tokens say what the colours, type and shapes are. This class decides
/// how Material's components use them, which makes it the one place where the
/// design language meets Material. It has no values of its own, so a change
/// to a token reaches every component without touching it.
abstract final class AppTheme {
  static ThemeData light() => build(BookshelfColors.light);

  static ThemeData dark() => build(BookshelfColors.dark);

  /// The theme for one set of colour tokens, such as each mode.
  static ThemeData build(BookshelfColors colors) {
    final scheme = colors.toColorScheme();

    return ThemeData(
      colorScheme: scheme,
      textTheme: BookshelfTypography.toTextTheme(),
      extensions: [colors],
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.l),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.xl),
          borderSide: BorderSide.none,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: Spacing.m),
      ),
    );
  }
}
