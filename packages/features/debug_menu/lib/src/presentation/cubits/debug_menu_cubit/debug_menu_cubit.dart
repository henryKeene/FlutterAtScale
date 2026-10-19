import 'dart:async';

import 'package:core_config/core_config.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'debug_menu_state.dart';

@injectable
class DebugMenuCubit extends Cubit<DebugMenuState> {
  new(IFeatureFlagService flags, AppConfig config)
    : _flags = flags,
      super(
        DebugMenuState(flags: flags.current, environment: config.environment),
      ) {
    _subscription = flags.changes.listen(
      (flags) => emit(state.copyWith(flags: flags)),
    );
  }

  final IFeatureFlagService _flags;
  late final StreamSubscription<FeatureFlags> _subscription;

  Future<void> toggle(FeatureFlag flag, {required bool enabled}) =>
      _flags.setOverride(flag, enabled: enabled);

  Future<void> resetFlag(FeatureFlag flag) =>
      _flags.setOverride(flag, enabled: null);

  Future<void> resetAll() => _flags.clearOverrides();

  Future<void> refreshRemote() async {
    emit(state.copyWith(isRefreshing: true));
    await _flags.refreshRemote();
    emit(state.copyWith(isRefreshing: false));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
