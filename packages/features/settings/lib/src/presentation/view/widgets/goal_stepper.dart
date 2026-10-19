import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:settings/src/l10n/l10n.dart';
import 'package:settings/src/presentation/cubits/settings_cubit/settings_cubit.dart';

class GoalStepper extends StatelessWidget {
  const new({required this.goal, super.key});

  final int goal;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final l10n = context.l10n;

    return ListTile(
      leading: const Icon(Icons.flag_outlined),
      title: Text(l10n.yearlyGoal),
      subtitle: Text(l10n.goalBooks(goal)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.outlined(
            tooltip: l10n.fewerBooks,
            onPressed: () => cubit.changeGoalBy(-1),
            icon: const Icon(Icons.remove),
          ),
          IconButton.outlined(
            tooltip: l10n.moreBooks,
            onPressed: () => cubit.changeGoalBy(1),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
