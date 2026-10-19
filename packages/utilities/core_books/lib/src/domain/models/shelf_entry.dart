import 'package:core_books/src/domain/models/book.dart';
import 'package:core_books/src/domain/models/reading_status.dart';
import 'package:equatable/equatable.dart';

class ShelfEntry extends Equatable {
  const new({
    required this.book,
    required this.status,
    required this.updatedAt,
    this.rating,
    this.review,
  });

  factory fromJson(Map<String, dynamic> json) => ShelfEntry(
    book: Book.fromJson(json['book'] as Map<String, dynamic>),
    status: ReadingStatus.values.byName(json['status'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    rating: json['rating'] as int?,
    review: json['review'] as String?,
  );

  final Book book;
  final ReadingStatus status;
  final DateTime updatedAt;
  final int? rating;
  final String? review;

  Map<String, dynamic> toJson() => {
    'book': book.toJson(),
    'status': status.name,
    'updatedAt': updatedAt.toIso8601String(),
    'rating': rating,
    'review': review,
  };

  @override
  List<Object?> get props => [book, status, updatedAt, rating, review];
}
