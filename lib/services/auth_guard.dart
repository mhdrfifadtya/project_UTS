import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }
}
