import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:settings/src/l10n/l10n.dart';
import 'package:settings/src/presentation/cubits/settings_cubit/settings_cubit.dart';

class ThemeModePicker extends StatelessWidget {
  const new({required this.selected, super.key});

  final ThemeMode selected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      child: SegmentedButton<ThemeMode>(
        selected: {selected},
        onSelectionChanged: (selection) =>
            context.read<SettingsCubit>().setThemeMode(selection.single),
        segments: [
          ButtonSegment(
            value: ThemeMode.system,
            icon: const Icon(Icons.brightness_auto_outlined),
            label: Text(l10n.themeSystem),
          ),
          ButtonSegment(
            value: ThemeMode.light,
            icon: const Icon(Icons.light_mode_outlined),
            label: Text(l10n.themeLight),
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            icon: const Icon(Icons.dark_mode_outlined),
            label: Text(l10n.themeDark),
          ),
        ],
      ),
    );
  }
}
