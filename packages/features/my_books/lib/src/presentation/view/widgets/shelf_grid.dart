import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/src/presentation/cubits/my_books_cubit/my_books_cubit.dart';

class ShelfGrid extends StatelessWidget {
  const new({required this.entries, super.key});

  final List<ShelfEntry> entries;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.l),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 140,
        childAspectRatio: 0.46,
        mainAxisSpacing: Spacing.m,
        crossAxisSpacing: Spacing.m,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) => ShelfGridTile(entry: entries[index]),
    );
  }
}

class ShelfGridTile extends StatelessWidget {
  const new({required this.entry, super.key});

  final ShelfEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(Radii.s),
      onTap: () => context.read<MyBooksCubit>().openBook(entry.book),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookCover(
            url: entry.book.coverUrl(CoverSize.medium),
            radius: Radii.s,
          ),
          const Gap(Spacing.s),
          Text(
            entry.book.title,
            style: theme.textTheme.labelLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            entry.book.byline(context),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
