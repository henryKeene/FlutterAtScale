import 'package:core_design_system/core_design_system.dart';
import 'package:core_design_system_widgetbook/widgetbook.directories.g.dart';
import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// The design system's sandbox: every token and component, in every theme
/// mode.
@widgetbook.App()
class DesignSystemWidgetbook extends StatelessWidget {
  const new({this.initialRoute = '/', super.key});

  /// Where to open, such as `/?path=components/tag/tones`.
  final String initialRoute;

  @override
  Widget build(BuildContext context) => BookshelfWidgetbook(
    initialRoute: initialRoute,
    directories: directories,
    viewports: BookshelfWidgetbook.components,
    locales: CoreDesignSystemLocalizations.supportedLocales,
    localizationsDelegates: const [
      ...GlobalMaterialLocalizations.delegates,
      CoreDesignSystemLocalizations.delegate,
    ],
  );
}
