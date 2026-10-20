import 'package:book_details_widgetbook/widgetbook.directories.g.dart'
    as book_details;
import 'package:bookshelf_widgetbook/catalogue.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_design_system_widgetbook/widgetbook.directories.g.dart'
    as design_system;
import 'package:core_di/core_di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books_widgetbook/widgetbook.directories.g.dart' as my_books;
import 'package:widgetbook/widgetbook.dart';

/// Opens [path], or its [preview], the way Widgetbook Cloud opens it to take
/// a snapshot, and gives the fakes [wait] to answer: the slow catalogue
/// takes three seconds. A use case that animates forever, such as a loading
/// spinner, never settles outside a preview, so pass `settle: false` for it.
Future<void> open(
  WidgetTester tester,
  String path, {
  bool settle = true,
  bool preview = false,
  Duration wait = const Duration(seconds: 4),
}) async {
  tester.view
    ..physicalSize = const Size(1600, 1200)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final route = Uri(
    path: '/',
    queryParameters: {'path': path, if (preview) 'preview': ''},
  ).toString();
  // Widgetbook only reads its route when it starts, so each open gets a
  // fresh one.
  await tester.pumpWidget(Catalogue(key: ValueKey(route), initialRoute: route));
  await tester.pump();
  await tester.pump(wait);
  if (settle) await tester.pumpAndSettle();
}

int useCasesIn(List<WidgetbookNode> directories) =>
    WidgetbookRoot(children: directories).leaves.length;

/// The catalogue only puts the Widgetbooks together, and each package tests
/// its own use cases, so this checks that they still work side by side.
void main() {
  setUpAll(() => registerFakes(getIt));

  test('has every use case from every Widgetbook', () {
    final all = WidgetbookRoot(
      children: [
        ...design_system.directories,
        ...book_details.directories,
        ...my_books.directories,
      ],
    ).leaves;

    expect(
      all,
      hasLength(
        useCasesIn(design_system.directories) +
            useCasesIn(book_details.directories) +
            useCasesIn(my_books.directories),
      ),
    );
    expect(all.map((it) => it.path.split('/').first).toSet(), {
      'components',
      'tokens',
      'book-details',
      'my-books',
    });
  });

  testWidgets('opens the design system', (tester) async {
    await open(tester, 'components/tag/tones');

    expect(tester.takeException(), isNull);
    expect(find.text('Remote'), findsWidgets);
  });

  testWidgets('opens a feature flow', (tester) async {
    await open(tester, 'book-details/bookdetailsflow/full-details');

    expect(tester.takeException(), isNull);
    expect(find.text('About this book'), findsOneWidget);
  });

  testWidgets('each feature sets up the shared fakes for itself', (
    tester,
  ) async {
    // Book details shelves Dune on the shared fake shelf...
    await open(tester, 'book-details/bookdetailsflow/full-details');
    await tester.tap(find.text('Add to shelf'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Want to read'));
    await tester.pumpAndSettle();

    // ...and My books still shows the shelf its own use case asks for.
    await open(tester, 'my-books/mybooksflow/shelf');

    expect(tester.takeException(), isNull);
    expect(find.text('Piranesi'), findsOneWidget);
    expect(find.text('Dune'), findsNothing);
  });

  testWidgets('a flow is not stuck with how another left the fakes', (
    tester,
  ) async {
    // My books' Loading use case leaves the shared shelf never loading...
    await open(tester, 'my-books/mybooksflow/loading', settle: false);

    // ...but book details still sees the book it shelves.
    await open(tester, 'book-details/bookdetailsflow/full-details');
    await tester.tap(find.text('Add to shelf'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Want to read'));
    await tester.pumpAndSettle();

    expect(find.text('Change shelf'), findsOneWidget);
  });

  // The catalogue is what Widgetbook Cloud snapshots, moments after each use
  // case opens. Anything still moving then is caught at a different frame in
  // every build, and the review flags it as changed when nothing did.
  group('holds still for Widgetbook Cloud', () {
    final useCases = WidgetbookRoot(
      children: [
        ...design_system.directories,
        ...book_details.directories,
        ...my_books.directories,
      ],
    ).leaves;

    for (final useCase in useCases) {
      testWidgets(useCase.path, (tester) async {
        await open(
          tester,
          useCase.path,
          preview: true,
          wait: const Duration(milliseconds: 500),
          settle: false,
        );
        // Draw what the fakes answered while it waited.
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(
          tester.binding.hasScheduledFrame,
          isFalse,
          reason: 'something on it is still moving',
        );

        // Let the slow fakes answer, so no timer outlives the test.
        await tester.pump(const Duration(seconds: 4));
      });
    }

    testWidgets('and shows a loading screen as a still ring', (tester) async {
      await open(
        tester,
        'my-books/mybooksflow/loading',
        preview: true,
        settle: false,
      );

      expect(
        tester
            .widget<CircularProgressIndicator>(
              find.byType(CircularProgressIndicator),
            )
            .value,
        LoadingIndicator.pausedValue,
      );
    });
  });
}
