import 'package:core_design_system/core_design_system.dart';
import 'package:core_widgetbook/src/navigation_log.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

/// Widgetbook, set up the way every Bookshelf Widgetbook needs it.
///
/// Each package's Widgetbook passes its generated [directories] and the
/// strings it shows. This adds the rest:
///
/// - a theme for every mode in `BookshelfColors.modes`
/// - every locale in [locales]
/// - device viewports, text scale, alignment and the widget inspector
///
/// Widgetbook is built on the SDK's Material library and Bookshelf on
/// `material_ui`, whose `Theme` and `ThemeData` are different types, so
/// Widgetbook's own Material theme addon cannot take our themes. Each use
/// case runs in a `material_ui` app of its own, and a generic [ThemeAddon]
/// applies the theme.
class BookshelfWidgetbook extends StatelessWidget {
  const new({
    required this.directories,
    required this.localizationsDelegates,
    required this.locales,
    this.viewports = screens,
    this.initialRoute = '/',
    super.key,
  });

  /// Phones first, for whole screens and flows.
  static const List<ViewportData> screens = [
    IosViewports.iPhone13,
    AndroidViewports.samsungGalaxyS20,
    Viewports.none,
  ];

  /// No device first, for tokens and components.
  static const List<ViewportData> components = [
    Viewports.none,
    IosViewports.iPhone13,
    AndroidViewports.samsungGalaxyS20,
  ];

  final List<WidgetbookNode> directories;
  final List<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final List<Locale> locales;

  /// The first one is where Widgetbook opens.
  final List<ViewportData> viewports;

  /// Where to open, such as `/?path=book-details/bookdetailsflow/not-found`.
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      initialRoute: initialRoute,
      directories: directories,
      appBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        scaffoldMessengerKey: navigationLogMessenger,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: locales,
        home: child,
      ),
      addons: [
        ViewportAddon(viewports),
        ThemeAddon<ThemeData>(
          themes: [
            for (final MapEntry(key: mode, value: colors)
                in BookshelfColors.modes.entries)
              WidgetbookTheme(name: _title(mode), data: AppTheme.build(colors)),
          ],
          themeBuilder: (context, theme, child) => Theme(
            data: theme,
            child: Material(color: theme.colorScheme.surface, child: child),
          ),
        ),
        LocalizationAddon(
          locales: locales,
          localizationsDelegates: localizationsDelegates,
        ),
        TextScaleAddon(),
        AlignmentAddon(),
        InspectorAddon(),
      ],
    );
  }
}

/// `high-contrast` becomes `High contrast`.
String _title(String mode) {
  final words = mode.replaceAll('-', ' ');
  return words[0].toUpperCase() + words.substring(1);
}
