import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static saveString(String key, value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setString(key, value);
  }

  static saveInt(String key, int value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setInt(key, value);
  }

  static saveBool(String key, bool value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setBool(key, value);
  }

  static saveDouble(String key, double value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setDouble(key, value);
  }

  static saveList(String key, List<String> value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setStringList(key, value);
  }

  static remove(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.remove(key);
  }

  static clear() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.clear();
  }
}
