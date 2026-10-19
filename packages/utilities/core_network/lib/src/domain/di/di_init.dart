import 'package:core_config/core_config.dart';
import 'package:core_di/core_di.dart';
import 'package:core_network/src/domain/di/di_init.config.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [AppConfig],
)
void initialize() => $initGetIt(getIt);
