// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_network/core_network.dart' as _i309;
import 'package:core_storage/core_storage.dart' as _i78;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/services/local_library_service.dart' as _i919;
import '../../data/services/open_library_catalog_service.dart' as _i1071;
import '../../data/services/reading_goal_service.dart' as _i624;
import '../interfaces/i_book_catalog_service.dart' as _i758;
import '../interfaces/i_library_service.dart' as _i34;
import '../interfaces/i_reading_goal_service.dart' as _i608;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i758.IBookCatalogService>(
    () => _i1071.OpenLibraryCatalogService(gh<_i309.IApiClient>()),
  );
  gh.lazySingleton<_i608.IReadingGoalService>(
    () => _i624.ReadingGoalService(gh<_i78.IKeyValueStore>()),
  );
  gh.lazySingleton<_i34.ILibraryService>(
    () => _i919.LocalLibraryService(gh<_i78.IKeyValueStore>()),
  );
  return getIt;
}
