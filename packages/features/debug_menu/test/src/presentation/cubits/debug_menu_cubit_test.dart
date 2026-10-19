import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:core_config/core_config.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:debug_menu/src/presentation/cubits/debug_menu_cubit/debug_menu_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFeatureFlagService extends Mock implements IFeatureFlagService;

FeatureFlags _flags(FlagSource source) => FeatureFlags({
  FeatureFlag.shelfGrid: ResolvedFlag(enabled: true, source: source),
});

void main() {
  final config = AppConfig.forEnvironment(AppEnvironment.development);

  late _MockFeatureFlagService service;
  late StreamController<FeatureFlags> changes;

  setUp(() {
    service = _MockFeatureFlagService();
    changes = StreamController.broadcast();
    when(() => service.current).thenReturn(_flags(FlagSource.defaults));
    when(() => service.changes).thenAnswer((_) => changes.stream);
    when(() => service.setOverride(any(), enabled: any(named: 'enabled')))
        .thenAnswer((_) async {});
    when(() => service.refreshRemote()).thenAnswer((_) async {});
  });

  setUpAll(() => registerFallbackValue(FeatureFlag.shelfGrid));

  tearDown(() => changes.close());

  DebugMenuCubit buildCubit() => DebugMenuCubit(service, config);

  group('DebugMenuCubit', () {
    test('starts with the current flags', () {
      final cubit = buildCubit();

      expect(cubit.state.flags, _flags(FlagSource.defaults));
      expect(cubit.state.hasOverrides, isFalse);
    });

    blocTest<DebugMenuCubit, DebugMenuState>(
      'reflects flag changes from the service',
      build: buildCubit,
      act: (_) => changes.add(_flags(FlagSource.override)),
      expect: () => [
        DebugMenuState(
          flags: _flags(FlagSource.override),
          environment: AppEnvironment.development,
        ),
      ],
      verify: (cubit) => expect(cubit.state.hasOverrides, isTrue),
    );

    blocTest<DebugMenuCubit, DebugMenuState>(
      'toggling a flag stores an override',
      build: buildCubit,
      act: (cubit) => cubit.toggle(FeatureFlag.shelfGrid, enabled: false),
      verify: (_) => verify(
        () => service.setOverride(FeatureFlag.shelfGrid, enabled: false),
      ).called(1),
    );

    blocTest<DebugMenuCubit, DebugMenuState>(
      'shows progress while remote flags refresh',
      build: buildCubit,
      act: (cubit) => cubit.refreshRemote(),
      expect: () => [
        isA<DebugMenuState>().having((s) => s.isRefreshing, 'refreshing', true),
        isA<DebugMenuState>().having(
          (s) => s.isRefreshing,
          'refreshing',
          false,
        ),
      ],
    );
  });
}
