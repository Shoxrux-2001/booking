import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isOnboardedKey = 'isOnboarded';

  static Future<void> markOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isOnboardedKey, true);
  }

  static Future<bool> isOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isOnboardedKey) ?? false;
  }
}