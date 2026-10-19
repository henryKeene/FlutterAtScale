part of '{{name.snakeCase()}}_cubit.dart';

sealed class {{name.pascalCase()}}State extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class {{name.pascalCase()}}Loading extends {{name.pascalCase()}}State {
  const new();
}

final class {{name.pascalCase()}}Loaded extends {{name.pascalCase()}}State {
  const new();
}
