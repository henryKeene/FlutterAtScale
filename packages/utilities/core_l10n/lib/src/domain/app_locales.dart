import 'package:flutter/widgets.dart';

abstract final class AppLocales {
  static const english = Locale('en');
  static const spanish = Locale('es');

  static const List<Locale> supported = [english, spanish];

  static String nativeName(Locale locale) => switch (locale.languageCode) {
    'es' => 'Español',
    _ => 'English',
  };
}
