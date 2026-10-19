import 'package:bloc_test/bloc_test.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFeatureFlagsCubit extends MockCubit<FeatureFlags>
    implements FeatureFlagsCubit;

FeatureFlags _flags({required bool shelfGrid}) => FeatureFlags({
  FeatureFlag.shelfGrid: ResolvedFlag(
    enabled: shelfGrid,
    source: FlagSource.override,
  ),
});

void main() {
  late _MockFeatureFlagsCubit cubit;

  setUp(() => cubit = _MockFeatureFlagsCubit());

  Future<void> pumpGate(WidgetTester tester) => tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: BlocProvider<FeatureFlagsCubit>.value(
        value: cubit,
        child: const FeatureGate(
          flag: FeatureFlag.shelfGrid,
          fallback: Text('list'),
          child: Text('grid'),
        ),
      ),
    ),
  );

  group('FeatureGate', () {
    testWidgets('shows the child when the flag is enabled', (tester) async {
      when(() => cubit.state).thenReturn(_flags(shelfGrid: true));

      await pumpGate(tester);

      expect(find.text('grid'), findsOneWidget);
      expect(find.text('list'), findsNothing);
    });

    testWidgets('shows the fallback when the flag is disabled', (tester) async {
      when(() => cubit.state).thenReturn(_flags(shelfGrid: false));

      await pumpGate(tester);

      expect(find.text('list'), findsOneWidget);
    });

    testWidgets('rebuilds when the flag changes', (tester) async {
      whenListen(
        cubit,
        Stream.value(_flags(shelfGrid: true)),
        initialState: _flags(shelfGrid: false),
      );

      await pumpGate(tester);
      await tester.pump();

      expect(find.text('grid'), findsOneWidget);
    });
  });
}
