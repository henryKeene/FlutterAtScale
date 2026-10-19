import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final logger = context.logger;
  final name = (context.vars['name'] as String).snakeCase;
  final path = 'packages/features/$name';

  if (!addToWorkspace(path)) {
    logger.warn(
      'Run this from the repository root so $path can join the workspace.',
    );
    return;
  }
  logger.success('Added $path to the workspace');

  await step(logger, 'Resolving dependencies', 'dart', ['pub', 'get']);
  await step(
    logger,
    'Generating localizations',
    'flutter',
    ['gen-l10n'],
    workingDirectory: path,
  );
  await step(
    logger,
    'Generating the DI config',
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: path,
  );
  await step(
    logger,
    'Tidying imports',
    'dart',
    ['fix', '--apply'],
    workingDirectory: path,
  );
  await step(
    logger,
    'Formatting',
    'dart',
    ['format', '.'],
    workingDirectory: path,
  );

  logger.info('''

${styleBold.wrap('Wire it into the app')}
  1. Add $name to packages/app/navigation/pubspec.yaml
  2. Give ${name.pascalCase}Flow a route in packages/app/navigation/lib/src/router.dart
  3. Implement I${name.pascalCase}Navigation in packages/app/navigation/lib/src/features
     and register it in packages/app/navigation/lib/src/di/di_initialiser.dart
  4. Add ${name.pascalCase}Localizations.delegate to
     packages/app/navigation/lib/src/l10n/feature_localizations.dart
  5. Translate lib/src/l10n/arb/${name}_es.arb
''');
}

bool addToWorkspace(String path) {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) return false;

  final lines = pubspec.readAsLinesSync();
  final start = lines.indexOf('workspace:');
  if (start == -1) return false;

  final entry = '  - $path';
  if (lines.contains(entry)) return true;

  final group = '  - ${path.substring(0, path.lastIndexOf('/') + 1)}';
  final siblings = [
    for (var i = start + 1; i < lines.length; i++)
      if (lines[i].startsWith(group)) i,
  ];
  final insertAt = siblings.isEmpty
      ? start + 1
      : siblings.firstWhere(
          (i) => lines[i].compareTo(entry) > 0,
          orElse: () => siblings.last + 1,
        );

  lines.insert(insertAt, entry);
  pubspec.writeAsStringSync('${lines.join('\n')}\n');
  return true;
}

Future<void> step(
  Logger logger,
  String label,
  String executable,
  List<String> arguments, {
  String? workingDirectory,
}) async {
  final progress = logger.progress(label);
  final result = await Process.run(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    runInShell: true,
  );

  if (result.exitCode == 0) {
    progress.complete();
  } else {
    progress.fail(
      '$label failed. Run "$executable ${arguments.join(' ')}" yourself.',
    );
  }
}
