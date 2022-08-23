
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const THEME_STATUS = "THEMESTATUS";
  static const TOKEN = "token";
  static const USER_ID = "user_id";
  static const INTRODUCTION_COMPLETE = "introductionComplete";
  static const ISMANAGER_LOGIN = "isManagerLogin";
  static const IS_LOGIN = "isLogin";

 static SharedPreferences? prefs;

  static clearSharedPrefs() async {
    prefs!.remove(TOKEN);
    prefs!.remove(USER_ID);
    prefs!.remove(ISMANAGER_LOGIN);
    prefs!.remove(IS_LOGIN);
  }




}
