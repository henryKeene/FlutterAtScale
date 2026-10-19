import 'package:core_design_system/src/components/book_cover.dart';
import 'package:core_design_system/src/components/gap.dart';
import 'package:core_design_system/src/tokens/tokens.dart';
import 'package:material_ui/material_ui.dart';

/// A book in a list: its cover, its title and a line about it.
///
/// It takes plain values rather than a `Book`, so the design system does not
/// depend on `core_books`. Each feature decides what the subtitle says.
class BookListTile extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.coverUrl,
    this.footer,
    super.key,
  });

  final String title;
  final String subtitle;
  final Uri? coverUrl;
  final VoidCallback onTap;

  /// Shown under the subtitle, such as the reader's rating.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final footer = this.footer;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.m,
          vertical: Spacing.s,
        ),
        child: Row(
          children: [
            SizedBox(
              width: Sizes.coverThumbnail,
              child: BookCover(url: coverUrl),
            ),
            const Gap(Spacing.m),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (footer != null) ...[const Gap(Spacing.xs), footer],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
