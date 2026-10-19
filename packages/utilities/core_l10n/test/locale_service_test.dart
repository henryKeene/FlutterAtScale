import 'package:core_l10n/core_l10n.dart';
import 'package:core_l10n/src/data/services/locale_service.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockKeyValueStore extends Mock implements IKeyValueStore;

void main() {
  late _MockKeyValueStore store;
  late LocaleService service;

  setUp(() {
    store = _MockKeyValueStore();
    service = LocaleService(store);
    when(() => store.writeString(any(), any())).thenAnswer((_) async {});
    when(() => store.delete(any())).thenAnswer((_) async {});
  });

  group('LocaleService', () {
    test('follows the system when nothing is stored', () async {
      when(() => store.readString(any())).thenAnswer((_) async => null);

      expect(await service.locale(), isNull);
    });

    test('ignores a stored language the app no longer supports', () async {
      when(() => store.readString(any())).thenAnswer((_) async => 'fr');

      expect(await service.locale(), isNull);
    });

    test('reads a supported stored language', () async {
      when(() => store.readString(any())).thenAnswer((_) async => 'es');

      expect(await service.locale(), AppLocales.spanish);
    });

    test('saves and broadcasts a chosen language', () async {
      final emitted = expectLater(service.changes, emits(AppLocales.spanish));

      await service.setLocale(AppLocales.spanish);

      await emitted;
      verify(() => store.writeString('locale', 'es')).called(1);
    });

    test('going back to the system language clears the preference', () async {
      await service.setLocale(null);

      verify(() => store.delete('locale')).called(1);
    });
  });
}
