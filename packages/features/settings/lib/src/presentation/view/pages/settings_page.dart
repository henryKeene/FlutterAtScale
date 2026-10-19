import 'package:core_config/core_config.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:settings/src/l10n/l10n.dart';
import 'package:settings/src/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:settings/src/presentation/view/widgets/goal_stepper.dart';
import 'package:settings/src/presentation/view/widgets/language_picker.dart';
import 'package:settings/src/presentation/view/widgets/theme_mode_picker.dart';

class SettingsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.title)),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => switch (state) {
          SettingsLoading() => const Center(child: CircularProgressIndicator()),
          SettingsLoaded() => _Settings(state: state),
        },
      ),
    );
  }
}

class _Settings extends StatelessWidget {
  const new({required this.state});

  final SettingsLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final l10n = context.l10n;

    return ListView(
      children: [
        SectionHeader(l10n.appearance),
        ThemeModePicker(selected: state.themeMode),
        SectionHeader(l10n.language),
        LanguagePicker(selected: state.locale),
        SectionHeader(l10n.readingSection),
        GoalStepper(goal: state.yearlyGoal),
        SectionHeader(l10n.about),
        ListTile(
          leading: const Icon(Icons.dns_outlined),
          title: Text(l10n.environment),
          trailing: Text(switch (state.environment) {
            AppEnvironment.development => l10n.environmentDevelopment,
            AppEnvironment.staging => l10n.environmentStaging,
            AppEnvironment.production => l10n.environmentProduction,
          }),
        ),
        if (state.showDeveloperOptions)
          ListTile(
            leading: const Icon(Icons.developer_mode_outlined),
            title: Text(l10n.developerOptions),
            subtitle: Text(l10n.developerOptionsSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: cubit.openDeveloperOptions,
          ),
      ],
    );
  }
}
