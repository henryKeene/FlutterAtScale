import 'package:flutter/widgets.dart';

abstract interface class ILocaleService {
  Stream<Locale?> get changes;

  Future<Locale?> locale();

  Future<void> setLocale(Locale? locale);
}
