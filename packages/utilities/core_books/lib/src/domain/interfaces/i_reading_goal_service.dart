abstract interface class IReadingGoalService {
  Stream<int> watchYearlyGoal();

  Future<int> yearlyGoal();

  Future<void> setYearlyGoal(int goal);
}
