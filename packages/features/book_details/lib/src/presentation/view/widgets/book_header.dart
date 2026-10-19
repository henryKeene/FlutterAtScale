import 'package:book_details/src/l10n/l10n.dart';
import 'package:book_details/src/presentation/view/reading_status_icon.dart';
import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';

class BookHeader extends StatelessWidget {
  const new({required this.book, this.entry, super.key});

  final Book book;
  final ShelfEntry? entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final year = book.firstPublishYear;
    final entry = this.entry;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Sizes.coverDetail,
          child: BookCover(
            url: book.coverUrl(CoverSize.large),
            radius: Radii.s,
          ),
        ),
        const Gap(Spacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.title, style: theme.textTheme.headlineSmall),
              const Gap(Spacing.xs),
              Text(
                book.byline(context),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (year != null) ...[
                const Gap(Spacing.xs),
                Text(
                  context.l10n.firstPublished(year),
                  style: theme.textTheme.bodySmall,
                ),
              ],
              if (entry != null) ...[
                const Gap(Spacing.m),
                Chip(
                  avatar: Icon(entry.status.icon, size: 18),
                  label: Text(entry.status.label(context)),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
