part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class SettingsLoading extends SettingsState {
  const new();
}

final class SettingsLoaded extends SettingsState {
  const new({
    required this.themeMode,
    required this.yearlyGoal,
    required this.environment,
    required this.showDeveloperOptions,
    this.locale,
  });

  final ThemeMode themeMode;
  final int yearlyGoal;
  final Locale? locale;
  final AppEnvironment environment;
  final bool showDeveloperOptions;

  SettingsLoaded copyWith({
    ThemeMode? themeMode,
    int? yearlyGoal,
    Locale? Function()? locale,
  }) => SettingsLoaded(
    themeMode: themeMode ?? this.themeMode,
    yearlyGoal: yearlyGoal ?? this.yearlyGoal,
    locale: locale == null ? this.locale : locale(),
    environment: environment,
    showDeveloperOptions: showDeveloperOptions,
  );

  @override
  List<Object?> get props => [
    themeMode,
    yearlyGoal,
    locale,
    environment,
    showDeveloperOptions,
  ];
}
