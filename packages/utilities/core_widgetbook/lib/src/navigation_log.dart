import 'package:material_ui/material_ui.dart';

/// The messenger of the app each use case runs in.
final navigationLogMessenger = GlobalKey<ScaffoldMessengerState>();

/// Shows a call a feature made to leave, such as `Book details → back()`.
///
/// Each feature's Widgetbook answers its navigation interface with this, so
/// instead of going anywhere you see the feature's whole contract with the
/// rest of the app.
void showNavigation(String call) => navigationLogMessenger.currentState
  ?..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(content: Text(call)));
