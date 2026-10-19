import 'package:core_design_system/core_design_system.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:debug_menu/src/presentation/cubits/debug_menu_cubit/debug_menu_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class FlagTile extends StatelessWidget {
  const new({required this.flag, required this.resolved, super.key});

  final FeatureFlag flag;
  final ResolvedFlag resolved;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DebugMenuCubit>();
    final isOverridden = resolved.source == FlagSource.override;

    return ListTile(
      isThreeLine: true,
      title: Text(flag.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(flag.description),
          const Gap(Spacing.xs),
          Row(
            children: [
              _SourceBadge(source: resolved.source),
              if (isOverridden)
                TextButton(
                  onPressed: () => cubit.resetFlag(flag),
                  child: const Text('Reset'),
                ),
            ],
          ),
        ],
      ),
      trailing: Switch(
        value: resolved.enabled,
        onChanged: (enabled) => cubit.toggle(flag, enabled: enabled),
      ),
    );
  }
}

class _SourceBadge extends StatelessWidget {
  const new({required this.source});

  final FlagSource source;

  @override
  Widget build(BuildContext context) {
    return Tag(
      source.label,
      tone: switch (source) {
        FlagSource.defaults => TagTone.neutral,
        FlagSource.remote => TagTone.secondary,
        FlagSource.override => TagTone.tertiary,
      },
    );
  }
}
