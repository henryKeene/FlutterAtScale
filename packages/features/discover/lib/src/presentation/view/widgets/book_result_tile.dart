import 'package:core_books/core_books.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';

class BookResultTile extends StatelessWidget {
  const new({required this.book, required this.onTap, super.key});

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final details = [
      book.byline(context),
      if (book.firstPublishYear case final year?) '$year',
    ].join(' · ');

    return BookListTile(
      title: book.title,
      subtitle: details,
      coverUrl: book.coverUrl(CoverSize.medium),
      onTap: onTap,
    );
  }
}
