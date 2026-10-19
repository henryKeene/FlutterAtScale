abstract interface class IKeyValueStore {
  Future<String?> readString(String key);

  Future<void> writeString(String key, String value);

  Future<int?> readInt(String key);

  Future<void> writeInt(String key, int value);

  Future<void> delete(String key);
}
