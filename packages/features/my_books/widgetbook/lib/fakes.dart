import 'package:core_books/core_books.dart';
import 'package:core_books/fakes.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/fakes.dart';
import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:my_books/my_books.dart';

/// What `MyBooksFlow` depends on, faked.
///
/// The library and navigation go in the root scope, where the app registers
/// the real ones. The flags reach the screen through a `FeatureFlagsCubit`,
/// which each use case provides, as the app does above every screen. The
/// core fakes are shared instances, so this Widgetbook can run in one app
/// with others.
abstract final class Fakes {
  static final FakeLibraryService library = FakeLibraryService.shared;
  static final FakeFeatureFlagService flags = FakeFeatureFlagService.shared;
  static final navigation = MyBooksNavigationLog();

  static void register(GetIt getIt) {
    getIt
      ..registerFake<ILibraryService>(library)
      ..registerFake<IMyBooksNavigation>(navigation);
  }
}

/// Where My books tries to go, shown instead of going there.
final class MyBooksNavigationLog implements IMyBooksNavigation {
  @override
  void openBook(String workId) =>
      showNavigation('My books → openBook($workId)');

  @override
  void openDiscover() => showNavigation('My books → openDiscover()');
}
