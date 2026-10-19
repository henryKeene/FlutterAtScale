// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'core_books_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class CoreBooksLocalizationsEs extends CoreBooksLocalizations {
  CoreBooksLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get readingStatusReading => 'Leyendo';

  @override
  String get readingStatusWantToRead => 'Por leer';

  @override
  String get readingStatusRead => 'Leído';

  @override
  String get unknownAuthor => 'Autor desconocido';

  @override
  String get catalogUnavailable =>
      'No hemos podido conectar con Open Library. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get bookNotFound => 'No hemos encontrado ese libro.';

  @override
  String get libraryFailure =>
      'No hemos podido actualizar tu estantería. Inténtalo de nuevo.';
}
