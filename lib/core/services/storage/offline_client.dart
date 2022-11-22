abstract class OfflineClient {
  Future<bool> setString(String key, String value);
  Future<String?> getString(String key);
  Future<bool> clearData(String key);
}
