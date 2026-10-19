import 'dart:async';

import 'package:book_details/src/l10n/l10n.dart';
import 'package:book_details/src/presentation/cubits/shelve_book_cubit/shelve_book_cubit.dart';
import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class WriteReviewPage extends StatefulWidget {
  const new({required this.book, super.key});

  final Book book;

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final _review = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _review.dispose();
    super.dispose();
  }

  void _save({bool skip = false}) {
    final review = _review.text.trim();
    unawaited(
      context.read<ShelveBookCubit>().shelve(
        widget.book,
        ReadingStatus.read,
        rating: skip || _rating == 0 ? null : _rating,
        review: skip || review.isEmpty ? null : review,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSaving = context.select<ShelveBookCubit, bool>(
      (cubit) => cubit.state is ShelveBookSaving,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.yourReview),
        actions: [
          TextButton(
            onPressed: isSaving ? null : () => _save(skip: true),
            child: Text(context.l10n.skip),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Spacing.m),
        children: [
          Text(
            context.l10n.reviewPrompt(widget.book.title),
            style: theme.textTheme.titleLarge,
          ),
          const Gap(Spacing.m),
          Center(
            child: RatingStars(
              rating: _rating,
              size: Sizes.iconL,
              onChanged: (rating) => setState(() => _rating = rating),
            ),
          ),
          const Gap(Spacing.l),
          TextField(
            controller: _review,
            minLines: 4,
            maxLines: 8,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: context.l10n.reviewHint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: FilledButton(
            onPressed: isSaving || _rating == 0 ? null : _save,
            child: Text(context.l10n.saveReview),
          ),
        ),
      ),
    );
  }
}
