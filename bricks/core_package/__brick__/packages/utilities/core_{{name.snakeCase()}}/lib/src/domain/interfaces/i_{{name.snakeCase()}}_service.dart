import 'package:core_{{name.snakeCase()}}/src/domain/failures/{{name.snakeCase()}}_failure.dart';
import 'package:core_prelude/core_prelude.dart';

abstract interface class I{{name.pascalCase()}}Service {
  Future<Result<String, {{name.pascalCase()}}Failure>> fetch();
}
