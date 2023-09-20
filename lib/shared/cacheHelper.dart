import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  //بدل ما استدعيها كذا مره لا انا هحطها ف المين
  // هنا هحقق السنجلتون  عشان هو كود واحد هستخدمه ف كل الابلكيشن مره واحده

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool> getBoolean({
    required String key,
    required bool value,
  }) async {
    return sharedPreferences.getBool(key) ?? false;
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<dynamic> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);
    if (value is bool) return sharedPreferences.setBool(key, value);
    return sharedPreferences.setDouble(key, value);
  }

  static Future<dynamic> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
