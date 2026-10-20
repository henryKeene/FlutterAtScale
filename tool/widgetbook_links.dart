import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

/// Prints a pull request comment that links to the Widgetbook use cases the
/// pull request touches, in its preview.
///
///     dart run tool/widgetbook_links.dart <base-commit> <preview-url>
///
/// A use case is touched when the pull request changes the file of the
/// widget it shows, or the file the use case is written in. When nothing
/// that exact changed, every use case of a package whose `lib/` changed
/// counts instead.
///
/// The use cases come from the metadata build_runner writes for the
/// catalogue, so run `dart run build_runner build` in
/// `packages/app/widgetbook` first.
void main(List<String> arguments) {
  if (arguments.length != 2) {
    stderr.writeln(
      'Usage: dart run tool/widgetbook_links.dart <base-commit> <preview-url>',
    );
    exitCode = 64;
    return;
  }
  final [base, previewUrl] = arguments;
  final url = previewUrl.endsWith('/') ? previewUrl : '$previewUrl/';

  final changed = changedFiles(base);
  final useCases = readUseCases(workspacePackages());
  final exact = [
    for (final useCase in useCases)
      if (changed.contains(useCase.file) ||
          changed.contains(useCase.componentFile))
        useCase,
  ];
  final touched = exact.isNotEmpty
      ? exact
      : [
          for (final useCase in useCases)
            if (changed.any(
              (file) => useCase.packages.any((lib) => file.startsWith(lib)),
            ))
              useCase,
        ];

  stdout.write(comment(url, touched));
}

typedef UseCase = ({
  String path,
  String title,
  String file,
  String componentFile,
  Set<String> packages,
});

const _shown = 8;

String comment(String url, List<UseCase> touched) {
  final lines = [
    '**Widgetbook preview**: $url',
    '',
    if (touched.isEmpty)
      "This pull request doesn't change any Widgetbook use case."
    else ...[
      'Try the use cases this pull request changes:',
      '',
      for (final useCase in touched.take(_shown))
        '- [${useCase.title}]($url#/?path=${useCase.path})',
      if (touched.length > _shown)
        '- and ${touched.length - _shown} more in the preview',
    ],
    '',
    'The preview updates with every push, and is removed when the pull '
        'request closes.',
  ];
  return '${lines.join('\n')}\n';
}

Set<String> changedFiles(String base) {
  final result = Process.runSync('git', [
    'diff',
    '--name-only',
    '$base...HEAD',
  ]);
  if (result.exitCode != 0) {
    throw ProcessException('git', ['diff'], '${result.stderr}');
  }
  return {
    for (final line in LineSplitter.split('${result.stdout}'))
      if (line.isNotEmpty) line,
  };
}

/// Every workspace package's name, mapped to its directory.
Map<String, String> workspacePackages() {
  final root = loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
  return {
    for (final directory in (root['workspace'] as YamlList).cast<String>())
      ((loadYaml(File('$directory/pubspec.yaml').readAsStringSync())
                  as YamlMap)['name']
              as String):
          directory,
  };
}

/// The catalogue's use cases, in the order its Widgetbooks declare them.
List<UseCase> readUseCases(Map<String, String> packages) {
  final generated = Directory(
    'packages/app/widgetbook/.dart_tool/build/generated',
  );
  final files =
      generated
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.usecase.widgetbook.json'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  String resolve(String uri) {
    final [name, ...rest] = Uri.parse(uri).pathSegments;
    return '${packages[name]}/lib/${rest.join('/')}';
  }

  String libOf(String file) =>
      '${file.substring(0, file.indexOf('/lib/'))}/lib/';

  return [
    for (final file in files)
      for (final json in (jsonDecode(
        file.readAsStringSync(),
      ) as List).cast<Map<String, dynamic>>())
        if (json['cloudExclude'] != true)
          () {
            final segments = [
              for (final folder in (json['navPath'] as String).split('/'))
                folder.replaceAll(RegExp(r'[\[\]]'), ''),
              json['componentName'] as String,
              json['useCaseName'] as String,
            ].where((segment) => segment.isNotEmpty).toList();
            final useCaseFile = resolve(json['importStatement'] as String);
            final componentFile = resolve(
              json['componentImportStatement'] as String,
            );
            return (
              // Widgetbook's own rule for a use case's address.
              path: segments.join('/').replaceAll(' ', '-').toLowerCase(),
              title: segments.join(' › '),
              file: useCaseFile,
              componentFile: componentFile,
              packages: {libOf(useCaseFile), libOf(componentFile)},
            );
          }(),
  ];
}
