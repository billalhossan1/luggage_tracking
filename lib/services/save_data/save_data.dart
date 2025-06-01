import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDataController extends GetxController {
  final String _accessTokenKey = 'accessToken';
  final String _rememberMeKey = 'rememberMe';
  final String _seenOnboardingKey = 'seenOnboarding';

  String? tempToken;
  bool? rememberMe;

  Future<void> saveUserData(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setBool(_rememberMeKey, true);
    tempToken = token;
    rememberMe = true;
  }

  void saveTempData(String token) {
    tempToken = token;
    rememberMe = false;
  }

  Future<String?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    rememberMe = sharedPreferences.getBool(_rememberMeKey) ?? false;

    if (rememberMe == true) {
      tempToken = sharedPreferences.getString(_accessTokenKey);
    }

    return tempToken;
  }

  bool isLoggedIn() {
    return tempToken != null;
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    tempToken = null;
    rememberMe = null;
  }

  Future<void> saveOnboardingStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenOnboardingKey, status);
  }

  Future<bool> getOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenOnboardingKey) ?? false;
  }
}

