import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/src/presentation/cubits/my_books_cubit/my_books_cubit.dart';

class ShelfFilter extends StatelessWidget {
  const new({required this.state, super.key});

  final MyBooksLoaded state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Spacing.m,
        Spacing.s,
        Spacing.m,
        Spacing.m,
      ),
      child: SizedBox(
        width: double.infinity,
        child: SegmentedButton<ReadingStatus>(
          showSelectedIcon: false,
          selected: {state.filter},
          onSelectionChanged: (selection) =>
              context.read<MyBooksCubit>().selectFilter(selection.single),
          segments: [
            for (final status in ReadingStatus.values)
              ButtonSegment(value: status, label: Text(status.label(context))),
          ],
        ),
      ),
    );
  }
}
