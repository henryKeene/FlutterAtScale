// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'reading_stats_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class ReadingStatsLocalizationsEs extends ReadingStatsLocalizations {
  ReadingStatsLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Estadísticas de lectura';

  @override
  String get emptyTitle => 'Aún no hay nada que contar';

  @override
  String get emptyMessage =>
      'Añade algunos libros a tu estantería para ver tus estadísticas.';

  @override
  String get findABook => 'Buscar un libro';

  @override
  String goalTitle(int year) {
    return 'Objetivo de lectura de $year';
  }

  @override
  String goalProgress(int read, int goal) {
    String _temp0 = intl.Intl.pluralLogic(
      goal,
      locale: localeName,
      other: '$goal libros',
      one: '1 libro',
    );
    return '$read de $_temp0';
  }

  @override
  String booksToGo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Te quedan $count libros',
      one: 'Te queda 1 libro',
    );
    return '$_temp0';
  }

  @override
  String get goalReached => 'Objetivo cumplido. ¡Buen trabajo!';

  @override
  String get averageRating => 'Nota media';

  @override
  String get finishedByMonth => 'Terminados por mes';
}
