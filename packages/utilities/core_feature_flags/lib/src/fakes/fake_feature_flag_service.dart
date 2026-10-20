import 'dart:async';

import 'package:core_feature_flags/src/domain/interfaces/i_feature_flag_service.dart';
import 'package:core_feature_flags/src/domain/models/feature_flag.dart';
import 'package:core_feature_flags/src/domain/models/feature_flags.dart';

/// Feature flags you switch from code. Every flag starts on, unless the
/// map it is given says otherwise.
final class FakeFeatureFlagService implements IFeatureFlagService {
  new([Map<FeatureFlag, bool> enabled = const {}])
    : _enabled = {
        for (final flag in FeatureFlag.values) flag: enabled[flag] ?? true,
      };

  /// The instance every Widgetbook in one app shares, so they all see the
  /// same flags.
  static final shared = FakeFeatureFlagService();

  final Map<FeatureFlag, bool> _enabled;
  final _changes = StreamController<FeatureFlags>.broadcast();

  /// Switches [flag], and tells anything listening if that changed it.
  void set(FeatureFlag flag, {required bool enabled}) {
    if (_enabled[flag] == enabled) return;
    _enabled[flag] = enabled;
    _changes.add(current);
  }

  @override
  FeatureFlags get current => FeatureFlags({
    for (final MapEntry(key: flag, value: enabled) in _enabled.entries)
      flag: ResolvedFlag(enabled: enabled, source: FlagSource.override),
  });

  @override
  Stream<FeatureFlags> get changes => _changes.stream;

  @override
  bool isEnabled(FeatureFlag flag) => _enabled[flag] ?? false;

  @override
  Future<void> load() async {}

  @override
  Future<void> refreshRemote() async {}

  @override
  Future<void> setOverride(FeatureFlag flag, {required bool? enabled}) async =>
      set(flag, enabled: enabled ?? true);

  @override
  Future<void> clearOverrides() async {
    for (final flag in FeatureFlag.values) {
      set(flag, enabled: true);
    }
  }
}
