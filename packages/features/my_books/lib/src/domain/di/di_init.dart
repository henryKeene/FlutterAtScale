import 'package:core_books/core_books.dart';
import 'package:core_di/core_di.dart';
import 'package:injectable/injectable.dart';
import 'package:my_books/src/domain/di/di_init.config.dart';
import 'package:my_books/src/domain/navigation/i_my_books_navigation.dart';

const _scope = 'my_books';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [ILibraryService, IMyBooksNavigation],
)
void initialize() => getIt.pushFeatureScope(_scope, $initGetIt);

Future<void> deinitialize() => getIt.dropFeatureScope(_scope);
