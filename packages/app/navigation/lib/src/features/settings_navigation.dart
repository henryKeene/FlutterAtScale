import 'dart:async';

import 'package:navigation/src/router.dart';
import 'package:navigation/src/routes.dart';
import 'package:settings/settings.dart';

class SettingsNavigation implements ISettingsNavigation {
  @override
  void openDeveloperOptions() => unawaited(router.push(Routes.developer));
}
