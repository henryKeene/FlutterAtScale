// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_books/core_books.dart' as _i621;
import 'package:core_config/core_config.dart' as _i277;
import 'package:core_design_system/core_design_system.dart' as _i557;
import 'package:core_l10n/core_l10n.dart' as _i940;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/cubits/settings_cubit/settings_cubit.dart' as _i185;
import '../navigation/i_settings_navigation.dart' as _i818;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i185.SettingsCubit>(
    () => _i185.SettingsCubit(
      gh<_i557.IThemeModeService>(),
      gh<_i621.IReadingGoalService>(),
      gh<_i940.ILocaleService>(),
      gh<_i277.AppConfig>(),
      gh<_i818.ISettingsNavigation>(),
    ),
  );
  return getIt;
}
