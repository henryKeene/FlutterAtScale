import 'package:core_books/src/data/dtos/open_library_json.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_network/core_network.dart';

class SearchDocDto {
  const new({
    required this.key,
    required this.title,
    required this.authorNames,
    required this.subjects,
    this.coverId,
    this.firstPublishYear,
  });

  factory fromJson(Json json) => SearchDocDto(
    key: json['key'] as String,
    title: json['title'] as String? ?? 'Untitled',
    authorNames: stringList(json['author_name']),
    subjects: stringList(json['subject']),
    coverId: json['cover_i'] as int?,
    firstPublishYear: json['first_publish_year'] as int?,
  );

  final String key;
  final String title;
  final List<String> authorNames;
  final List<String> subjects;
  final int? coverId;
  final int? firstPublishYear;

  Book toBook() => Book(
    workId: workIdFromKey(key),
    title: title,
    authors: authorNames,
    coverId: coverId,
    firstPublishYear: firstPublishYear,
    subjects: readableSubjects(subjects),
  );
}
