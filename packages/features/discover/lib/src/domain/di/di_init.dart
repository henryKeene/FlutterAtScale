import 'package:core_books/core_books.dart';
import 'package:core_di/core_di.dart';
import 'package:discover/src/domain/di/di_init.config.dart';
import 'package:discover/src/domain/navigation/i_discover_navigation.dart';
import 'package:injectable/injectable.dart';

const _scope = 'discover';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [IBookCatalogService, IDiscoverNavigation],
)
void initialize() => getIt.pushFeatureScope(_scope, $initGetIt);

Future<void> deinitialize() => getIt.dropFeatureScope(_scope);
