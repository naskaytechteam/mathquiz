import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late final SharedPreferences _sharedPreferences;

  //Keys for SharedPrefs
  static const String _nameKey = "name";
  static const String _parentEmailKey = "email";
  static const String _classNumKey = "classNum";
  static const String _avatar = "avatar";

  UserPreferences._();

  static Future<void> initSharedPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setName(String name) async {
    await _sharedPreferences.setString(_nameKey, name);
  }

  static String? getName() {
    return _sharedPreferences.getString(_nameKey);
  }

  static void setParentEmail(String email) async {
    await _sharedPreferences.setString(_parentEmailKey, email);
  }

  static String? getParentEmail() {
    return _sharedPreferences.getString(_parentEmailKey);
  }

  static void setClass(int classNum) async {
    await _sharedPreferences.setInt(_classNumKey, classNum);
  }

  static int? getClass() {
    return _sharedPreferences.getInt(_classNumKey);
  }

  static void setAvatar(int avatarIndex) async {
    await _sharedPreferences.setInt(_avatar, avatarIndex);
  }

  static int? getAvatar() {
    return _sharedPreferences.getInt(_avatar);
  }

  static bool isNewUser() {
    //TODO for future: Guest user might also need an authToken to track history, will need to figure this out later.
    //user is guest user when he has entered his name, class, & parent's email but does not have an auth token
    //TODO implement logic
    //we should check only one of them or not
    return getName() == null &&
        getClass() == null &&
        getAvatar() == null &&
        getParentEmail() == null;
  }
}
