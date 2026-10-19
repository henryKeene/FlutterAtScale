import 'package:core_feature_flags/src/domain/models/feature_flag.dart';
import 'package:core_feature_flags/src/domain/models/feature_flags.dart';

abstract interface class IFeatureFlagService {
  FeatureFlags get current;

  Stream<FeatureFlags> get changes;

  bool isEnabled(FeatureFlag flag);

  Future<void> load();

  Future<void> refreshRemote();

  Future<void> setOverride(FeatureFlag flag, {required bool? enabled});

  Future<void> clearOverrides();
}
