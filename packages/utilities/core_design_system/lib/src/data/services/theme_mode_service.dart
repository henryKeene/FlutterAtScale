import 'dart:async';

import 'package:core_design_system/src/domain/interfaces/i_theme_mode_service.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';

@LazySingleton(as: IThemeModeService)
class ThemeModeService implements IThemeModeService {
  new(this._store);

  static const _key = 'theme_mode';

  final IKeyValueStore _store;
  final _changes = StreamController<ThemeMode>.broadcast();

  @override
  Stream<ThemeMode> get changes => _changes.stream;

  @override
  Future<ThemeMode> themeMode() async {
    final stored = await _store.readString(_key);
    return ThemeMode.values.asNameMap()[stored] ?? ThemeMode.system;
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    await _store.writeString(_key, mode.name);
    _changes.add(mode);
  }
}
