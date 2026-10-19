import 'package:core_design_system/core_design_system.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:settings/src/l10n/l10n.dart';
import 'package:settings/src/presentation/cubits/settings_cubit/settings_cubit.dart';

class LanguagePicker extends StatelessWidget {
  const new({required this.selected, super.key});

  static const _system = 'system';

  final Locale? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      child: SegmentedButton<String>(
        selected: {selected?.languageCode ?? _system},
        onSelectionChanged: (selection) =>
            context.read<SettingsCubit>().setLocale(
              AppLocales.supported
                  .where((locale) => locale.languageCode == selection.single)
                  .firstOrNull,
            ),
        segments: [
          ButtonSegment(
            value: _system,
            icon: const Icon(Icons.translate),
            label: Text(context.l10n.languageSystem),
          ),
          for (final locale in AppLocales.supported)
            ButtonSegment(
              value: locale.languageCode,
              label: Text(AppLocales.nativeName(locale)),
            ),
        ],
      ),
    );
  }
}
