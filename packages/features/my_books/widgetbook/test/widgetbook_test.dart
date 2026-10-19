import 'package:core_books/fakes.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_di/core_di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books_widgetbook/fakes.dart';
import 'package:my_books_widgetbook/sample_shelf.dart';
import 'package:my_books_widgetbook/widgetbook.dart';
import 'package:my_books_widgetbook/widgetbook.directories.g.dart';
import 'package:widgetbook/widgetbook.dart';

/// Opens a use case the way a link to Widgetbook would.
Future<void> open(
  WidgetTester tester,
  String useCase, {
  String mode = 'Light',
  Map<String, String> knobs = const {},
}) async {
  tester.view
    ..physicalSize = const Size(1600, 1200)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final route = Uri(
    path: '/',
    queryParameters: {
      'path': useCase.contains('/') ? useCase : 'my-books/mybooksflow/$useCase',
      'theme': '{name:$mode}',
      if (knobs.isNotEmpty)
        'knobs':
            '{${[for (final MapEntry(:key, :value) in knobs.entries) '${Uri.encodeComponent(key)}:$value'].join(',')}}',
    },
  );
  await tester.pumpWidget(MyBooksWidgetbook(initialRoute: route.toString()));
  // The loading state spins forever, so pump a while instead of settling.
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
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

  group('My books', () {
    testWidgets('shows a spinner while the shelf loads', (tester) async {
      await open(tester, 'loading');

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('invites you to find a book when the shelf is empty', (
      tester,
    ) async {
      await open(tester, 'empty-shelf');

      expect(find.text('Your shelf is empty'), findsOneWidget);
    });

    testWidgets('explains when the shelf cannot load', (tester) async {
      await open(tester, 'offline');

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('lists the books being read', (tester) async {
      await open(tester, 'shelf');

      expect(find.byType(BookListTile), findsNWidgets(3));
      expect(find.text('Piranesi'), findsOneWidget);
    });

    testWidgets('the grid knob turns on the shelfGrid layout', (tester) async {
      await open(tester, 'shelf', knobs: {'Grid layout': 'true'});

      expect(find.byType(BookListTile), findsNothing);
      expect(find.byType(BookCover), findsNWidgets(3));
    });

    testWidgets('keeps the chosen filter when the shelf changes', (
      tester,
    ) async {
      await open(tester, 'shelf');
      await tester.tap(find.text('Want to read'));
      await tester.pump();
      expect(find.byType(BookListTile), findsNWidgets(3));

      // What the Books on the shelf knob does when you drag it.
      Fakes.library.seed(sampleShelf.take(3));
      await tester.pump();
      await tester.pump();

      expect(find.byType(BookListTile), findsOneWidget);
      expect(find.text('Middlemarch'), findsOneWidget);
    });

    testWidgets('shows where tapping a book would go', (tester) async {
      await open(tester, 'shelf');

      await tester.tap(find.text('Piranesi'));
      await tester.pump();

      expect(
        find.text('My books → openBook(${SampleBooks.piranesi.workId})'),
        findsOneWidget,
      );
    });
  });
}
