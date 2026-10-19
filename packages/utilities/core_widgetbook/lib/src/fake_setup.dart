import 'package:material_ui/material_ui.dart';

/// Applies a use case's knobs to its fakes, then builds [child].
///
/// A use case builds again whenever anything around it changes, such as the
/// theme or a knob. Applying the setup only when [value] changes keeps
/// whatever you did in the flow, such as a book you just shelved, until you
/// change one of the knobs it depends on.
///
/// Knobs a flow reads as it goes, such as a feature flag, can change while
/// it runs. Knobs that decide where it starts, such as which book it opens,
/// need a fresh start: key [child] by them too.
class FakeSetup<T> extends StatefulWidget {
  const new({
    required this.value,
    required this.apply,
    required this.child,
    super.key,
  });

  /// The knob values [apply] uses. They must compare by value, as records
  /// of plain values do.
  final T value;

  final VoidCallback apply;

  final Widget child;

  @override
  State<FakeSetup<T>> createState() => _FakeSetupState<T>();
}

class _FakeSetupState<T> extends State<FakeSetup<T>> {
  @override
  void initState() {
    super.initState();
    widget.apply();
  }

  @override
  void didUpdateWidget(FakeSetup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) widget.apply();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
