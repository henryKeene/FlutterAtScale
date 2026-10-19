import 'package:book_details/book_details.dart';
import 'package:core_config/core_config.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:debug_menu/debug_menu.dart';
import 'package:discover/discover.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/my_books.dart';
import 'package:navigation/src/routes.dart';
import 'package:navigation/src/stream_listenable.dart';
import 'package:navigation/src/view/app_shell.dart';
import 'package:reading_stats/reading_stats.dart';
import 'package:settings/settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

const Map<String, FeatureFlag> _flaggedRoutes = {
  Routes.stats: FeatureFlag.readingStats,
};

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.myBooks,
  refreshListenable: StreamListenable(getIt<IFeatureFlagService>().changes),
  redirect: _redirectDisabledFeatures,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.myBooks,
              builder: (_, _) => const MyBooksFlow(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.discover,
              builder: (_, state) =>
                  DiscoverFlow(initialQuery: state.uri.queryParameters['q']),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.stats,
              builder: (_, _) => const ReadingStatsFlow(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (_, _) => const SettingsFlow(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.book,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, state) =>
          BookDetailsFlow(workId: state.pathParameters['workId']!),
    ),
    if (!getIt<AppConfig>().isProduction)
      GoRoute(
        path: Routes.developer,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const DebugMenuFlow(),
      ),
  ],
);

String? _redirectDisabledFeatures(BuildContext context, GoRouterState state) {
  final flags = getIt<IFeatureFlagService>();
  final isBlocked = _flaggedRoutes.entries.any(
    (route) =>
        state.matchedLocation.startsWith(route.key) &&
        !flags.isEnabled(route.value),
  );
  return isBlocked ? Routes.myBooks : null;
}
