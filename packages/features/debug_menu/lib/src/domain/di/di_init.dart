import 'package:core_config/core_config.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:debug_menu/src/domain/di/di_init.config.dart';
import 'package:injectable/injectable.dart';

const _scope = 'debug_menu';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [AppConfig, IFeatureFlagService],
)
void initialize() => getIt.pushFeatureScope(_scope, $initGetIt);

Future<void> deinitialize() => getIt.dropFeatureScope(_scope);
