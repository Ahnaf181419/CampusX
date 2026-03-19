import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isFirstLaunchKey = 'is_first_launch';
  static const String _userTypeKey = 'user_type';

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstLaunchKey) ?? true;
  }

  Future<void> setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstLaunchKey, false);
  }

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  Future<void> setUserType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, type);
  }
}
