import 'package:core_books/core_books.dart';
import 'package:injectable/injectable.dart';
import 'package:reading_stats/src/domain/models/reading_stats.dart';

@injectable
class ReadingStatsCalculator {
  ReadingStats calculate(
    List<ShelfEntry> entries, {
    required int goal,
    required int year,
  }) {
    final readThisYear = entries
        .where(
          (entry) =>
              entry.status == ReadingStatus.read &&
              entry.updatedAt.year == year,
        )
        .toList();
    final ratings = entries.map((entry) => entry.rating).nonNulls.toList();

    return ReadingStats(
      year: year,
      goal: goal,
      totalBooks: entries.length,
      readThisYear: readThisYear.length,
      reading: _count(entries, ReadingStatus.reading),
      wantToRead: _count(entries, ReadingStatus.wantToRead),
      averageRating: ratings.isEmpty
          ? null
          : ratings.reduce((sum, rating) => sum + rating) / ratings.length,
      monthlyReads: [
        for (var month = 1; month <= 12; month++)
          readThisYear.where((entry) => entry.updatedAt.month == month).length,
      ],
    );
  }

  int _count(List<ShelfEntry> entries, ReadingStatus status) =>
      entries.where((entry) => entry.status == status).length;
}
