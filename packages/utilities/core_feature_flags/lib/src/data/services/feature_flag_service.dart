import 'dart:async';
import 'dart:convert';

import 'package:core_config/core_config.dart';
import 'package:core_feature_flags/src/domain/flag_defaults.dart';
import 'package:core_feature_flags/src/domain/interfaces/i_feature_flag_service.dart';
import 'package:core_feature_flags/src/domain/interfaces/i_remote_flag_source.dart';
import 'package:core_feature_flags/src/domain/models/feature_flag.dart';
import 'package:core_feature_flags/src/domain/models/feature_flags.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFeatureFlagService)
class FeatureFlagService implements IFeatureFlagService {
  new(this._config, this._remoteSource, this._store);

  static const _overridesKey = 'feature_flag_overrides';

  final AppConfig _config;
  final IRemoteFlagSource _remoteSource;
  final IKeyValueStore _store;
  final _changes = StreamController<FeatureFlags>.broadcast();

  Map<String, bool> _remote = const {};
  Map<String, bool> _overrides = const {};
  late FeatureFlags _current = _resolve();

  @override
  FeatureFlags get current => _current;

  @override
  Stream<FeatureFlags> get changes => _changes.stream;

  @override
  bool isEnabled(FeatureFlag flag) => _current.isEnabled(flag);

  @override
  Future<void> load() async {
    _overrides = await _readOverrides();
    await refreshRemote();
  }

  @override
  Future<void> refreshRemote() async {
    final result = await _remoteSource.fetch();
    _remote = result.getOrElse(() => _remote);
    _publish();
  }

  @override
  Future<void> setOverride(FeatureFlag flag, {required bool? enabled}) async {
    _overrides = {
      for (final MapEntry(:key, :value) in _overrides.entries)
        if (key != flag.key) key: value,
      flag.key: ?enabled,
    };
    await _store.writeString(_overridesKey, jsonEncode(_overrides));
    _publish();
  }

  @override
  Future<void> clearOverrides() async {
    _overrides = const {};
    await _store.delete(_overridesKey);
    _publish();
  }

  void _publish() {
    _current = _resolve();
    _changes.add(_current);
  }

  FeatureFlags _resolve() {
    final defaults = flagDefaults(_config.environment);
    final overrides = _config.isProduction
        ? const <String, bool>{}
        : _overrides;

    return FeatureFlags({
      for (final flag in FeatureFlag.values)
        flag: switch ((overrides[flag.key], _remote[flag.key])) {
          (final bool enabled, _) => ResolvedFlag(
            enabled: enabled,
            source: FlagSource.override,
          ),
          (_, final bool enabled) => ResolvedFlag(
            enabled: enabled,
            source: FlagSource.remote,
          ),
          _ => ResolvedFlag(
            enabled: defaults[flag] ?? false,
            source: FlagSource.defaults,
          ),
        },
    });
  }

  Future<Map<String, bool>> _readOverrides() async {
    final stored = await _store.readString(_overridesKey);
    if (stored == null) return const {};
    try {
      return (jsonDecode(stored) as Map<String, dynamic>).cast<String, bool>();
    } on FormatException {
      return const {};
    }
  }
}
