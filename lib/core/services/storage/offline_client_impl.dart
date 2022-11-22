import 'package:d_rank/core/services/storage/offline_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: OfflineClient)
class OfflineClientImpl implements OfflineClient {
  @override
  Future<String?> getString(String key) async =>
      (await SharedPreferences.getInstance()).getString(key);

  @override
  Future<bool> setString(String key, String value) async =>
      await (await SharedPreferences.getInstance()).setString(key, value);

  @override
  Future<bool> clearData(String key) async =>
      await (await SharedPreferences.getInstance()).remove(key);
}
