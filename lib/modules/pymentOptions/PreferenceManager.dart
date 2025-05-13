

// import '../models/LoginModel.dart';
// import '../screens/login/LoginScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  PreferenceManager._privateConstructor();

  static final PreferenceManager instance = PreferenceManager._privateConstructor();

  Future<bool> setString(String key, String value) async {
    print("$key--$value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future<bool> result = prefs.setString(key, value);

    return result;
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }





  // Future<LoginModel> getUserDetails() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   String? loginString = await prefs.getString(ConstantString.loginKey);
  //   print(loginString);
  //   if (loginString == null) {
  //     return LoginModel.fromJson({});
  //   } else {
  //     return LoginModel.fromJson(jsonDecode(loginString ?? ""));
  //   }
  // }
  //
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
