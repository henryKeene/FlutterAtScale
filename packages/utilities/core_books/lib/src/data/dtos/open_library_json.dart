List<String> stringList(Object? value) =>
    value is List ? value.whereType<String>().toList() : const [];

String workIdFromKey(String key) => key.split('/').last;

List<String> readableSubjects(List<String> subjects) => subjects
    .where((subject) => !subject.contains(':') && subject.length < 32)
    .take(8)
    .toList();
