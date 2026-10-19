import 'package:core_books/src/data/dtos/open_library_json.dart';
import 'package:core_books/src/domain/models/book.dart';
import 'package:core_network/core_network.dart';

class WorkDto {
  const new({
    required this.key,
    required this.title,
    required this.authorKeys,
    required this.subjects,
    this.description,
    this.coverId,
    this.firstPublishYear,
  });

  factory fromJson(Json json) => WorkDto(
    key: json['key'] as String,
    title: json['title'] as String? ?? 'Untitled',
    authorKeys: [
      for (final author in json['authors'] as List<dynamic>? ?? const [])
        if (author case {'author': {'key': final String key}}) key,
    ],
    subjects: stringList(json['subjects']),
    description: switch (json['description']) {
      final String text => text,
      {'value': final String text} => text,
      _ => null,
    },
    coverId: (json['covers'] as List<dynamic>?)
        ?.whereType<int>()
        .where((id) => id > 0)
        .firstOrNull,
    firstPublishYear: switch (json['first_publish_date']) {
      final String date => int.tryParse(
        RegExp(r'\d{4}').firstMatch(date)?.group(0) ?? '',
      ),
      _ => null,
    },
  );

  final String key;
  final String title;
  final List<String> authorKeys;
  final List<String> subjects;
  final String? description;
  final int? coverId;
  final int? firstPublishYear;

  Book toBook({required List<String> authors}) => Book(
    workId: workIdFromKey(key),
    title: title,
    authors: authors,
    coverId: coverId,
    firstPublishYear: firstPublishYear,
    description: description?.replaceAll('\r\n', '\n').trim(),
    subjects: readableSubjects(subjects),
  );
}
