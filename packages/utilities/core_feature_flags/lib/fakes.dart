/// A fake of this package's service, for Widgetbook and tests.
///
/// `melos run boundaries` fails if app, feature or utility code imports
/// this library, so none of it reaches the app.
library;

export 'src/fakes/fake_feature_flag_service.dart';
