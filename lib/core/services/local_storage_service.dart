import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageKeys {
  static const String user = 'user';
  static const String themeMode = 'theme_mode';
  static const String sideBarState = 'sideBarState';
}

class LocalStorageService {
  /// Stores a [value] with the given [key]
  static Future<void> setItem(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Retrieves the value associated with the [key]
  static Future<String?> getItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Removes the value associated with the [key]
  static Future<void> removeItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Clears all keys in shared preferences
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Checks if the [key] exists in storage
  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  /// Returns all keys in the storage
  static Future<Set<String>> getKeys() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }
}
