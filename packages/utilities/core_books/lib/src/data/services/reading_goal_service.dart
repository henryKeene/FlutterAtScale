import 'dart:async';

import 'package:core_books/src/domain/interfaces/i_reading_goal_service.dart';
import 'package:core_storage/core_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IReadingGoalService)
class ReadingGoalService implements IReadingGoalService {
  new(this._store);

  static const _key = 'reading_goal';
  static const _defaultGoal = 12;

  final IKeyValueStore _store;
  final _changes = StreamController<int>.broadcast();

  @override
  Stream<int> watchYearlyGoal() async* {
    yield await yearlyGoal();
    yield* _changes.stream;
  }

  @override
  Future<int> yearlyGoal() async => await _store.readInt(_key) ?? _defaultGoal;

  @override
  Future<void> setYearlyGoal(int goal) async {
    await _store.writeInt(_key, goal);
    _changes.add(goal);
  }
}
