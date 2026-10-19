import 'package:flutter/widgets.dart';
import 'package:reading_stats/src/l10n/gen/reading_stats_localizations.dart';

extension ReadingStatsL10n on BuildContext {
  ReadingStatsLocalizations get l10n => ReadingStatsLocalizations.of(this);
}
