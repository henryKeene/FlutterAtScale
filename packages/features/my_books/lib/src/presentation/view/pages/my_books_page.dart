import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/src/l10n/l10n.dart';
import 'package:my_books/src/presentation/cubits/my_books_cubit/my_books_cubit.dart';
import 'package:my_books/src/presentation/view/widgets/shelf_filter.dart';
import 'package:my_books/src/presentation/view/widgets/shelf_grid.dart';
import 'package:my_books/src/presentation/view/widgets/shelf_list.dart';

class MyBooksPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.title)),
      body: BlocBuilder<MyBooksCubit, MyBooksState>(
        builder: (context, state) => switch (state) {
          MyBooksLoading() => const Center(child: LoadingIndicator()),
          MyBooksFailure() => ErrorView(message: context.l10n.loadFailed),
          MyBooksLoaded(entries: []) => const _EmptyLibrary(),
          MyBooksLoaded() => _Shelf(state: state),
        },
      ),
    );
  }
}

class _EmptyLibrary extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EmptyState(
      icon: Icons.auto_stories_outlined,
      title: l10n.emptyShelfTitle,
      message: l10n.emptyShelfMessage,
      action: FilledButton(
        onPressed: context.read<MyBooksCubit>().openDiscover,
        child: Text(l10n.findABook),
      ),
    );
  }
}

class _Shelf extends StatelessWidget {
  const new({required this.state});

  final MyBooksLoaded state;

  @override
  Widget build(BuildContext context) {
    final visible = state.visible;

    return Column(
      children: [
        ShelfFilter(state: state),
        Expanded(
          child: visible.isEmpty
              ? EmptyState(
                  icon: Icons.bookmark_border,
                  title: context.l10n.emptyFilterTitle,
                  message: context.l10n.emptyFilterMessage(
                    state.filter.label(context),
                  ),
                )
              : FeatureGate(
                  flag: FeatureFlag.shelfGrid,
                  fallback: ShelfList(entries: visible),
                  child: ShelfGrid(entries: visible),
                ),
        ),
      ],
    );
  }
}
