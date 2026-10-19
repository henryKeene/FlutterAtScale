import 'dart:async';

import 'package:discover/src/l10n/l10n.dart';
import 'package:discover/src/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class SearchField extends StatelessWidget {
  const new({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onChanged: cubit.queryChanged,
      onSubmitted: (query) {
        if (query.trim().isEmpty) return;
        unawaited(cubit.search(query.trim()));
      },
      decoration: InputDecoration(
        hintText: context.l10n.searchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => controller.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  tooltip: context.l10n.clearSearch,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.clear();
                    cubit.queryChanged('');
                  },
                ),
        ),
      ),
    );
  }
}
