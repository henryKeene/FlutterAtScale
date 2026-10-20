import 'package:book_details_widgetbook/widgetbook.directories.g.dart'
    as book_details;
import 'package:bookshelf_widgetbook/catalogue.dart';
import 'package:core_design_system_widgetbook/widgetbook.directories.g.dart'
    as design_system;
import 'package:core_di/core_di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books_widgetbook/widgetbook.directories.g.dart' as my_books;
import 'package:widgetbook/widgetbook.dart';

Future<void> open(WidgetTester tester, String path) async {
  tester.view
    ..physicalSize = const Size(1600, 1200)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final route = Uri(path: '/', queryParameters: {'path': path}).toString();
  // Widgetbook only reads its route when it starts, so each open gets a
  // fresh one.
  await tester.pumpWidget(Catalogue(key: ValueKey(route), initialRoute: route));
  await tester.pump();
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
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
}
