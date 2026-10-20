import 'package:material_ui/material_ui.dart';

/// Shows that something is loading.
///
/// It spins while animations run. Where they are paused, as in Widgetbook
/// Cloud's snapshots, it holds still as a part-drawn ring: a paused spinner
/// shrinks to a dot, which shows a reviewer nothing.
class LoadingIndicator extends StatelessWidget {
  const new({super.key});

  /// How much of the ring is drawn while animations are paused.
  static const double pausedValue = 0.75;

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
    value: TickerMode.valuesOf(context).enabled ? null : pausedValue,
  );
}
