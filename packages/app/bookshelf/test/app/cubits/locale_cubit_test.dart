import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:bookshelf/app/cubits/locale_cubit/locale_cubit.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocaleService extends Mock implements ILocaleService;

void main() {
  late _MockLocaleService service;
  late StreamController<Locale?> changes;

  setUp(() {
    service = _MockLocaleService();
    changes = StreamController.broadcast();
    when(() => service.changes).thenAnswer((_) => changes.stream);
    when(() => service.locale()).thenAnswer((_) async => AppLocales.spanish);
  });

  tearDown(() => changes.close());

  group('LocaleCubit', () {
    blocTest<LocaleCubit, Locale?>(
      'loads the saved language',
      build: () => LocaleCubit(service),
      act: (cubit) => cubit.load(),
      expect: () => [AppLocales.spanish],
    );

    blocTest<LocaleCubit, Locale?>(
      'goes back to the system language when the preference is cleared',
      build: () => LocaleCubit(service),
      act: (cubit) async {
        await cubit.load();
        changes.add(null);
      },
      expect: () => [AppLocales.spanish, null],
    );
  });
}
