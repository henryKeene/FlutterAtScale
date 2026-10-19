import 'package:material_ui/material_ui.dart';

abstract interface class IThemeModeService {
  Stream<ThemeMode> get changes;

  Future<ThemeMode> themeMode();

  Future<void> setThemeMode(ThemeMode mode);
}
