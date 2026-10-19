import 'package:core_books/core_books.dart';
import 'package:core_config/core_config.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';
import 'package:settings/src/domain/navigation/i_settings_navigation.dart';

part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  new(this._themes, this._goals, this._locales, this._config, this._navigation)
    : super(const SettingsLoading());

  static const _minGoal = 1;
  static const _maxGoal = 365;

  final IThemeModeService _themes;
  final IReadingGoalService _goals;
  final ILocaleService _locales;
  final AppConfig _config;
  final ISettingsNavigation _navigation;

  Future<void> load() async {
    final (themeMode, goal, locale) = await (
      _themes.themeMode(),
      _goals.yearlyGoal(),
      _locales.locale(),
    ).wait;
    emit(
      SettingsLoaded(
        themeMode: themeMode,
        yearlyGoal: goal,
        locale: locale,
        environment: _config.environment,
        showDeveloperOptions: !_config.isProduction,
      ),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state case final SettingsLoaded loaded) {
      emit(loaded.copyWith(themeMode: mode));
      await _themes.setThemeMode(mode);
    }
  }

  Future<void> setLocale(Locale? locale) async {
    if (state case final SettingsLoaded loaded) {
      emit(loaded.copyWith(locale: () => locale));
      await _locales.setLocale(locale);
    }
  }

  Future<void> changeGoalBy(int delta) async {
    if (state case final SettingsLoaded loaded) {
      final goal = (loaded.yearlyGoal + delta).clamp(_minGoal, _maxGoal);
      emit(loaded.copyWith(yearlyGoal: goal));
      await _goals.setYearlyGoal(goal);
    }
  }

  void openDeveloperOptions() => _navigation.openDeveloperOptions();
}
