import 'package:core_books/core_books.dart';
import 'package:core_di/core_di.dart';
import 'package:injectable/injectable.dart';
import 'package:reading_stats/src/domain/di/di_init.config.dart';
import 'package:reading_stats/src/domain/navigation/i_reading_stats_navigation.dart';

const _scope = 'reading_stats';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [
    ILibraryService,
    IReadingGoalService,
    IReadingStatsNavigation,
  ],
)
void initialize() => getIt.pushFeatureScope(_scope, $initGetIt);

Future<void> deinitialize() => getIt.dropFeatureScope(_scope);
