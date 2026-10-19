import 'package:core_di/core_di.dart';
import 'package:core_{{name.snakeCase()}}/src/domain/di/di_init.config.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void initialize() => $initGetIt(getIt);
