import 'dart:async';

import 'package:core_di/core_di.dart';
import 'package:discover/src/domain/di/di_init.dart';
import 'package:discover/src/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:discover/src/presentation/cubits/trending_cubit/trending_cubit.dart';
import 'package:discover/src/presentation/view/pages/discover_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class DiscoverFlow extends StatefulWidget {
  const new({this.initialQuery, super.key});

  final String? initialQuery;

  @override
  State<DiscoverFlow> createState() => _DiscoverFlowState();
}

class _DiscoverFlowState extends State<DiscoverFlow> {
  late final SearchCubit _search;

  @override
  void initState() {
    super.initState();
    initialize();
    _search = getIt<SearchCubit>();
    _searchFor(widget.initialQuery);
  }

  @override
  void didUpdateWidget(DiscoverFlow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuery != oldWidget.initialQuery) {
      _searchFor(widget.initialQuery);
    }
  }

  @override
  void dispose() {
    unawaited(_search.close());
    unawaited(deinitialize());
    super.dispose();
  }

  void _searchFor(String? query) {
    if (query == null || query.isEmpty) return;
    unawaited(_search.search(query));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _search),
        BlocProvider(create: (_) => getIt<TrendingCubit>()..load()),
      ],
      child: const DiscoverPage(),
    );
  }
}
