import 'dart:async';

import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  new(this._service) : super(ThemeMode.system);

  final IThemeModeService _service;
  StreamSubscription<ThemeMode>? _subscription;

  Future<void> load() async {
    _subscription ??= _service.changes.listen(emit);
    emit(await _service.themeMode());
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
