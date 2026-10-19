import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:navigation/src/l10n/gen/navigation_localizations.dart';
import 'package:navigation/src/l10n/l10n.dart';

class AppShell extends StatelessWidget {
  const new({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _ShellTab.myBooks,
      _ShellTab.discover,
      if (context.isFeatureEnabled(FeatureFlag.readingStats)) _ShellTab.stats,
      _ShellTab.settings,
    ];
    final selected = tabs.indexWhere((tab) => tab.branch == shell.currentIndex);

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected < 0 ? 0 : selected,
        onDestinationSelected: (index) => shell.goBranch(
          tabs[index].branch,
          initialLocation: tabs[index].branch == shell.currentIndex,
        ),
        destinations: [
          for (final tab in tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tab.label(context.l10n),
            ),
        ],
      ),
    );
  }
}

enum _ShellTab {
  myBooks(
    branch: 0,
    icon: Icons.collections_bookmark_outlined,
    selectedIcon: Icons.collections_bookmark,
  ),
  discover(
    branch: 1,
    icon: Icons.explore_outlined,
    selectedIcon: Icons.explore,
  ),
  stats(branch: 2, icon: Icons.insights_outlined, selectedIcon: Icons.insights),
  settings(
    branch: 3,
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  );

  new({required this.branch, required this.icon, required this.selectedIcon});

  final int branch;
  final IconData icon;
  final IconData selectedIcon;

  String label(NavigationLocalizations l10n) => switch (this) {
    _ShellTab.myBooks => l10n.tabMyBooks,
    _ShellTab.discover => l10n.tabDiscover,
    _ShellTab.stats => l10n.tabStats,
    _ShellTab.settings => l10n.tabSettings,
  };
}
