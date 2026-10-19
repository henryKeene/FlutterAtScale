import 'dart:io';

import 'package:yaml/yaml.dart';

enum Layer { app, features, sandboxes, utilities }

/// Apps nested inside a package that run it on its own, such as its
/// Widgetbook.
const sandboxFolders = ['sandbox', 'widgetbook'];

/// Utilities only sandboxes may depend on.
const sandboxOnly = {'core_widgetbook'};

/// A core package's fakes, such as `package:core_books/fakes.dart`, are for
/// sandboxes and tests. Nothing else may import them, so none reach the app.
final fakesImport = RegExp(r'''import\s+['"]package:(\w+)/fakes\.dart['"]''');

typedef Package = ({
  String name,
  String path,
  Layer layer,
  String? host,
  Set<String> dependencies,
});

bool allowed(Package from, Package to) {
  if (sandboxOnly.contains(to.name)) return from.layer == Layer.sandboxes;

  return switch (from.layer) {
    Layer.app => to.layer != Layer.sandboxes,
    Layer.features || Layer.utilities => to.layer == Layer.utilities,
    Layer.sandboxes => to.layer == Layer.utilities || to.name == from.host,
  };
}

void main() {
  final packages = {for (final package in discover()) package.name: package};

  final violations = [
    for (final package in packages.values)
      for (final dependency in package.dependencies)
        if (packages[dependency] case final target?
            when !allowed(package, target))
          '${package.name} (${package.layer.name}) depends on '
              '${target.name} (${target.layer.name})',
    for (final package in packages.values) ...fakeImports(package),
  ];

  if (violations.isEmpty) {
    stdout.writeln(
      'Boundaries hold: app -> features -> utilities across '
      '${packages.length} packages.',
    );
    return;
  }

  stderr.writeln('Boundaries broken:');
  for (final violation in violations) {
    stderr.writeln('  $violation');
  }
  exitCode = 1;
}

Iterable<String> fakeImports(Package package) sync* {
  final lib = Directory('${package.path}/lib');
  if (package.layer == Layer.sandboxes || !lib.existsSync()) return;

  for (final file in lib.listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart')) continue;
    for (final match in fakesImport.allMatches(file.readAsStringSync())) {
      yield '${file.path} imports package:${match[1]}/fakes.dart, which only '
          'sandboxes and tests may use';
    }
  }
}

Iterable<Package> discover() sync* {
  for (final layer in [Layer.app, Layer.features, Layer.utilities]) {
    final directories = Directory('packages/${layer.name}')
        .listSync()
        .whereType<Directory>();

    for (final directory in directories) {
      final package = readPackage(directory, layer);
      if (package == null) continue;
      yield package;

      for (final folder in sandboxFolders) {
        final sandbox = readPackage(
          Directory('${directory.path}/$folder'),
          Layer.sandboxes,
          host: package.name,
        );
        if (sandbox != null) yield sandbox;
      }
    }
  }
}

Package? readPackage(Directory directory, Layer layer, {String? host}) {
  final pubspec = File('${directory.path}/pubspec.yaml');
  if (!pubspec.existsSync()) return null;

  final yaml = loadYaml(pubspec.readAsStringSync()) as YamlMap;
  final dependencies = yaml['dependencies'] as YamlMap?;

  return (
    name: yaml['name'] as String,
    path: directory.path,
    layer: layer,
    host: host,
    dependencies: {...?dependencies?.keys.cast<String>()},
  );
}
