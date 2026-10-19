import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:bookshelf/app/cubits/theme_cubit/theme_cubit.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _MockThemeModeService extends Mock implements IThemeModeService;

void main() {
  late _MockThemeModeService service;
  late StreamController<ThemeMode> changes;

  setUp(() {
    service = _MockThemeModeService();
    changes = StreamController.broadcast();
    when(() => service.changes).thenAnswer((_) => changes.stream);
    when(() => service.themeMode()).thenAnswer((_) async => ThemeMode.dark);
  });

  tearDown(() => changes.close());

  group('ThemeCubit', () {
    blocTest<ThemeCubit, ThemeMode>(
      'loads the saved theme mode',
      build: () => ThemeCubit(service),
      act: (cubit) => cubit.load(),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'follows changes made elsewhere in the app',
      build: () => ThemeCubit(service),
      act: (cubit) async {
        await cubit.load();
        changes.add(ThemeMode.light);
      },
      expect: () => [ThemeMode.dark, ThemeMode.light],
    );
  });
}
