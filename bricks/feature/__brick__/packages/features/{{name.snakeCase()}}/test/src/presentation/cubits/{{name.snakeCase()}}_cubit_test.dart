import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
{{#has_navigation}}import 'package:mocktail/mocktail.dart';
import 'package:{{name.snakeCase()}}/{{name.snakeCase()}}.dart';
{{/has_navigation}}import 'package:{{name.snakeCase()}}/src/presentation/cubits/{{name.snakeCase()}}_cubit/{{name.snakeCase()}}_cubit.dart';
{{#has_navigation}}

class _MockNavigation extends Mock implements I{{name.pascalCase()}}Navigation;
{{/has_navigation}}

void main() {
{{#has_navigation}}
  late _MockNavigation navigation;

  setUp(() => navigation = _MockNavigation());

{{/has_navigation}}
  group('{{name.pascalCase()}}Cubit', () {
    blocTest<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State>(
      'emits loaded once loading finishes',
      build: () => {{name.pascalCase()}}Cubit({{#has_navigation}}navigation{{/has_navigation}}),
      act: (cubit) => cubit.load(),
      expect: () => [const {{name.pascalCase()}}Loaded()],
    );
{{#has_navigation}}

    test('going back is handed to navigation', () {
      {{name.pascalCase()}}Cubit(navigation).goBack();

      verify(() => navigation.back()).called(1);
    });
{{/has_navigation}}
  });
}
