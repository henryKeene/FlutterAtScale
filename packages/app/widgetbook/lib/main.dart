import 'package:bookshelf_widgetbook/catalogue.dart';
import 'package:core_di/core_di.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  registerFakes(getIt);
  runApp(const Catalogue());
}
