import 'package:flutter/widgets.dart';
import 'package:{{name.snakeCase()}}/src/l10n/gen/{{name.snakeCase()}}_localizations.dart';

extension {{name.pascalCase()}}L10n on BuildContext {
  {{name.pascalCase()}}Localizations get l10n => {{name.pascalCase()}}Localizations.of(this);
}
