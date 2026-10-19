/// Fakes of this package's services, and books for them to serve.
///
/// They are for Widgetbook and tests. `melos run boundaries` fails if app,
/// feature or utility code imports this library, so none of it reaches the
/// app.
library;

export 'src/fakes/fake_book_catalog_service.dart';
export 'src/fakes/fake_library_service.dart';
export 'src/fakes/sample_books.dart';
