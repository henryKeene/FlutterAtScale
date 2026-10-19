// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'my_books_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class MyBooksLocalizationsEs extends MyBooksLocalizations {
  MyBooksLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Mis libros';

  @override
  String get emptyShelfTitle => 'Tu estantería está vacía';

  @override
  String get emptyShelfMessage =>
      'Busca un libro que estés leyendo o quieras leer y añádelo aquí.';

  @override
  String get findABook => 'Buscar un libro';

  @override
  String get emptyFilterTitle => 'Aún no hay nada';

  @override
  String emptyFilterMessage(String shelf) {
    return 'Los libros que marques como «$shelf» aparecerán aquí.';
  }

  @override
  String get loadFailed => 'No hemos podido cargar tu estantería.';
}
