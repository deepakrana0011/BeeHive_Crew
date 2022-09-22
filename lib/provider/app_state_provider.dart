import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';

class AppStateNotifier extends BaseProvider {
  bool isDarkModeOn = SharedPreference.prefs?.getBool(SharedPreference.THEME_STATUS) ?? false;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    SharedPreference.prefs!.setBool(SharedPreference.THEME_STATUS, this.isDarkModeOn);
    notifyListeners();
  }
}