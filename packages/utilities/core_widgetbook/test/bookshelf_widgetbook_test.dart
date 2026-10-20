import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  /// Opens a use case that reports whether animations run in it.
  Future<bool> animates(WidgetTester tester, {required bool preview}) async {
    tester.view
      ..physicalSize = const Size(1600, 1200)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    bool? enabled;
    final route = Uri(
      path: '/',
      queryParameters: {'path': 'spinner/default', if (preview) 'preview': ''},
    );
    await tester.pumpWidget(
      BookshelfWidgetbook(
        initialRoute: route.toString(),
        locales: const [Locale('en')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        directories: [
          WidgetbookComponent(
            name: 'Spinner',
            useCases: [
              WidgetbookUseCase(
                name: 'Default',
                builder: (context) {
                  enabled = TickerMode.valuesOf(context).enabled;
                  return const SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
    await tester.pump();

    expect(enabled, isNotNull, reason: 'the use case should have opened');
    return enabled!;
  }

  testWidgets('runs animations in Widgetbook', (tester) async {
    expect(await animates(tester, preview: false), isTrue);
  });

  testWidgets('pauses animations in the preview Widgetbook Cloud snapshots', (
    tester,
  ) async {
    expect(await animates(tester, preview: true), isFalse);
  });
}
