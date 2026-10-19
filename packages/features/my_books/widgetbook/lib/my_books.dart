import 'package:core_books/core_books.dart';
import 'package:core_books/fakes.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/my_books.dart';
import 'package:my_books_widgetbook/fakes.dart';
import 'package:my_books_widgetbook/sample_shelf.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Loading', type: MyBooksFlow, path: '[My books]')
Widget myBooksLoading(BuildContext context) =>
    const _MyBooks(behaviour: ShelfBehaviour.neverLoads);

@widgetbook.UseCase(name: 'Empty shelf', type: MyBooksFlow, path: '[My books]')
Widget myBooksEmpty(BuildContext context) => const _MyBooks();

/// The screen is live: tap the filters and the books. Both knobs change
/// the fakes while it runs, so the filter you picked stays picked.
@widgetbook.UseCase(name: 'Shelf', type: MyBooksFlow, path: '[My books]')
Widget myBooksShelf(BuildContext context) {
  final books = context.knobs.int.slider(
    label: 'Books on the shelf',
    initialValue: sampleShelf.length,
    min: 1,
    max: sampleShelf.length,
  );
  final grid = context.knobs.boolean(
    label: 'Grid layout',
    description: 'The shelfGrid feature flag',
  );

  return _MyBooks(entries: sampleShelf.take(books).toList(), grid: grid);
}

@widgetbook.UseCase(name: 'Offline', type: MyBooksFlow, path: '[My books]')
Widget myBooksOffline(BuildContext context) =>
    const _MyBooks(behaviour: ShelfBehaviour.fails);

/// My books, with the shelf and flags a use case picks.
///
/// How the shelf answers decides where the screen starts, so changing it
/// opens the screen afresh with a new cubit. What is on the shelf and the
/// grid flag are watched as the screen runs, so they change in place.
class _MyBooks extends StatelessWidget {
  const new({
    this.behaviour = ShelfBehaviour.loads,
    this.entries = const [],
    this.grid = false,
  });

  final ShelfBehaviour behaviour;

  /// Always the first books of [sampleShelf], so their count tells them
  /// apart.
  final List<ShelfEntry> entries;

  final bool grid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeatureFlagsCubit(Fakes.flags),
      child: FakeSetup(
        value: (entries.length, grid),
        apply: () {
          Fakes.library.seed(entries);
          Fakes.flags.set(FeatureFlag.shelfGrid, enabled: grid);
        },
        child: FakeSetup(
          value: behaviour,
          apply: () => Fakes.library.behaviour = behaviour,
          child: MyBooksFlow(key: ValueKey(behaviour)),
        ),
      ),
    );
  }
}
