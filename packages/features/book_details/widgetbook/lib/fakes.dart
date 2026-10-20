import 'package:book_details/book_details.dart';
import 'package:core_books/core_books.dart';
import 'package:core_books/fakes.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:core_feature_flags/fakes.dart';
import 'package:core_widgetbook/core_widgetbook.dart';

/// The four services `BookDetailsFlow` depends on, faked.
///
/// They go in the root scope, where the app registers the real ones, so the
/// flow finds them exactly as it finds the real services. The core fakes are
/// shared instances, so this Widgetbook can run in one app with others.
abstract final class Fakes {
  static final FakeBookCatalogService catalog = FakeBookCatalogService.shared;
  static final FakeLibraryService library = FakeLibraryService.shared;
  static final FakeFeatureFlagService flags = FakeFeatureFlagService.shared;
  static final navigation = BookDetailsNavigationLog();

  static void register(GetIt getIt) {
    getIt
      ..registerFake<IBookCatalogService>(catalog)
      ..registerFake<ILibraryService>(library)
      ..registerFake<IFeatureFlagService>(flags)
      ..registerFake<IBookDetailsNavigation>(navigation);
  }
}

/// Where book details tries to go, shown instead of going there.
final class BookDetailsNavigationLog implements IBookDetailsNavigation {
  @override
  void back() => showNavigation('Book details → back()');

  @override
  void searchSubject(String subject) =>
      showNavigation("Book details → searchSubject('$subject')");
}
