import 'package:book_details/book_details.dart';
import 'package:book_details_widgetbook/widgetbook.directories.g.dart';
import 'package:core_books/core_books.dart' show CoreBooksLocalizations;
import 'package:core_design_system/core_design_system.dart';
import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// The book_details feature on its own, against the fakes in `Fakes`.
@widgetbook.App()
class BookDetailsWidgetbook extends StatelessWidget {
  const new({this.initialRoute = '/', super.key});

  final String initialRoute;

  @override
  Widget build(BuildContext context) => BookshelfWidgetbook(
    initialRoute: initialRoute,
    directories: directories,
    locales: BookDetailsLocalizations.supportedLocales,
    localizationsDelegates: const [
      ...GlobalMaterialLocalizations.delegates,
      CoreDesignSystemLocalizations.delegate,
      CoreBooksLocalizations.delegate,
      BookDetailsLocalizations.delegate,
    ],
  );
}
