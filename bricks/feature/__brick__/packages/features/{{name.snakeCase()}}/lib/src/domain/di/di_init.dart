import 'package:core_di/core_di.dart';
import 'package:injectable/injectable.dart';
import 'package:{{name.snakeCase()}}/src/domain/di/di_init.config.dart';
{{#has_navigation}}import 'package:{{name.snakeCase()}}/src/domain/navigation/i_{{name.snakeCase()}}_navigation.dart';
{{/has_navigation}}
const _scope = '{{name.snakeCase()}}';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [{{#has_navigation}}I{{name.pascalCase()}}Navigation{{/has_navigation}}],
)
void initialize() => getIt.pushFeatureScope(_scope, $initGetIt);

Future<void> deinitialize() => getIt.dropFeatureScope(_scope);
