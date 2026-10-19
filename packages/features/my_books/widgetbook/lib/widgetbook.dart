import 'package:core_books/core_books.dart' show CoreBooksLocalizations;
import 'package:core_design_system/core_design_system.dart';
import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/my_books.dart';
import 'package:my_books_widgetbook/widgetbook.directories.g.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// The my_books feature on its own, against the fakes in `Fakes`.
@widgetbook.App()
class MyBooksWidgetbook extends StatelessWidget {
  const new({this.initialRoute = '/', super.key});

  final String initialRoute;

  @override
  Widget build(BuildContext context) => BookshelfWidgetbook(
    initialRoute: initialRoute,
    directories: directories,
    locales: MyBooksLocalizations.supportedLocales,
    localizationsDelegates: const [
      ...GlobalMaterialLocalizations.delegates,
      CoreDesignSystemLocalizations.delegate,
      CoreBooksLocalizations.delegate,
      MyBooksLocalizations.delegate,
    ],
  );
}
