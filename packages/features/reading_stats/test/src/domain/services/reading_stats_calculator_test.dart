import 'package:core_books/core_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reading_stats/src/domain/services/reading_stats_calculator.dart';

ShelfEntry _entry(
  String id,
  ReadingStatus status, {
  DateTime? updatedAt,
  int? rating,
}) => ShelfEntry(
  book: Book(workId: id, title: id),
  status: status,
  updatedAt: updatedAt ?? DateTime(2026, 3),
  rating: rating,
);

void main() {
  final calculator = ReadingStatsCalculator();

  group('ReadingStatsCalculator', () {
    test('counts books finished this year towards the goal', () {
      final stats = calculator.calculate(
        [
          _entry('a', ReadingStatus.read, updatedAt: DateTime(2026, 1, 5)),
          _entry('b', ReadingStatus.read, updatedAt: DateTime(2026, 1, 20)),
          _entry('c', ReadingStatus.read, updatedAt: DateTime(2025, 12, 31)),
          _entry('d', ReadingStatus.reading),
        ],
        goal: 4,
        year: 2026,
      );

      expect(stats.readThisYear, 2);
      expect(stats.goalProgress, 0.5);
      expect(stats.booksToGo, 2);
      expect(stats.monthlyReads.first, 2);
      expect(stats.monthlyReads.skip(1), everyElement(0));
    });

    test('counts each shelf', () {
      final stats = calculator.calculate(
        [
          _entry('a', ReadingStatus.reading),
          _entry('b', ReadingStatus.wantToRead),
          _entry('c', ReadingStatus.wantToRead),
        ],
        goal: 12,
        year: 2026,
      );

      expect(stats.totalBooks, 3);
      expect(stats.reading, 1);
      expect(stats.wantToRead, 2);
    });

    test('averages ratings and leaves it empty when there are none', () {
      final rated = calculator.calculate(
        [
          _entry('a', ReadingStatus.read, rating: 5),
          _entry('b', ReadingStatus.read, rating: 2),
        ],
        goal: 12,
        year: 2026,
      );
      final unrated = calculator.calculate(const [], goal: 12, year: 2026);

      expect(rated.averageRating, 3.5);
      expect(unrated.averageRating, isNull);
    });

    test('caps progress at the goal', () {
      final stats = calculator.calculate(
        [for (var i = 0; i < 5; i++) _entry('$i', ReadingStatus.read)],
        goal: 3,
        year: 2026,
      );

      expect(stats.goalProgress, 1);
      expect(stats.booksToGo, 0);
    });
  });
}
