import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final logger = context.logger;
  final name = 'core_${(context.vars['name'] as String).snakeCase}';
  final path = 'packages/utilities/$name';

  if (!addToWorkspace(path)) {
    logger.warn(
      'Run this from the repository root so $path can join the workspace.',
    );
    return;
  }
  logger.success('Added $path to the workspace');

  await step(logger, 'Resolving dependencies', ['pub', 'get']);
  await step(
    logger,
    'Generating the DI config',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: path,
  );
  await step(logger, 'Tidying imports', ['fix', '--apply'], workingDirectory: path);
  await step(logger, 'Formatting', ['format', '.'], workingDirectory: path);

  logger.info('''

${styleBold.wrap('Wire it into the app')}
  1. Add $name to the pubspec of every package that needs it
  2. Call $name.initialize() in packages/app/bookshelf/lib/di/di_initializer.dart
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
  List<String> arguments, {
  String? workingDirectory,
}) async {
  final progress = logger.progress(label);
  final result = await Process.run(
    'dart',
    arguments,
    workingDirectory: workingDirectory,
    runInShell: true,
  );

  if (result.exitCode == 0) {
    progress.complete();
  } else {
    progress.fail('$label failed. Run "dart ${arguments.join(' ')}" yourself.');
  }
}
