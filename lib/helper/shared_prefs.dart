
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const THEME_STATUS = "THEMESTATUS";
  static const TOKEN = "token";
  static const USER_ID = "user_id";
  static const INTRODUCTION_COMPLETE = "introductionComplete";
  static const ISMANAGER_LOGIN = "isManagerLogin";
  static const ISCREW_LOGIN = "isCrewLogin";
  static const IS_CHECK_IN = "1";
  static const IS_CHECK_DB = "1";
  static const CHECKED_PROJECT = "something";
  static const DashBoardIcon = "DashBoardIcon";
  static const USER_PROFILE = "profile";
  static const USER_LOGO = "logo";
  static const USER_NAME = "name";
  static const Crew_NAME = "crewName";
  static const loginType = "loginType";    // 1 for crew 2 // manager
  static const isLogin = "isLogin";    // 1 for crew 2 // manager
  static const popUpShowTime = "popUpShowTime";    // 1 for crew 2 // manager

 static SharedPreferences? prefs;
  static clearSharedPrefs() async {
    prefs!.remove(TOKEN);
    prefs!.remove(USER_ID);
    prefs!.remove(ISMANAGER_LOGIN);
    prefs!.remove(isLogin);
    prefs!.remove(ISCREW_LOGIN);
    prefs!.remove(Crew_NAME);
    prefs!.remove(USER_PROFILE);
    prefs!.remove(USER_NAME);
  }
  static clearCheckIn(){
    prefs!.remove(IS_CHECK_IN);
    prefs!.remove(IS_CHECK_DB);
    prefs!.remove(CHECKED_PROJECT);
  }




}
