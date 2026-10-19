import 'package:core_di/core_di.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books_widgetbook/fakes.dart';
import 'package:my_books_widgetbook/widgetbook.dart';

void main() {
  Fakes.register(getIt);
  runApp(const MyBooksWidgetbook());
}
