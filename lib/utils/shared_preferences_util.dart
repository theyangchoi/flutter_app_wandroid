import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * 保存缓存信息
 */
class SharedPreferencesUtil{


  /**
   * 保存数据是 key,value的形式
   * 这里定义的是key
   */
  //用户信息
  static String get userInfo => 'userInfo';


  static Future setData({@required type, @required key, @required value}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    switch (type) {
      case String:
        sp.setString(key, value);
        break;
      case bool:
        sp.setBool(key, value);
        break;
      case double:
        sp.setDouble(key, value);
        break;
      case int:
        sp.setInt(key, value);
        break;
      case List:
        sp.setStringList(key, value);
        break;
      default:
        break;
    }
  }

  static Future get({@required type, @required key, defaultValue}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    switch (type) {
      case String:
        return sp.getString(key) ?? defaultValue;
        break;
      case bool:
        return sp.getBool(key) ?? defaultValue;
        break;
      case double:
        return sp.getDouble(key) ?? defaultValue;
        break;
      case int:
        return sp.getInt(key) ?? defaultValue;
        break;
      case List:
        return sp.getStringList(key) ?? defaultValue;
        break;
      default:
        break;
    }
  }

  static Future remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!sp.containsKey(key)) return;
    sp.remove(key);
  }

  static Future<bool> containsKey(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.containsKey(key);
  }
}