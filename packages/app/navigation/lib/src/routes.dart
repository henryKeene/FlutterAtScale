abstract final class Routes {
  static const myBooks = '/books';
  static const discover = '/discover';
  static const stats = '/stats';
  static const settings = '/settings';
  static const developer = '/settings/developer';
  static const book = '/book/:workId';

  static String bookFor(String workId) => '/book/$workId';

  static String discoverQuery(String query) =>
      Uri(path: discover, queryParameters: {'q': query}).toString();
}
