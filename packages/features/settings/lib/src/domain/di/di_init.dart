import 'package:core_books/core_books.dart';
import 'package:core_config/core_config.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_di/core_di.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:injectable/injectable.dart';
import 'package:settings/src/domain/di/di_init.config.dart';
import 'package:settings/src/domain/navigation/i_settings_navigation.dart';

const _scope = 'settings';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [
    AppConfig,
    ILocaleService,
    IReadingGoalService,
    ISettingsNavigation,
    IThemeModeService,
  ],
)
void initialize() => getIt.pushFeatureScope(_scope, $initGetIt);

Future<void> deinitialize() => getIt.dropFeatureScope(_scope);
