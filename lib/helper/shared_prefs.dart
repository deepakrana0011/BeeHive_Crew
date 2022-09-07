
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const THEME_STATUS = "THEMESTATUS";
  static const TOKEN = "token";
  static const USER_ID = "user_id";
  static const INTRODUCTION_COMPLETE = "introductionComplete";
  static const ISMANAGER_LOGIN = "isManagerLogin";
  static const ISCREW_LOGIN = "isCrewLogin";
  static const IS_LOGIN = "isLogin";
  static const IS_CHECK_IN = "1";
  static const CHECKED_PROJECT = "something";

 static SharedPreferences? prefs;

  static clearSharedPrefs() async {
    prefs!.remove(TOKEN);
    prefs!.remove(USER_ID);
    prefs!.remove(ISMANAGER_LOGIN);
    prefs!.remove(IS_LOGIN);
    prefs!.remove(ISCREW_LOGIN);
  }
  static clearCheckIn(){
    prefs!.remove(IS_CHECK_IN);
    prefs!.remove(CHECKED_PROJECT);

  }




}
