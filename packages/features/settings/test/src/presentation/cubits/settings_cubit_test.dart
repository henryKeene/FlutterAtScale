import 'package:bloc_test/bloc_test.dart';
import 'package:core_books/core_books.dart';
import 'package:core_config/core_config.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings/settings.dart';
import 'package:settings/src/presentation/cubits/settings_cubit/settings_cubit.dart';

class _MockThemeModeService extends Mock implements IThemeModeService;

class _MockReadingGoalService extends Mock implements IReadingGoalService;

class _MockLocaleService extends Mock implements ILocaleService;

class _MockNavigation extends Mock implements ISettingsNavigation;

void main() {
  late _MockThemeModeService themes;
  late _MockReadingGoalService goals;
  late _MockLocaleService locales;
  late _MockNavigation navigation;

  setUp(() {
    themes = _MockThemeModeService();
    goals = _MockReadingGoalService();
    locales = _MockLocaleService();
    navigation = _MockNavigation();
    when(() => themes.themeMode()).thenAnswer((_) async => ThemeMode.dark);
    when(() => goals.yearlyGoal()).thenAnswer((_) async => 12);
    when(() => locales.locale()).thenAnswer((_) async => null);
    when(() => locales.setLocale(any())).thenAnswer((_) async {});
    when(() => themes.setThemeMode(any())).thenAnswer((_) async {});
    when(() => goals.setYearlyGoal(any())).thenAnswer((_) async {});
  });

  setUpAll(() {
    registerFallbackValue(ThemeMode.system);
    registerFallbackValue(AppLocales.english);
  });

  SettingsCubit buildCubit(AppEnvironment environment) => SettingsCubit(
    themes,
    goals,
    locales,
    AppConfig.forEnvironment(environment),
    navigation,
  );

  const loaded = SettingsLoaded(
    themeMode: ThemeMode.dark,
    yearlyGoal: 12,
    environment: AppEnvironment.development,
    showDeveloperOptions: true,
  );

  group('SettingsCubit', () {
    blocTest<SettingsCubit, SettingsState>(
      'loads the saved preferences',
      build: () => buildCubit(AppEnvironment.development),
      act: (cubit) => cubit.load(),
      expect: () => [loaded],
    );

    blocTest<SettingsCubit, SettingsState>(
      'hides developer options in production',
      build: () => buildCubit(AppEnvironment.production),
      act: (cubit) => cubit.load(),
      verify: (cubit) =>
          expect((cubit.state as SettingsLoaded).showDeveloperOptions, isFalse),
    );

    blocTest<SettingsCubit, SettingsState>(
      'saves a new theme mode',
      build: () => buildCubit(AppEnvironment.development),
      seed: () => loaded,
      act: (cubit) => cubit.setThemeMode(ThemeMode.light),
      expect: () => [loaded.copyWith(themeMode: ThemeMode.light)],
      verify: (_) =>
          verify(() => themes.setThemeMode(ThemeMode.light)).called(1),
    );

    blocTest<SettingsCubit, SettingsState>(
      'never lets the goal drop below one book',
      build: () => buildCubit(AppEnvironment.development),
      seed: () => loaded.copyWith(yearlyGoal: 1),
      act: (cubit) => cubit.changeGoalBy(-1),
      expect: () => const <SettingsState>[],
      verify: (_) => verify(() => goals.setYearlyGoal(1)).called(1),
    );

    blocTest<SettingsCubit, SettingsState>(
      'switches language and remembers the choice',
      build: () => buildCubit(AppEnvironment.development),
      seed: () => loaded,
      act: (cubit) => cubit.setLocale(AppLocales.spanish),
      expect: () => [loaded.copyWith(locale: () => AppLocales.spanish)],
      verify: (_) =>
          verify(() => locales.setLocale(AppLocales.spanish)).called(1),
    );
  });
}
