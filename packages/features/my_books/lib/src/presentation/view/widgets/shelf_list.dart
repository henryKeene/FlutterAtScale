import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/src/presentation/cubits/my_books_cubit/my_books_cubit.dart';

class ShelfList extends StatelessWidget {
  const new({required this.entries, super.key});

  final List<ShelfEntry> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: Spacing.l),
      itemCount: entries.length,
      itemBuilder: (context, index) => ShelfListTile(entry: entries[index]),
    );
  }
}

class ShelfListTile extends StatelessWidget {
  const new({required this.entry, super.key});

  final ShelfEntry entry;

  @override
  Widget build(BuildContext context) {
    final rating = entry.rating;

    return BookListTile(
      title: entry.book.title,
      subtitle: entry.book.byline(context),
      coverUrl: entry.book.coverUrl(CoverSize.medium),
      onTap: () => context.read<MyBooksCubit>().openBook(entry.book),
      footer: rating == null
          ? null
          : RatingStars(rating: rating, size: Sizes.iconXs),
    );
  }
}
