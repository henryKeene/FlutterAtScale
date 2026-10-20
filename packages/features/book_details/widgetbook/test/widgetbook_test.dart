import 'package:book_details_widgetbook/fakes.dart';
import 'package:book_details_widgetbook/widgetbook.dart';
import 'package:book_details_widgetbook/widgetbook.directories.g.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';

/// Opens a use case the way a link to Widgetbook would, and waits for the
/// catalogue to answer, even when it is slow.
Future<void> open(
  WidgetTester tester,
  String useCase, {
  String mode = 'Light',
  String locale = 'en',
  Map<String, String> knobs = const {},
}) async {
  tester.view
    ..physicalSize = const Size(1600, 1200)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final route = Uri(
    path: '/',
    queryParameters: {
      'path': useCase.contains('/')
          ? useCase
          : 'book-details/bookdetailsflow/$useCase',
      'theme': '{name:$mode}',
      'locale': '{name:$locale}',
      if (knobs.isNotEmpty)
        'knobs':
            '{${[for (final MapEntry(:key, :value) in knobs.entries) '${Uri.encodeComponent(key)}:$value'].join(',')}}',
    },
  );
  await tester.pumpWidget(
    BookDetailsWidgetbook(initialRoute: route.toString()),
  );
  await tester.pump();
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
}

Future<void> tapText(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text));
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => Fakes.register(getIt));

  final useCases = WidgetbookRoot(children: directories).leaves;

  for (final mode in BookshelfColors.modes.keys) {
    for (final useCase in useCases) {
      testWidgets('${useCase.path} builds in $mode mode', (tester) async {
        await open(
          tester,
          useCase.path,
          mode: mode[0].toUpperCase() + mode.substring(1),
        );

        expect(tester.takeException(), isNull);
        expect(find.byType(Scaffold), findsWidgets);
      });
    }
  }

  group('Book details', () {
    testWidgets('falls back to the saved copy when the catalogue is offline', (
      tester,
    ) async {
      await open(tester, 'offline-with-a-saved-copy');

      expect(find.text('Showing your saved copy'), findsOneWidget);
      expect(find.text('Change shelf'), findsOneWidget);
    });

    testWidgets('shows an error when the book does not exist', (tester) async {
      await open(tester, 'not-found');

      expect(find.text("We couldn't find that book."), findsOneWidget);
    });

    testWidgets('skips the review step when the flag is off', (tester) async {
      await open(tester, 'full-details', knobs: {'Review step': 'false'});
      await tapText(tester, 'Add to shelf');
      await tapText(tester, 'Read');

      expect(find.text('Your review'), findsNothing);
      expect(find.text('Moved to Read'), findsOneWidget);
      expect(Fakes.library.entries.single.rating, isNull);
    });

    testWidgets('follows the review flag while the flow runs', (tester) async {
      await open(tester, 'full-details');
      await tapText(tester, 'Add to shelf');

      // What the Review step knob does when you switch it mid-flow.
      Fakes.flags.set(FeatureFlag.bookReviews, enabled: false);
      await tapText(tester, 'Read');

      expect(find.text('Moved to Read'), findsOneWidget);
    });

    testWidgets('reports a failed save without leaving the flow', (
      tester,
    ) async {
      await open(tester, 'full-details', knobs: {'Saving fails': 'true'});
      await tapText(tester, 'Add to shelf');
      await tapText(tester, 'Want to read');

      expect(
        find.text("We couldn't update your shelf. Please try again."),
        findsOneWidget,
      );
      expect(Fakes.library.entries, isEmpty);
    });

    testWidgets('undoes a save from the snack bar', (tester) async {
      await open(tester, 'full-details');
      await tapText(tester, 'Add to shelf');
      await tapText(tester, 'Want to read');
      expect(Fakes.library.entries, hasLength(1));

      await tapText(tester, 'Undo');

      expect(Fakes.library.entries, isEmpty);
      expect(find.text('Add to shelf'), findsOneWidget);
    });

    testWidgets('shows how the feature hands control back', (tester) async {
      await open(tester, 'full-details');

      await tester.tap(find.byType(BackButton));
      await tester.pump();

      expect(find.text('Book details → back()'), findsOneWidget);
    });

    testWidgets('shows where tapping a subject would go', (tester) async {
      await open(tester, 'full-details');
      await tapText(tester, 'Science fiction');

      expect(
        find.text("Book details → searchSubject('Science fiction')"),
        findsOneWidget,
      );
    });

    testWidgets('renders the feature in Spanish from its own ARB files', (
      tester,
    ) async {
      await open(tester, 'offline-with-a-saved-copy', locale: 'es');

      expect(find.text('Mostrando tu copia guardada'), findsOneWidget);
      expect(find.text('Leyendo'), findsOneWidget);
      expect(find.text('Cambiar de estantería'), findsOneWidget);
    });
  });
}
