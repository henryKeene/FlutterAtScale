{{#has_navigation}}export 'src/domain/navigation/i_{{name.snakeCase()}}_navigation.dart';
{{/has_navigation}}export 'src/l10n/gen/{{name.snakeCase()}}_localizations.dart' show {{name.pascalCase()}}Localizations;
export 'src/presentation/flow/{{name.snakeCase()}}_flow.dart';
