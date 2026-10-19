import 'package:book_details/src/l10n/l10n.dart';
import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';

class ReviewCard extends StatelessWidget {
  const new({required this.entry, super.key});

  final ShelfEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final review = entry.review;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.yourReview, style: theme.textTheme.titleSmall),
            const Gap(Spacing.s),
            RatingStars(rating: entry.rating ?? 0),
            if (review != null) ...[
              const Gap(Spacing.s),
              Text(review, style: theme.textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
