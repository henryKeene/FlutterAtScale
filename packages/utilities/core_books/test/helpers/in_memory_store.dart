import 'package:core_storage/core_storage.dart';

class InMemoryStore implements IKeyValueStore {
  final values = <String, Object>{};

  @override
  Future<String?> readString(String key) async => values[key] as String?;

  @override
  Future<void> writeString(String key, String value) async =>
      values[key] = value;

  @override
  Future<int?> readInt(String key) async => values[key] as int?;

  @override
  Future<void> writeInt(String key, int value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}
