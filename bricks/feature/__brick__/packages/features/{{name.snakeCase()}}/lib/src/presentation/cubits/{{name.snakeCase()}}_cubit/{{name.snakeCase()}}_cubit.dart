import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
{{#has_navigation}}import 'package:{{name.snakeCase()}}/src/domain/navigation/i_{{name.snakeCase()}}_navigation.dart';
{{/has_navigation}}
part '{{name.snakeCase()}}_state.dart';

@injectable
class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  new({{#has_navigation}}this._navigation{{/has_navigation}}) : super(const {{name.pascalCase()}}Loading());
{{#has_navigation}}

  final I{{name.pascalCase()}}Navigation _navigation;
{{/has_navigation}}

  void load() => emit(const {{name.pascalCase()}}Loaded());
{{#has_navigation}}

  void goBack() => _navigation.back();
{{/has_navigation}}
}
