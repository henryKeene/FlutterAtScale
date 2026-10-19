import 'package:core_design_system/core_design_system.dart';
import 'package:core_design_system_widgetbook/widgetbook.dart';
import 'package:core_design_system_widgetbook/widgetbook.directories.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

/// Opens every use case in every mode, the way a reviewer clicking through
/// Widgetbook would, and fails if any of them throws.
void main() {
  final useCases = WidgetbookRoot(children: directories).leaves;

  test('catalogues the tokens and the components', () {
    final paths = useCases.map((it) => it.path.split('/').first).toSet();

    expect(paths, {'tokens', 'components'});
  });

  for (final MapEntry(key: mode, value: colors)
      in BookshelfColors.modes.entries) {
    for (final useCase in useCases) {
      testWidgets('${useCase.path} builds in $mode mode', (tester) async {
        tester.view
          ..physicalSize = const Size(1600, 1200)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        final route = Uri(
          path: '/',
          queryParameters: {
            'path': useCase.path,
            'theme': '{name:${mode[0].toUpperCase()}${mode.substring(1)}}',
          },
        );
        await tester.pumpWidget(
          DesignSystemWidgetbook(initialRoute: route.toString()),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(
          find.byWidgetPredicate(
            (widget) => widget is Material && widget.color == colors.surface,
          ),
          findsOneWidget,
          reason: 'the use case should sit on the $mode surface',
        );
      });
    }
  }
}
