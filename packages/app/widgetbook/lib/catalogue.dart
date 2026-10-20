import 'package:book_details/book_details.dart' show BookDetailsLocalizations;
import 'package:book_details_widgetbook/fakes.dart' as book_details;
import 'package:book_details_widgetbook/widgetbook.directories.g.dart'
    as book_details;
import 'package:core_books/core_books.dart' show CoreBooksLocalizations;
import 'package:core_design_system/core_design_system.dart';
import 'package:core_design_system_widgetbook/widgetbook.directories.g.dart'
    as design_system;
import 'package:core_di/core_di.dart';
import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/my_books.dart' show MyBooksLocalizations;
import 'package:my_books_widgetbook/fakes.dart' as my_books;
import 'package:my_books_widgetbook/widgetbook.directories.g.dart' as my_books;

/// Registers the fakes every Widgetbook in the catalogue needs.
void registerFakes(GetIt getIt) {
  book_details.Fakes.register(getIt);
  my_books.Fakes.register(getIt);
}

/// Every Widgetbook in one app: the design system's and each feature's.
///
/// Teams work in their own package's Widgetbook. The catalogue puts them
/// together for hosting, so Widgetbook Cloud needs one project, and a change
/// to the design system shows up in the same review as every screen that
/// uses it.
class Catalogue extends StatelessWidget {
  const new({this.initialRoute = '/', super.key});

  /// Where to open, such as `/?path=book-details/bookdetailsflow/not-found`.
  final String initialRoute;

  @override
  Widget build(BuildContext context) => BookshelfWidgetbook(
    initialRoute: initialRoute,
    directories: [
      ...design_system.directories,
      ...book_details.directories,
      ...my_books.directories,
    ],
    locales: BookDetailsLocalizations.supportedLocales,
    localizationsDelegates: const [
      ...GlobalMaterialLocalizations.delegates,
      CoreDesignSystemLocalizations.delegate,
      CoreBooksLocalizations.delegate,
      BookDetailsLocalizations.delegate,
      MyBooksLocalizations.delegate,
    ],
  );
}
