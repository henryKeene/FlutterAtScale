import 'dart:math';

import 'package:core_design_system/core_design_system.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:reading_stats/src/l10n/l10n.dart';

class MonthlyChart extends StatelessWidget {
  const new({required this.monthlyReads, super.key});

  final List<int> monthlyReads;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final peak = max(1, monthlyReads.fold(0, max));
    final initial = DateFormat('LLLLL', context.l10n.localeName);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.finishedByMonth,
              style: theme.textTheme.titleSmall,
            ),
            const Gap(Spacing.m),
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final (index, count) in monthlyReads.indexed)
                    Expanded(
                      child: _MonthBar(
                        label: initial.format(DateTime(2000, index + 1)),
                        fraction: count / peak,
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

class _MonthBar extends StatelessWidget {
  const new({required this.label, required this.fraction});

  final String label;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.6,
              heightFactor: max(fraction, 0.02),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(Radii.xs),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(Spacing.xs),
        Text(label, style: theme.textTheme.labelSmall),
      ],
    );
  }
}
