// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_books/core_books.dart' as _i621;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/cubits/search_cubit/search_cubit.dart' as _i557;
import '../../presentation/cubits/trending_cubit/trending_cubit.dart' as _i980;
import '../navigation/i_discover_navigation.dart' as _i27;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i557.SearchCubit>(
    () => _i557.SearchCubit(
      gh<_i621.IBookCatalogService>(),
      gh<_i27.IDiscoverNavigation>(),
    ),
  );
  gh.factory<_i980.TrendingCubit>(
    () => _i980.TrendingCubit(
      gh<_i621.IBookCatalogService>(),
      gh<_i27.IDiscoverNavigation>(),
    ),
  );
  return getIt;
}
