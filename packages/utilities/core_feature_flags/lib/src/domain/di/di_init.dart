import 'package:core_config/core_config.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/src/domain/di/di_init.config.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [AppConfig, IKeyValueStore],
)
void initialize() => $initGetIt(getIt);
