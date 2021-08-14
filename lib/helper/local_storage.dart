import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences sharedprefs;

  static init() async {
    sharedprefs = await SharedPreferences.getInstance();
  }

  static dynamic getData({@required String key}) {
    return sharedprefs.get(key);
  }

  static Future<bool> saveData(
      {@required String key, @required dynamic value}) async {
    if (value is String) return await sharedprefs.setString(key, value);
    if (value is int) return await sharedprefs.setInt(key, value);
    if (value is bool) return await sharedprefs.setBool(key, value);

    return await sharedprefs.setDouble(key, value);
  }

  static Future<bool> removeData({@required String key}) async {
    return await sharedprefs.remove(key);
  }
}
