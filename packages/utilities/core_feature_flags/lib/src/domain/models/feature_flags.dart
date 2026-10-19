import 'package:core_feature_flags/src/domain/models/feature_flag.dart';
import 'package:equatable/equatable.dart';

enum FlagSource {
  defaults('Default'),
  remote('Remote'),
  override('Override');

  new(this.label);

  final String label;
}

class ResolvedFlag extends Equatable {
  const new({required this.enabled, required this.source});

  final bool enabled;
  final FlagSource source;

  @override
  List<Object?> get props => [enabled, source];
}

class FeatureFlags extends Equatable {
  const new(this.values);

  final Map<FeatureFlag, ResolvedFlag> values;

  bool isEnabled(FeatureFlag flag) => values[flag]?.enabled ?? false;

  ResolvedFlag resolved(FeatureFlag flag) =>
      values[flag] ??
      const ResolvedFlag(enabled: false, source: FlagSource.defaults);

  @override
  List<Object?> get props => [values];
}
