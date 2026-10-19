import 'dart:async';

import 'package:core_di/core_di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:settings/src/domain/di/di_init.dart';
import 'package:settings/src/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:settings/src/presentation/view/pages/settings_page.dart';

class SettingsFlow extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsFlow> createState() => _SettingsFlowState();
}

class _SettingsFlowState extends State<SettingsFlow> {
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
      create: (_) => getIt<SettingsCubit>()..load(),
      child: const SettingsPage(),
    );
  }
}
