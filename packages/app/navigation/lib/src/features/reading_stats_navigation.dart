import 'package:navigation/src/router.dart';
import 'package:navigation/src/routes.dart';
import 'package:reading_stats/reading_stats.dart';

class ReadingStatsNavigation implements IReadingStatsNavigation {
  @override
  void openDiscover() => router.go(Routes.discover);
}
