import 'package:core_storage/src/domain/interfaces/i_key_value_store.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IKeyValueStore)
class SharedPreferencesStore implements IKeyValueStore {
  new(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> readString(String key) => _preferences.getString(key);

  @override
  Future<void> writeString(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future<int?> readInt(String key) => _preferences.getInt(key);

  @override
  Future<void> writeInt(String key, int value) =>
      _preferences.setInt(key, value);

  @override
  Future<void> delete(String key) => _preferences.remove(key);
}
