import 'package:book_details/book_details.dart';
import 'package:book_details_widgetbook/fakes.dart';
import 'package:core_books/core_books.dart';
import 'package:core_books/fakes.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Each use case is the whole flow, live: add the book to a shelf, write a
// review, tap a subject or the back button. They only differ in where they
// start, and every one has the same knobs.

@widgetbook.UseCase(
  name: 'Full details',
  type: BookDetailsFlow,
  path: '[Book details]',
)
Widget fullDetails(BuildContext context) =>
    _bookDetails(context, book: SampleBooks.dune);

@widgetbook.UseCase(
  name: 'Sparse details',
  type: BookDetailsFlow,
  path: '[Book details]',
)
Widget sparseDetails(BuildContext context) =>
    _bookDetails(context, book: SampleBooks.untitled);

@widgetbook.UseCase(
  name: 'Slow catalogue',
  type: BookDetailsFlow,
  path: '[Book details]',
)
Widget slowCatalogue(BuildContext context) => _bookDetails(
  context,
  book: SampleBooks.dune,
  catalog: CatalogBehaviour.slow,
);

@widgetbook.UseCase(
  name: 'Offline with a saved copy',
  type: BookDetailsFlow,
  path: '[Book details]',
)
Widget offlineWithSavedCopy(BuildContext context) => _bookDetails(
  context,
  book: SampleBooks.dune,
  catalog: CatalogBehaviour.offline,
  shelf: ShelfStart.reading,
);

@widgetbook.UseCase(
  name: 'Not found',
  type: BookDetailsFlow,
  path: '[Book details]',
)
Widget notFound(BuildContext context) => _bookDetails(
  context,
  book: SampleBooks.dune,
  catalog: CatalogBehaviour.notFound,
);

/// What is on the shelf when the flow opens.
enum ShelfStart {
  none('Not on the shelf'),
  reading('Reading'),
  reviewed('Read, with a review');

  new(this.label);

  final String label;

  ShelfEntry? entryFor(Book book) => switch (this) {
    ShelfStart.none => null,
    ShelfStart.reading => ShelfEntry(
      book: book,
      status: ReadingStatus.reading,
      updatedAt: DateTime(2026, 10),
    ),
    ShelfStart.reviewed => ShelfEntry(
      book: book,
      status: ReadingStatus.read,
      updatedAt: DateTime(2026, 10),
      rating: 4,
      review: 'Slow to start, then impossible to put down.',
    ),
  };
}

/// The flow, with knobs for everything the sandbox's control panel had.
///
/// The book, the catalogue and the shelf decide where the flow starts, so
/// changing one opens it afresh. The review step and failing saves are read
/// as the flow goes, so they change while it runs: switch off the review
/// step on the choose a shelf page, then pick Read.
Widget _bookDetails(
  BuildContext context, {
  required Book book,
  CatalogBehaviour catalog = CatalogBehaviour.loads,
  ShelfStart shelf = ShelfStart.none,
}) {
  final knobs = context.knobs;
  final start = (
    knobs.object.dropdown(
      label: 'Book',
      options: const [SampleBooks.dune, SampleBooks.untitled],
      initialOption: book,
      labelBuilder: (book) => book.title,
    ),
    knobs.object.dropdown(
      label: 'Catalogue',
      options: CatalogBehaviour.values,
      initialOption: catalog,
      labelBuilder: (behaviour) => switch (behaviour) {
        CatalogBehaviour.loads => 'Loads',
        CatalogBehaviour.slow => 'Slow (3 seconds)',
        CatalogBehaviour.notFound => 'Not found',
        CatalogBehaviour.offline => 'Offline',
      },
    ),
    knobs.object.dropdown(
      label: 'On the shelf',
      options: ShelfStart.values,
      initialOption: shelf,
      labelBuilder: (shelf) => shelf.label,
    ),
  );
  final live = (
    knobs.boolean(
      label: 'Review step',
      description: 'The bookReviews feature flag',
      initialValue: true,
    ),
    knobs.boolean(label: 'Saving fails'),
  );

  return FakeSetup(
    value: live,
    apply: () {
      Fakes.flags.set(FeatureFlag.bookReviews, enabled: live.$1);
      Fakes.library.failWrites = live.$2;
    },
    child: FakeSetup(
      value: start,
      apply: () {
        Fakes.catalog.behaviour = start.$2;
        Fakes.library.seed([?start.$3.entryFor(start.$1)]);
      },
      child: BookDetailsFlow(key: ValueKey(start), workId: start.$1.workId),
    ),
  );
}
