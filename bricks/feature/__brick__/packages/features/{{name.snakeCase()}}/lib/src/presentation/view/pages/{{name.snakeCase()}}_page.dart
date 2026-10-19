import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:{{name.snakeCase()}}/src/l10n/l10n.dart';
import 'package:{{name.snakeCase()}}/src/presentation/cubits/{{name.snakeCase()}}_cubit/{{name.snakeCase()}}_cubit.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.title)),
      body: BlocBuilder<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State>(
        builder: (context, state) => switch (state) {
          {{name.pascalCase()}}Loading() => const Center(child: CircularProgressIndicator()),
          {{name.pascalCase()}}Loaded() => EmptyState(
            icon: Icons.construction_outlined,
            title: context.l10n.title,
            message: context.l10n.emptyMessage,
          ),
        },
      ),
    );
  }
}
