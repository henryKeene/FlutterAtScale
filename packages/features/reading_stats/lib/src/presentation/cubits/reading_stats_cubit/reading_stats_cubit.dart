import 'dart:async';

import 'package:core_books/core_books.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:reading_stats/src/domain/models/reading_stats.dart';
import 'package:reading_stats/src/domain/navigation/i_reading_stats_navigation.dart';
import 'package:reading_stats/src/domain/services/reading_stats_calculator.dart';

part 'reading_stats_state.dart';

@injectable
class ReadingStatsCubit extends Cubit<ReadingStatsState> {
  new(this._library, this._goals, this._calculator, this._navigation)
    : super(const ReadingStatsLoading());

  final ILibraryService _library;
  final IReadingGoalService _goals;
  final ReadingStatsCalculator _calculator;
  final IReadingStatsNavigation _navigation;

  final _subscriptions = <StreamSubscription<Object>>[];
  List<ShelfEntry>? _entries;
  int? _goal;

  void watch() {
    _subscriptions.addAll([
      _library.watchShelf().listen((entries) {
        _entries = entries;
        _recalculate();
      }),
      _goals.watchYearlyGoal().listen((goal) {
        _goal = goal;
        _recalculate();
      }),
    ]);
  }

  void openDiscover() => _navigation.openDiscover();

  void _recalculate() {
    if ((_entries, _goal) case (final entries?, final goal?)) {
      final stats = _calculator.calculate(
        entries,
        goal: goal,
        year: DateTime.now().year,
      );
      emit(ReadingStatsLoaded(stats));
    }
  }

  @override
  Future<void> close() async {
    await Future.wait(_subscriptions.map((sub) => sub.cancel()));
    await super.close();
  }
}
