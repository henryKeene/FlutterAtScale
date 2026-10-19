import 'package:core_{{name.snakeCase()}}/src/data/services/{{name.snakeCase()}}_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('{{name.pascalCase()}}Service', () {
    test('fetch succeeds', () async {
      final result = await {{name.pascalCase()}}Service().fetch();

      expect(result.isSuccess, isTrue);
    });
  });
}
