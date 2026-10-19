// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'settings_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SettingsLocalizationsEs extends SettingsLocalizations {
  SettingsLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Ajustes';

  @override
  String get appearance => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get readingSection => 'Lectura';

  @override
  String get yearlyGoal => 'Objetivo anual';

  @override
  String goalBooks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count libros',
      one: '1 libro',
    );
    return '$_temp0';
  }

  @override
  String get fewerBooks => 'Menos';

  @override
  String get moreBooks => 'Más';

  @override
  String get about => 'Acerca de';

  @override
  String get environment => 'Entorno';

  @override
  String get developerOptions => 'Opciones de desarrollador';

  @override
  String get developerOptionsSubtitle => 'Feature flags y anulaciones';

  @override
  String get environmentDevelopment => 'Desarrollo';

  @override
  String get environmentStaging => 'Preproducción';

  @override
  String get environmentProduction => 'Producción';
}
