import 'dart:async';

import 'package:core_di/core_di.dart';
import 'package:debug_menu/src/domain/di/di_init.dart';
import 'package:debug_menu/src/presentation/cubits/debug_menu_cubit/debug_menu_cubit.dart';
import 'package:debug_menu/src/presentation/view/pages/debug_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class DebugMenuFlow extends StatefulWidget {
  const new({super.key});

  @override
  State<DebugMenuFlow> createState() => _DebugMenuFlowState();
}

class _DebugMenuFlowState extends State<DebugMenuFlow> {
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
      create: (_) => getIt<DebugMenuCubit>(),
      child: const DebugMenuPage(),
    );
  }
}
