import 'package:flutter/widgets.dart';
import 'package:settings/src/l10n/gen/settings_localizations.dart';

extension SettingsL10n on BuildContext {
  SettingsLocalizations get l10n => SettingsLocalizations.of(this);
}
