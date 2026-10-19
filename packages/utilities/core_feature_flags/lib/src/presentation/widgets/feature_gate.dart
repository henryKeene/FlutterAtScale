import 'package:core_feature_flags/src/domain/models/feature_flag.dart';
import 'package:core_feature_flags/src/domain/models/feature_flags.dart';
import 'package:core_feature_flags/src/presentation/cubit/feature_flags_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureGate extends StatelessWidget {
  const new({
    required this.flag,
    required this.child,
    this.fallback = const SizedBox.shrink(),
    super.key,
  });

  final FeatureFlag flag;
  final Widget child;
  final Widget fallback;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FeatureFlagsCubit, FeatureFlags, bool>(
      selector: (flags) => flags.isEnabled(flag),
      builder: (context, enabled) => enabled ? child : fallback,
    );
  }
}
