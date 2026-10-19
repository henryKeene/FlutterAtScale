import 'dart:async';

import 'package:core_l10n/src/domain/app_locales.dart';
import 'package:core_l10n/src/domain/interfaces/i_locale_service.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocaleService)
class LocaleService implements ILocaleService {
  new(this._store);

  static const _key = 'locale';

  final IKeyValueStore _store;
  final _changes = StreamController<Locale?>.broadcast();

  @override
  Stream<Locale?> get changes => _changes.stream;

  @override
  Future<Locale?> locale() async {
    final stored = await _store.readString(_key);
    return AppLocales.supported
        .where((locale) => locale.languageCode == stored)
        .firstOrNull;
  }

  @override
  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await _store.delete(_key);
    } else {
      await _store.writeString(_key, locale.languageCode);
    }
    _changes.add(locale);
  }
}
