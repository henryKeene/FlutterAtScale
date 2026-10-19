import 'package:bookshelf/app/view/app.dart';
import 'package:bookshelf/di/di_initializer.dart' as di;
import 'package:core_config/core_config.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('flipping a flag in developer options reshapes the app', (
    tester,
  ) async {
    await di.initialize(AppConfig.forEnvironment(AppEnvironment.development));
    await getIt<IFeatureFlagService>().clearOverrides();
    await getIt<ILocaleService>().setLocale(AppLocales.english);
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('My books'), findsNWidgets(2));
    expect(find.text('Stats'), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Developer options'));
    await tester.pumpAndSettle();

    final readingStats = find.ancestor(
      of: find.text(FeatureFlag.readingStats.title),
      matching: find.byType(ListTile),
    );
    await tester.tap(
      find.descendant(of: readingStats, matching: find.byType(Switch)),
    );
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: readingStats, matching: find.text('Override')),
      findsOneWidget,
    );

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('Stats'), findsNothing);

    await getIt<IFeatureFlagService>().clearOverrides();
    await tester.pumpAndSettle();

    expect(find.text('Stats'), findsOneWidget);
  });
}
