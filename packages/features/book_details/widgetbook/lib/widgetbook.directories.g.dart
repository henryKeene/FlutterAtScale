// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:book_details_widgetbook/book_details.dart'
    as _book_details_widgetbook_book_details;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'Book details',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'BookDetailsFlow',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Full details',
            builder: _book_details_widgetbook_book_details.fullDetails,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Not found',
            builder: _book_details_widgetbook_book_details.notFound,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Offline with a saved copy',
            builder: _book_details_widgetbook_book_details.offlineWithSavedCopy,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Slow catalogue',
            builder: _book_details_widgetbook_book_details.slowCatalogue,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Sparse details',
            builder: _book_details_widgetbook_book_details.sparseDetails,
          ),
        ],
      ),
    ],
  ),
];
