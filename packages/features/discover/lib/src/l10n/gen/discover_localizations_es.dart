// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'discover_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class DiscoverLocalizationsEs extends DiscoverLocalizations {
  DiscoverLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Descubrir';

  @override
  String get searchHint => 'Título, autor o tema';

  @override
  String get clearSearch => 'Borrar';

  @override
  String get idleTitle => 'Encuentra tu próximo libro';

  @override
  String get idleMessage => 'Busca en Open Library por título, autor o tema.';

  @override
  String get noMatchesTitle => 'Sin resultados';

  @override
  String noMatchesMessage(String query) {
    return 'Nada en Open Library coincide con «$query».';
  }

  @override
  String get trendingToday => 'Tendencias de hoy';
}
