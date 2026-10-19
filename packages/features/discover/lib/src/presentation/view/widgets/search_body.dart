import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:discover/src/l10n/l10n.dart';
import 'package:discover/src/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:discover/src/presentation/view/widgets/book_result_tile.dart';
import 'package:discover/src/presentation/view/widgets/trending_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class SearchBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    final l10n = context.l10n;

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) => switch (state) {
        SearchIdle() => FeatureGate(
          flag: FeatureFlag.trendingBooks,
          fallback: EmptyState(
            icon: Icons.travel_explore,
            title: l10n.idleTitle,
            message: l10n.idleMessage,
          ),
          child: const TrendingSection(),
        ),
        SearchLoading() => const Center(child: CircularProgressIndicator()),
        SearchEmpty(:final query) => EmptyState(
          icon: Icons.search_off,
          title: l10n.noMatchesTitle,
          message: l10n.noMatchesMessage(query),
        ),
        SearchFailure(:final query, :final failure) => ErrorView(
          message: failure.describe(context),
          onRetry: () => cubit.search(query),
        ),
        SearchResults(:final books) => ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) => BookResultTile(
            book: books[index],
            onTap: () => cubit.openBook(books[index]),
          ),
        ),
      },
    );
  }
}
