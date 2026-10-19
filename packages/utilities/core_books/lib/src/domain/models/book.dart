import 'package:equatable/equatable.dart';

enum CoverSize {
  small('S'),
  medium('M'),
  large('L');

  new(this.code);

  final String code;
}

class Book extends Equatable {
  const new({
    required this.workId,
    required this.title,
    this.authors = const [],
    this.coverId,
    this.firstPublishYear,
    this.description,
    this.subjects = const [],
  });

  factory fromJson(Map<String, dynamic> json) => Book(
    workId: json['workId'] as String,
    title: json['title'] as String,
    authors: (json['authors'] as List<dynamic>).cast<String>(),
    coverId: json['coverId'] as int?,
    firstPublishYear: json['firstPublishYear'] as int?,
    description: json['description'] as String?,
    subjects: (json['subjects'] as List<dynamic>).cast<String>(),
  );

  final String workId;
  final String title;
  final List<String> authors;
  final int? coverId;
  final int? firstPublishYear;
  final String? description;
  final List<String> subjects;

  Uri? coverUrl(CoverSize size) => coverId == null
      ? null
      : Uri.https('covers.openlibrary.org', '/b/id/$coverId-${size.code}.jpg');

  Map<String, dynamic> toJson() => {
    'workId': workId,
    'title': title,
    'authors': authors,
    'coverId': coverId,
    'firstPublishYear': firstPublishYear,
    'description': description,
    'subjects': subjects,
  };

  @override
  List<Object?> get props => [
    workId,
    title,
    authors,
    coverId,
    firstPublishYear,
    description,
    subjects,
  ];
}
