import 'package:core_books/core_books.dart'
    show ReadingStatus, ReadingStatusText;
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:reading_stats/src/domain/models/reading_stats.dart';
import 'package:reading_stats/src/l10n/l10n.dart';
import 'package:reading_stats/src/presentation/cubits/reading_stats_cubit/reading_stats_cubit.dart';
import 'package:reading_stats/src/presentation/view/widgets/goal_card.dart';
import 'package:reading_stats/src/presentation/view/widgets/monthly_chart.dart';
import 'package:reading_stats/src/presentation/view/widgets/stat_tile.dart';

class ReadingStatsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.title)),
      body: BlocBuilder<ReadingStatsCubit, ReadingStatsState>(
        builder: (context, state) => switch (state) {
          ReadingStatsLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          ReadingStatsLoaded(:final stats) when stats.totalBooks == 0 =>
            EmptyState(
              icon: Icons.insights_outlined,
              title: context.l10n.emptyTitle,
              message: context.l10n.emptyMessage,
              action: FilledButton.tonal(
                onPressed: context.read<ReadingStatsCubit>().openDiscover,
                child: Text(context.l10n.findABook),
              ),
            ),
          ReadingStatsLoaded(:final stats) => _Stats(stats: stats),
        },
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const new({required this.stats});

  final ReadingStats stats;

  @override
  Widget build(BuildContext context) {
    final averageRating = stats.averageRating;

    return ListView(
      padding: const EdgeInsets.all(Spacing.m),
      children: [
        GoalCard(stats: stats),
        const Gap(Spacing.m),
        Row(
          children: [
            Expanded(
              child: StatTile(
                label: ReadingStatus.reading.label(context),
                value: '${stats.reading}',
              ),
            ),
            const Gap(Spacing.m),
            Expanded(
              child: StatTile(
                label: ReadingStatus.wantToRead.label(context),
                value: '${stats.wantToRead}',
              ),
            ),
            const Gap(Spacing.m),
            Expanded(
              child: StatTile(
                label: context.l10n.averageRating,
                value: averageRating == null
                    ? '-'
                    : NumberFormat.decimalPatternDigits(
                        locale: context.l10n.localeName,
                        decimalDigits: 1,
                      ).format(averageRating),
              ),
            ),
          ],
        ),
        const Gap(Spacing.m),
        MonthlyChart(monthlyReads: stats.monthlyReads),
      ],
    );
  }
}
