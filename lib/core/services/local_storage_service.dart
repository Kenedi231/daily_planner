import 'package:app_list/core/base/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends BaseService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  dynamic getItem(String key) {
    var value = _preferences.get(key);
    log.i('Get item $key: $value');
    return value;
  }

  void setItem<T>(String key, T content){
    log.i('Set item $key: $content');
  if(content is String) {
    _preferences.setString(key, content);
  }
  if(content is bool) {
    _preferences.setBool(key, content);
  }
  if(content is int) {
    _preferences.setInt(key, content);
  }
  if(content is double) {
    _preferences.setDouble(key, content);
  }
  if(content is List<String>) {
    _preferences.setStringList(key, content);
  }
}
  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  void removeItem(String key) {
    log.i('Remove item $key');
    _preferences.remove(key);
  }
}