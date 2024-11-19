import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesService {
  // Methods in Shared prefrence ===>  set-get-delete-clear
  static late SharedPreferences sharedpef;
  static Future<void> intialShared() async {
    sharedpef = await SharedPreferences.getInstance();
  }

  Future<bool> setToCache({required String key, required String value}) async {
    bool flag = await sharedpef.setString(key, value);
    return flag;
  }

  dynamic getFromCache({required String key}) {
    return sharedpef.getString(key) ?? "";
  }

  Future<bool> deletefromCache({required String key}) async {
    return await sharedpef.remove(key);
  }

  Future<bool> clearCache() async {
    return await sharedpef.clear();
  }
}
