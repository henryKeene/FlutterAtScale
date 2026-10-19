import 'package:flutter/widgets.dart';
import 'package:navigation/src/l10n/gen/navigation_localizations.dart';

extension NavigationL10n on BuildContext {
  NavigationLocalizations get l10n => NavigationLocalizations.of(this);
}
