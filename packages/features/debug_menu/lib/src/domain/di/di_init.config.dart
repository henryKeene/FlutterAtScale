// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_config/core_config.dart' as _i277;
import 'package:core_feature_flags/core_feature_flags.dart' as _i328;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/cubits/debug_menu_cubit/debug_menu_cubit.dart'
    as _i400;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i400.DebugMenuCubit>(
    () => _i400.DebugMenuCubit(
      gh<_i328.IFeatureFlagService>(),
      gh<_i277.AppConfig>(),
    ),
  );
  return getIt;
}
