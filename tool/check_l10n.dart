import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

typedef ArbSet = ({
  String package,
  String template,
  Map<String, Map<String, dynamic>> byLocale,
});

void main() {
  final sets = [
    for (final l10nYaml
        in Directory('packages')
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('/l10n.yaml'))
            .where((file) => !file.path.contains('/.dart_tool/')))
      readArbSet(l10nYaml),
  ];
  final locales = {for (final set in sets) ...set.byLocale.keys};

  final problems = [for (final set in sets) ...check(set, locales)];

  if (problems.isEmpty) {
    stdout.writeln(
      'Translations complete: ${sets.length} packages in '
      '${(locales.toList()..sort()).join(', ')}.',
    );
    return;
  }

  stderr.writeln('Translations incomplete:');
  for (final problem in problems) {
    stderr.writeln('  $problem');
  }
  exitCode = 1;
}

ArbSet readArbSet(File l10nYaml) {
  final root = l10nYaml.parent;
  final config = loadYaml(l10nYaml.readAsStringSync()) as YamlMap;
  final arbDir = Directory('${root.path}/${config['arb-dir']}');

  final byLocale = <String, Map<String, dynamic>>{};
  String? template;
  for (final file in arbDir.listSync().whereType<File>()) {
    if (!file.path.endsWith('.arb')) continue;
    final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final locale = json['@@locale'] as String;
    byLocale[locale] = json;
    if (file.uri.pathSegments.last == config['template-arb-file']) {
      template = locale;
    }
  }

  return (package: root.path, template: template!, byLocale: byLocale);
}

Iterable<String> check(ArbSet set, Set<String> locales) sync* {
  final template = set.byLocale[set.template]!;
  final keys = messageKeys(template);

  for (final key in keys) {
    final meta = template['@$key'];
    if (meta is! Map || (meta['description'] as String? ?? '').isEmpty) {
      yield '${set.package}: "$key" has no description for translators';
    }
  }

  for (final locale in locales) {
    final arb = set.byLocale[locale];
    if (arb == null) {
      yield '${set.package}: no $locale translations at all';
      continue;
    }
    final translated = messageKeys(arb);
    for (final key in keys.difference(translated)) {
      yield '${set.package}: "$key" is not translated into $locale';
    }
    for (final key in translated.difference(keys)) {
      yield '${set.package}: "$key" in $locale is not in the template';
    }
  }
}

Set<String> messageKeys(Map<String, dynamic> arb) =>
    arb.keys.where((key) => !key.startsWith('@')).toSet();
