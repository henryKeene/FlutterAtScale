import 'package:book_details/src/l10n/l10n.dart';
import 'package:book_details/src/presentation/cubits/book_details_cubit/book_details_cubit.dart';
import 'package:book_details/src/presentation/flow/book_details_flow_state.dart';
import 'package:book_details/src/presentation/view/widgets/book_header.dart';
import 'package:book_details/src/presentation/view/widgets/review_card.dart';
import 'package:book_details/src/presentation/view/widgets/subject_chips.dart';
import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class BookOverviewPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookDetailsCubit>();

    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: cubit.goBack),
          actions: [
            if (state case BookDetailsLoaded(entry: _?))
              IconButton(
                tooltip: context.l10n.removeFromShelf,
                icon: const Icon(Icons.delete_outline),
                onPressed: cubit.removeFromShelf,
              ),
          ],
        ),
        body: switch (state) {
          BookDetailsLoading() => const Center(child: LoadingIndicator()),
          BookDetailsFailure(:final workId, :final failure) => ErrorView(
            message: failure.describe(context),
            onRetry: () => cubit.load(workId),
          ),
          BookDetailsLoaded() => _Overview(state: state),
        },
        bottomNavigationBar: switch (state) {
          BookDetailsLoaded() => _ShelveButton(state: state),
          _ => null,
        },
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const new({required this.state});

  final BookDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final BookDetailsLoaded(:book, :entry, :isOffline) = state;
    final description = book.description;

    return ListView(
      padding: const EdgeInsets.all(Spacing.m),
      children: [
        BookHeader(book: book, entry: entry),
        if (isOffline) ...[
          const Gap(Spacing.m),
          Card(
            child: ListTile(
              leading: const Icon(Icons.cloud_off_outlined),
              title: Text(l10n.savedCopyTitle),
              subtitle: Text(l10n.savedCopyMessage),
            ),
          ),
        ],
        if (entry != null && entry.rating != null) ...[
          const Gap(Spacing.l),
          ReviewCard(entry: entry),
        ],
        if (description != null) ...[
          const Gap(Spacing.l),
          Text(l10n.aboutThisBook, style: theme.textTheme.titleMedium),
          const Gap(Spacing.s),
          Text(description, style: theme.textTheme.bodyMedium),
        ],
        if (book.subjects.isNotEmpty) ...[
          const Gap(Spacing.l),
          Text(l10n.subjects, style: theme.textTheme.titleMedium),
          const Gap(Spacing.s),
          SubjectChips(subjects: book.subjects),
        ],
      ],
    );
  }
}

class _ShelveButton extends StatelessWidget {
  const new({required this.state});

  final BookDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    final isShelved = state.entry != null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: FilledButton.icon(
          onPressed: () => context.flow<BookDetailsFlowState>().update(
            (_) => ChoosingShelf(state.book),
          ),
          icon: Icon(isShelved ? Icons.swap_horiz : Icons.add),
          label: Text(
            isShelved ? context.l10n.changeShelf : context.l10n.addToShelf,
          ),
        ),
      ),
    );
  }
}
