import 'package:core_prelude/core_prelude.dart';

sealed class CatalogFailure extends AppFailure {
  const new(super.message);
}

final class CatalogUnavailable extends CatalogFailure {
  const new()
    : super(
        "We couldn't reach Open Library. Check your connection and try again.",
      );
}

final class BookNotFound extends CatalogFailure {
  const new() : super("We couldn't find that book.");
}
