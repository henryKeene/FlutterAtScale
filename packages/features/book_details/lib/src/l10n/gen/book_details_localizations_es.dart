// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'book_details_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class BookDetailsLocalizationsEs extends BookDetailsLocalizations {
  BookDetailsLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get removeFromShelf => 'Quitar de la estantería';

  @override
  String get savedCopyTitle => 'Mostrando tu copia guardada';

  @override
  String get savedCopyMessage => 'No se ha podido conectar con Open Library.';

  @override
  String get aboutThisBook => 'Sobre este libro';

  @override
  String get subjects => 'Temas';

  @override
  String get addToShelf => 'Añadir a la estantería';

  @override
  String get changeShelf => 'Cambiar de estantería';

  @override
  String movedTo(String shelf) {
    return 'Movido a «$shelf»';
  }

  @override
  String firstPublished(int year) {
    return 'Publicado por primera vez en $year';
  }

  @override
  String get yourReview => 'Tu reseña';

  @override
  String get skip => 'Omitir';

  @override
  String reviewPrompt(String title) {
    return '¿Qué te ha parecido $title?';
  }

  @override
  String get reviewHint => '¿Qué opinas?';

  @override
  String get saveReview => 'Guardar reseña';
}
