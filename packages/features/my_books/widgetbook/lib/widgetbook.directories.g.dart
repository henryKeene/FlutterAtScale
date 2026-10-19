// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:my_books_widgetbook/my_books.dart'
    as _my_books_widgetbook_my_books;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'My books',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'MyBooksFlow',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Empty shelf',
            builder: _my_books_widgetbook_my_books.myBooksEmpty,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Loading',
            builder: _my_books_widgetbook_my_books.myBooksLoading,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Offline',
            builder: _my_books_widgetbook_my_books.myBooksOffline,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Shelf',
            builder: _my_books_widgetbook_my_books.myBooksShelf,
          ),
        ],
      ),
    ],
  ),
];
