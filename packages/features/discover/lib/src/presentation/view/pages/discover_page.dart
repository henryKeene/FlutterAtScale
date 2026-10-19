import 'package:core_design_system/core_design_system.dart';
import 'package:discover/src/l10n/l10n.dart';
import 'package:discover/src/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:discover/src/presentation/view/widgets/search_body.dart';
import 'package:discover/src/presentation/view/widgets/search_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class DiscoverPage extends StatefulWidget {
  const new({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late final _controller = TextEditingController(
    text: context.read<SearchCubit>().state.query,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.title)),
      body: BlocListener<SearchCubit, SearchState>(
        listenWhen: (previous, current) => previous.query != current.query,
        listener: (context, state) {
          if (state.query != _controller.text.trim()) {
            _controller.text = state.query;
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
              child: SearchField(controller: _controller),
            ),
            const Gap(Spacing.s),
            const Expanded(child: SearchBody()),
          ],
        ),
      ),
    );
  }
}
