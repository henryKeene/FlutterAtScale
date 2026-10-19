import 'package:book_details/book_details.dart';
import 'package:navigation/src/router.dart';
import 'package:navigation/src/routes.dart';

class BookDetailsNavigation implements IBookDetailsNavigation {
  @override
  void back() => router.pop();

  @override
  void searchSubject(String subject) =>
      router.go(Routes.discoverQuery(subject));
}
