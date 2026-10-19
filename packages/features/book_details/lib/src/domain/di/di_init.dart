import 'package:book_details/src/domain/di/di_init.config.dart';
import 'package:book_details/src/domain/navigation/i_book_details_navigation.dart';
import 'package:core_books/core_books.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:injectable/injectable.dart';

const _scope = 'book_details';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [
    IBookCatalogService,
    IBookDetailsNavigation,
    IFeatureFlagService,
    ILibraryService,
  ],
)
void initialize() => getIt.pushFeatureScope(_scope, $initGetIt);

Future<void> deinitialize() => getIt.dropFeatureScope(_scope);
