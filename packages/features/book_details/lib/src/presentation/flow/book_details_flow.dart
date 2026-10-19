import 'dart:async';

import 'package:book_details/src/domain/di/di_init.dart';
import 'package:book_details/src/l10n/l10n.dart';
import 'package:book_details/src/presentation/cubits/book_details_cubit/book_details_cubit.dart';
import 'package:book_details/src/presentation/cubits/shelve_book_cubit/shelve_book_cubit.dart';
import 'package:book_details/src/presentation/flow/book_details_flow_state.dart';
import 'package:book_details/src/presentation/view/pages/book_overview_page.dart';
import 'package:book_details/src/presentation/view/pages/choose_shelf_page.dart';
import 'package:book_details/src/presentation/view/pages/write_review_page.dart';
import 'package:core_books/core_books.dart'
    show LibraryFailureText, ReadingStatusText;
import 'package:core_di/core_di.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class BookDetailsFlow extends StatefulWidget {
  const new({required this.workId, super.key});

  final String workId;

  @override
  State<BookDetailsFlow> createState() => _BookDetailsFlowState();
}

class _BookDetailsFlowState extends State<BookDetailsFlow> {
  final _flow = FlowController<BookDetailsFlowState>(const BookOverview());

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

  void _onShelveChanged(BuildContext context, ShelveBookState state) {
    final messenger = ScaffoldMessenger.of(context);

    switch (state) {
      case ShelveBookSaved(:final entry):
        _flow.update((_) => const BookOverview());
        messenger.showSnackBar(
          SnackBar(
            content: Text(context.l10n.movedTo(entry.status.label(context))),
          ),
        );
      case ShelveBookFailed(:final failure):
        messenger.showSnackBar(
          SnackBar(content: Text(failure.describe(context))),
        );
      case ShelveBookIdle() || ShelveBookSaving():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<BookDetailsCubit>()..load(widget.workId),
        ),
        BlocProvider(create: (_) => getIt<ShelveBookCubit>()),
      ],
      child: BlocListener<ShelveBookCubit, ShelveBookState>(
        listener: _onShelveChanged,
        child: FlowBuilder<BookDetailsFlowState>(
          controller: _flow,
          onGeneratePages: (state, pages) => [
            const MaterialPage(child: BookOverviewPage()),
            if (state
                case ChoosingShelf(:final book) || WritingReview(:final book))
              MaterialPage(child: ChooseShelfPage(book: book)),
            if (state case WritingReview(:final book))
              MaterialPage(child: WriteReviewPage(book: book)),
          ],
        ),
      ),
    );
  }
}
