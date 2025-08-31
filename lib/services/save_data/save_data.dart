import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SaveDataController extends GetxController {
  final String _accessTokenKey = 'accessToken';
  final String _rememberMeKey = 'rememberMe';
  final String _seenOnboardingKey = 'seenOnboarding';
  final String _isSubscribeKey = 'isSubscribe';
  final String _fcmTokenKey = 'fcm';
  final String _userEmailKey = 'email';
  final String _userNameKey = 'name';

  String? tempToken;
  bool? rememberMe;
  Future<void>setString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }
  Future<String?> getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
  Future<void> saveFcmToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_fcmTokenKey, token);
  }

  Future<String?> getFcmToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_fcmTokenKey);
  }

  Future<void> saveUserData(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setBool(_rememberMeKey, true);
    tempToken = token;
    rememberMe = true;
  }
  Future<void>isSubscribe(bool isSubscribe)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(_isSubscribeKey, isSubscribe);

  }
  Future<bool>getIsSubscribe()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_isSubscribeKey) ?? false;

  }

  void saveTempData(String token) {
    tempToken = token;
    rememberMe = false;
  }

  Future<String?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    rememberMe = sharedPreferences.getBool(_rememberMeKey) ?? false;

    // if (rememberMe == true) {
      tempToken = sharedPreferences.getString(_accessTokenKey);
    // }

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
  Future<void>setUserEmail( String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userEmailKey, value);
  }
  Future<void>setUserName( String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userNameKey, value);
  }

  Future<String?> getUserEmail()  async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String email =sharedPreferences.getString(_userEmailKey) ?? "";

    return email;
  }
  Future<String?> getUserName()  async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String name =sharedPreferences.getString(_userNameKey) ?? "";

    return name;
  }
}

