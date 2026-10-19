part of 'debug_menu_cubit.dart';

final class DebugMenuState extends Equatable {
  const new({
    required this.flags,
    required this.environment,
    this.isRefreshing = false,
  });

  final FeatureFlags flags;
  final AppEnvironment environment;
  final bool isRefreshing;

  bool get hasOverrides => FeatureFlag.values.any(
    (flag) => flags.resolved(flag).source == FlagSource.override,
  );

  DebugMenuState copyWith({FeatureFlags? flags, bool? isRefreshing}) =>
      DebugMenuState(
        flags: flags ?? this.flags,
        environment: environment,
        isRefreshing: isRefreshing ?? this.isRefreshing,
      );

  @override
  List<Object?> get props => [flags, environment, isRefreshing];
}
