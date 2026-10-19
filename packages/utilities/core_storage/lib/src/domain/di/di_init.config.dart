// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/services/shared_preferences_store.dart' as _i50;
import '../interfaces/i_key_value_store.dart' as _i606;
import 'storage_module.dart' as _i371;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final storageModule = _$StorageModule();
  gh.lazySingleton<_i460.SharedPreferencesAsync>(
    () => storageModule.preferences,
  );
  gh.lazySingleton<_i606.IKeyValueStore>(
    () => _i50.SharedPreferencesStore(gh<_i460.SharedPreferencesAsync>()),
  );
  return getIt;
}

class _$StorageModule extends _i371.StorageModule {}
