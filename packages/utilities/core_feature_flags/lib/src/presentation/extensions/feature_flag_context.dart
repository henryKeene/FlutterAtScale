import 'package:core_feature_flags/src/domain/models/feature_flag.dart';
import 'package:core_feature_flags/src/presentation/cubit/feature_flags_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension FeatureFlagContext on BuildContext {
  bool isFeatureEnabled(FeatureFlag flag) =>
      select<FeatureFlagsCubit, bool>((cubit) => cubit.state.isEnabled(flag));
}
