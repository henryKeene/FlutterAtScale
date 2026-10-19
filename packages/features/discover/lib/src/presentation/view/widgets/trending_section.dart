import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:discover/src/l10n/l10n.dart';
import 'package:discover/src/presentation/cubits/trending_cubit/trending_cubit.dart';
import 'package:discover/src/presentation/view/widgets/book_result_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class TrendingSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TrendingCubit>();

    return BlocBuilder<TrendingCubit, TrendingState>(
      builder: (context, state) => switch (state) {
        TrendingLoading() => const Center(child: CircularProgressIndicator()),
        TrendingFailure(:final failure) => ErrorView(
          message: failure.describe(context),
          onRetry: cubit.load,
        ),
        TrendingLoaded(:final books) => ListView(
          children: [
            SectionHeader(context.l10n.trendingToday),
            for (final book in books)
              BookResultTile(book: book, onTap: () => cubit.openBook(book)),
          ],
        ),
      },
    );
  }
}
