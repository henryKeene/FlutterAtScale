import 'dart:async';

import 'package:book_details/src/presentation/cubits/book_details_cubit/book_details_cubit.dart';
import 'package:book_details/src/presentation/cubits/shelve_book_cubit/shelve_book_cubit.dart';
import 'package:book_details/src/presentation/flow/book_details_flow_state.dart';
import 'package:book_details/src/presentation/view/reading_status_icon.dart';
import 'package:core_books/core_books.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class ChooseShelfPage extends StatelessWidget {
  const new({required this.book, super.key});

  final Book book;

  void _choose(BuildContext context, ReadingStatus status) {
    final cubit = context.read<ShelveBookCubit>();

    if (cubit.needsReview(status)) {
      context.flow<BookDetailsFlowState>().update((_) => WritingReview(book));
      return;
    }
    unawaited(cubit.shelve(book, status));
  }

  @override
  Widget build(BuildContext context) {
    final current = context.select<BookDetailsCubit, ReadingStatus?>(
      (cubit) => switch (cubit.state) {
        BookDetailsLoaded(:final entry) => entry?.status,
        _ => null,
      },
    );
    final isSaving = context.select<ShelveBookCubit, bool>(
      (cubit) => cubit.state is ShelveBookSaving,
    );

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: ListView(
        children: [
          if (isSaving) const LinearProgressIndicator(),
          for (final status in ReadingStatus.values)
            ListTile(
              enabled: !isSaving,
              leading: Icon(status.icon),
              title: Text(status.label(context)),
              trailing: status == current ? const Icon(Icons.check) : null,
              onTap: () => _choose(context, status),
            ),
        ],
      ),
    );
  }
}
