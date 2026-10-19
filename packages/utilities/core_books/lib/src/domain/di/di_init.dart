import 'package:core_books/src/domain/di/di_init.config.dart';
import 'package:core_di/core_di.dart';
import 'package:core_network/core_network.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [IApiClient, IKeyValueStore],
)
void initialize() => $initGetIt(getIt);
