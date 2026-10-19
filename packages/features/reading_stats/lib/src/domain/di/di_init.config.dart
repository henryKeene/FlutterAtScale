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

import '../../presentation/cubits/reading_stats_cubit/reading_stats_cubit.dart'
    as _i829;
import '../navigation/i_reading_stats_navigation.dart' as _i593;
import '../services/reading_stats_calculator.dart' as _i724;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i724.ReadingStatsCalculator>(
    () => _i724.ReadingStatsCalculator(),
  );
  gh.factory<_i829.ReadingStatsCubit>(
    () => _i829.ReadingStatsCubit(
      gh<_i621.ILibraryService>(),
      gh<_i621.IReadingGoalService>(),
      gh<_i724.ReadingStatsCalculator>(),
      gh<_i593.IReadingStatsNavigation>(),
    ),
  );
  return getIt;
}
