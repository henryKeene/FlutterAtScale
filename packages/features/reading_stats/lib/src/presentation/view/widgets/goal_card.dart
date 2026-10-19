import 'package:core_design_system/core_design_system.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:reading_stats/src/domain/models/reading_stats.dart';
import 'package:reading_stats/src/l10n/l10n.dart';

class GoalCard extends StatelessWidget {
  const new({required this.stats, super.key});

  final ReadingStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final percent = NumberFormat.percentPattern(l10n.localeName)
        .format(stats.goalProgress);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 88,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: stats.goalProgress,
                    strokeWidth: 8,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                  Center(
                    child: Text(percent, style: theme.textTheme.titleLarge),
                  ),
                ],
              ),
            ),
            const Gap(Spacing.l),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.goalTitle(stats.year),
                    style: theme.textTheme.titleMedium,
                  ),
                  const Gap(Spacing.xs),
                  Text(
                    l10n.goalProgress(stats.readThisYear, stats.goal),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const Gap(Spacing.xs),
                  Text(
                    stats.booksToGo == 0
                        ? l10n.goalReached
                        : l10n.booksToGo(stats.booksToGo),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
