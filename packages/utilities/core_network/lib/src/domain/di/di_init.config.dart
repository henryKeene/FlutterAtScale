// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_config/core_config.dart' as _i277;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/services/http_api_client.dart' as _i116;
import '../interfaces/i_api_client.dart' as _i995;
import 'network_module.dart' as _i567;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  gh.lazySingleton<_i519.Client>(
    () => networkModule.client,
    dispose: _i567.disposeClient,
  );
  gh.lazySingleton<_i995.IApiClient>(
    () => _i116.HttpApiClient(gh<_i519.Client>(), gh<_i277.AppConfig>()),
  );
  return getIt;
}

class _$NetworkModule extends _i567.NetworkModule {}
