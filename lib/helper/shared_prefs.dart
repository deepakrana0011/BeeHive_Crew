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
  static const COLORFORDRAWER = "colorForDrawer";
  static const USER_LOGO = "logo";
  static const USER_NAME = "name";
  static const Crew_NAME = "crewName";
  static const loginType = "loginType"; // 1 for crew 2 // manager
  static const isLogin = "isLogin"; // 1 for crew 2 // manager
  static const popUpShowTime = "popUpShowTime"; // 1 for crew 2 // manager

  static const units = "units"; // 0 for m 1 for km 2 for mi
  static const time = "time"; // 0 for AM/PM 1 for 24 Hours
  static const language = "language"; // 0 for English 1 for Japanese
  static const currency = "currency"; // 0 for USD 1 for EUR
  static const fontSize = "fontSize"; // 0 for 14pt 1 for 15pt 2 for 16pt

  static SharedPreferences? prefs;

  static clearSharedPrefs() async {
    prefs!.remove(TOKEN);
    prefs!.remove(USER_ID);
    prefs!.remove(ISMANAGER_LOGIN);
    prefs!.remove(isLogin);
    prefs!.remove(ISCREW_LOGIN);
    prefs!.remove(Crew_NAME);
  }

  static clearCheckIn() {
    prefs!.remove(IS_CHECK_IN);
    prefs!.remove(IS_CHECK_DB);
    prefs!.remove(CHECKED_PROJECT);
  }
}
