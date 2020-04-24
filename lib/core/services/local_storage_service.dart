import 'package:localstorage/localstorage.dart';

class LocalStorageService {
  static LocalStorage storage;

  static Future<void> init() {
    storage = new LocalStorage('app');
  }

  static dynamic getItem(key) => storage.getItem(key);

  static void setItem(key, value) => storage.setItem(key, value);

  static void clearStorage() => storage.clear();
}