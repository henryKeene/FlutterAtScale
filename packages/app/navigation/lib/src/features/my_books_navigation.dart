import 'dart:async';

import 'package:my_books/my_books.dart';
import 'package:navigation/src/router.dart';
import 'package:navigation/src/routes.dart';

class MyBooksNavigation implements IMyBooksNavigation {
  @override
  void openBook(String workId) =>
      unawaited(router.push(Routes.bookFor(workId)));

  @override
  void openDiscover() => router.go(Routes.discover);
}
