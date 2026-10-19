import 'package:book_details_widgetbook/fakes.dart';
import 'package:book_details_widgetbook/widgetbook.dart';
import 'package:core_di/core_di.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Fakes.register(getIt);
  runApp(const BookDetailsWidgetbook());
}
