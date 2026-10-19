import 'package:flutter/widgets.dart';
import 'package:my_books/src/l10n/gen/my_books_localizations.dart';

extension MyBooksL10n on BuildContext {
  MyBooksLocalizations get l10n => MyBooksLocalizations.of(this);
}
