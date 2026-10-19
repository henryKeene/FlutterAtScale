// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_books/core_books.dart' as _i621;
import 'package:core_feature_flags/core_feature_flags.dart' as _i328;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/cubits/book_details_cubit/book_details_cubit.dart'
    as _i388;
import '../../presentation/cubits/shelve_book_cubit/shelve_book_cubit.dart'
    as _i413;
import '../navigation/i_book_details_navigation.dart' as _i194;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i413.ShelveBookCubit>(
    () => _i413.ShelveBookCubit(
      gh<_i621.ILibraryService>(),
      gh<_i328.IFeatureFlagService>(),
    ),
  );
  gh.factory<_i388.BookDetailsCubit>(
    () => _i388.BookDetailsCubit(
      gh<_i621.IBookCatalogService>(),
      gh<_i621.ILibraryService>(),
      gh<_i194.IBookDetailsNavigation>(),
    ),
  );
  return getIt;
}
