import 'package:core_di/core_di.dart';
import 'package:core_l10n/src/domain/di/di_init.config.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [IKeyValueStore],
)
void initialize() => $initGetIt(getIt);
