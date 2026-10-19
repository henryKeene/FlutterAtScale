// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_config/core_config.dart' as _i277;
import 'package:core_storage/core_storage.dart' as _i78;
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/services/feature_flag_service.dart' as _i508;
import '../../data/sources/bundled_remote_flag_source.dart' as _i238;
import '../../presentation/cubit/feature_flags_cubit.dart' as _i873;
import '../interfaces/i_feature_flag_service.dart' as _i1;
import '../interfaces/i_remote_flag_source.dart' as _i175;
import 'feature_flags_module.dart' as _i225;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final featureFlagsModule = _$FeatureFlagsModule();
  gh.lazySingleton<_i281.AssetBundle>(() => featureFlagsModule.bundle);
  gh.lazySingleton<_i175.IRemoteFlagSource>(
    () => _i238.BundledRemoteFlagSource(gh<_i281.AssetBundle>()),
  );
  gh.lazySingleton<_i1.IFeatureFlagService>(
    () => _i508.FeatureFlagService(
      gh<_i277.AppConfig>(),
      gh<_i175.IRemoteFlagSource>(),
      gh<_i78.IKeyValueStore>(),
    ),
  );
  gh.factory<_i873.FeatureFlagsCubit>(
    () => _i873.FeatureFlagsCubit(gh<_i1.IFeatureFlagService>()),
  );
  return getIt;
}

class _$FeatureFlagsModule extends _i225.FeatureFlagsModule {}
