import 'dart:async';

import 'package:core_di/core_di.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:{{name.snakeCase()}}/src/domain/di/di_init.dart';
import 'package:{{name.snakeCase()}}/src/presentation/cubits/{{name.snakeCase()}}_cubit/{{name.snakeCase()}}_cubit.dart';
import 'package:{{name.snakeCase()}}/src/presentation/flow/{{name.snakeCase()}}_flow_state.dart';
import 'package:{{name.snakeCase()}}/src/presentation/view/pages/{{name.snakeCase()}}_page.dart';

class {{name.pascalCase()}}Flow extends StatefulWidget {
  const new({super.key});

  @override
  State<{{name.pascalCase()}}Flow> createState() => _{{name.pascalCase()}}FlowState();
}

class _{{name.pascalCase()}}FlowState extends State<{{name.pascalCase()}}Flow> {
  final _flow = FlowController<{{name.pascalCase()}}FlowState>(const {{name.pascalCase()}}Home());

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _flow.dispose();
    unawaited(deinitialize());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<{{name.pascalCase()}}Cubit>()..load(),
      child: FlowBuilder<{{name.pascalCase()}}FlowState>(
        controller: _flow,
        onGeneratePages: (state, pages) => [
          const MaterialPage(child: {{name.pascalCase()}}Page()),
        ],
      ),
    );
  }
}
