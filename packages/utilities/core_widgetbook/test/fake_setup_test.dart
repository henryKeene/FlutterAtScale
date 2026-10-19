import 'package:core_widgetbook/core_widgetbook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _Counter extends StatefulWidget {
  const new();

  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int taps = 0;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => setState(() => taps++),
    child: Text('$taps', textDirection: TextDirection.ltr),
  );
}

void main() {
  late List<int> applied;

  setUp(() => applied = []);

  Widget setup(int value) => FakeSetup(
    value: value,
    apply: () => applied.add(value),
    child: const _Counter(),
  );

  testWidgets('applies the setup before the child first builds', (
    tester,
  ) async {
    await tester.pumpWidget(setup(1));

    expect(applied, [1]);
  });

  testWidgets('does not apply it again when nothing it uses changed', (
    tester,
  ) async {
    await tester.pumpWidget(setup(1));
    await tester.pumpWidget(setup(1));

    expect(applied, [1]);
  });

  testWidgets('applies it again when a knob changes, keeping the child', (
    tester,
  ) async {
    await tester.pumpWidget(setup(1));
    await tester.tap(find.text('0'));
    await tester.pump();

    await tester.pumpWidget(setup(2));

    expect(applied, [1, 2]);
    expect(find.text('1'), findsOneWidget);
  });
}
