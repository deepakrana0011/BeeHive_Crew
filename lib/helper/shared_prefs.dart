
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const THEME_STATUS = "THEMESTATUS";
  static const TOKEN = "token";
  static const USER_ID = "user_id";

 static SharedPreferences? prefs;

  static clearSharedPrefs() async {
    prefs!.remove(TOKEN);
    prefs!.remove(USER_ID);

  }




}
