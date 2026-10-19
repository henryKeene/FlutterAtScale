import 'dart:async';

import 'package:core_di/core_di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:reading_stats/src/domain/di/di_init.dart';
import 'package:reading_stats/src/presentation/cubits/reading_stats_cubit/reading_stats_cubit.dart';
import 'package:reading_stats/src/presentation/view/pages/reading_stats_page.dart';

class ReadingStatsFlow extends StatefulWidget {
  const new({super.key});

  @override
  State<ReadingStatsFlow> createState() => _ReadingStatsFlowState();
}

class _ReadingStatsFlowState extends State<ReadingStatsFlow> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    unawaited(deinitialize());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReadingStatsCubit>()..watch(),
      child: const ReadingStatsPage(),
    );
  }
}
