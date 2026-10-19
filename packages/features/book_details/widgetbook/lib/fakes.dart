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
/// flow finds them exactly as it finds the real services.
abstract final class Fakes {
  static final catalog = FakeBookCatalogService();
  static final library = FakeLibraryService();
  static final flags = FakeFeatureFlagService();
  static final navigation = BookDetailsNavigationLog();

  static void register(GetIt getIt) {
    getIt
      ..registerSingleton<IBookCatalogService>(catalog)
      ..registerSingleton<ILibraryService>(library)
      ..registerSingleton<IFeatureFlagService>(flags)
      ..registerSingleton<IBookDetailsNavigation>(navigation);
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
