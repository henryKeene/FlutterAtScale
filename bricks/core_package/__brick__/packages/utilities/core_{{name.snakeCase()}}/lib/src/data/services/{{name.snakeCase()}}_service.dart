import 'package:core_{{name.snakeCase()}}/src/domain/failures/{{name.snakeCase()}}_failure.dart';
import 'package:core_{{name.snakeCase()}}/src/domain/interfaces/i_{{name.snakeCase()}}_service.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: I{{name.pascalCase()}}Service)
class {{name.pascalCase()}}Service implements I{{name.pascalCase()}}Service {
  @override
  Future<Result<String, {{name.pascalCase()}}Failure>> fetch() async =>
      success('{{name.sentenceCase()}}');
}
