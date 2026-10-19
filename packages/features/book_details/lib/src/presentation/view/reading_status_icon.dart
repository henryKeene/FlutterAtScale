import 'package:core_books/core_books.dart';
import 'package:material_ui/material_ui.dart';

extension ReadingStatusIcon on ReadingStatus {
  IconData get icon => switch (this) {
    ReadingStatus.reading => Icons.auto_stories_outlined,
    ReadingStatus.wantToRead => Icons.bookmark_border,
    ReadingStatus.read => Icons.task_alt,
  };
}
