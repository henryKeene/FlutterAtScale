import 'package:equatable/equatable.dart';

class ReadingStats extends Equatable {
  const new({
    required this.year,
    required this.goal,
    required this.totalBooks,
    required this.readThisYear,
    required this.reading,
    required this.wantToRead,
    required this.monthlyReads,
    this.averageRating,
  });

  final int year;
  final int goal;
  final int totalBooks;
  final int readThisYear;
  final int reading;
  final int wantToRead;
  final List<int> monthlyReads;
  final double? averageRating;

  double get goalProgress => goal == 0 ? 0 : (readThisYear / goal).clamp(0, 1);

  int get booksToGo => (goal - readThisYear).clamp(0, goal);

  @override
  List<Object?> get props => [
    year,
    goal,
    totalBooks,
    readThisYear,
    reading,
    wantToRead,
    monthlyReads,
    averageRating,
  ];
}
