import 'package:book_details/src/presentation/cubits/book_details_cubit/book_details_cubit.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class SubjectChips extends StatelessWidget {
  const new({required this.subjects, super.key});

  final List<String> subjects;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookDetailsCubit>();

    return Wrap(
      spacing: Spacing.s,
      runSpacing: Spacing.s,
      children: [
        for (final subject in subjects)
          ActionChip(
            label: Text(subject),
            onPressed: () => cubit.searchSubject(subject),
          ),
      ],
    );
  }
}
