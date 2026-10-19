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

import '../../presentation/cubits/my_books_cubit/my_books_cubit.dart' as _i742;
import '../navigation/i_my_books_navigation.dart' as _i911;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i742.MyBooksCubit>(
    () => _i742.MyBooksCubit(
      gh<_i621.ILibraryService>(),
      gh<_i911.IMyBooksNavigation>(),
    ),
  );
  return getIt;
}
