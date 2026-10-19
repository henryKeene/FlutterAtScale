import 'package:core_design_system/core_design_system.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:debug_menu/src/presentation/cubits/debug_menu_cubit/debug_menu_cubit.dart';
import 'package:debug_menu/src/presentation/view/widgets/flag_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class DebugMenuPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DebugMenuCubit>();

    return BlocBuilder<DebugMenuCubit, DebugMenuState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Developer options'),
          actions: [
            IconButton(
              tooltip: 'Fetch remote flags',
              onPressed: state.isRefreshing ? null : cubit.refreshRemote,
              icon: const Icon(Icons.cloud_sync_outlined),
            ),
            IconButton(
              tooltip: 'Clear all overrides',
              onPressed: state.hasOverrides ? cubit.resetAll : null,
              icon: const Icon(Icons.restart_alt),
            ),
          ],
        ),
        body: ListView(
          children: [
            if (state.isRefreshing) const LinearProgressIndicator(),
            ListTile(
              leading: const Icon(Icons.dns_outlined),
              title: const Text('Environment'),
              trailing: Text(state.environment.label),
            ),
            const SectionHeader('Feature flags'),
            for (final flag in FeatureFlag.values)
              FlagTile(flag: flag, resolved: state.flags.resolved(flag)),
          ],
        ),
      ),
    );
  }
}
