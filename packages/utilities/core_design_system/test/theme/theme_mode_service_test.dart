import 'package:core_design_system/src/data/services/theme_mode_service.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _MockKeyValueStore extends Mock implements IKeyValueStore;

void main() {
  late _MockKeyValueStore store;
  late ThemeModeService service;

  setUp(() {
    store = _MockKeyValueStore();
    service = ThemeModeService(store);
  });

  group('ThemeModeService', () {
    test('defaults to the system theme when nothing is stored', () async {
      when(() => store.readString(any())).thenAnswer((_) async => null);

      expect(await service.themeMode(), ThemeMode.system);
    });

    test('reads a stored theme mode', () async {
      when(() => store.readString(any())).thenAnswer((_) async => 'dark');

      expect(await service.themeMode(), ThemeMode.dark);
    });

    test('persists and broadcasts a new theme mode', () async {
      when(() => store.writeString(any(), any())).thenAnswer((_) async {});

      final emitted = expectLater(service.changes, emits(ThemeMode.light));
      await service.setThemeMode(ThemeMode.light);

      await emitted;
      verify(() => store.writeString('theme_mode', 'light')).called(1);
    });
  });
}
