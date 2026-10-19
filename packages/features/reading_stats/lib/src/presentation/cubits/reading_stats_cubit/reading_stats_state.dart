part of 'reading_stats_cubit.dart';

sealed class ReadingStatsState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class ReadingStatsLoading extends ReadingStatsState {
  const new();
}

final class ReadingStatsLoaded extends ReadingStatsState {
  const new(this.stats);

  final ReadingStats stats;

  @override
  List<Object?> get props => [stats];
}
