import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';

class AppStateNotifier extends BaseProvider {

  double _fontSize =0.8;

  double get fontSize => _fontSize;

  set fontSize(double value) {
    _fontSize = value;
    notifyListeners();
  }

  bool isDarkModeOn = SharedPreference.prefs?.getBool(SharedPreference.THEME_STATUS) ?? false;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    SharedPreference.prefs!.setBool(SharedPreference.THEME_STATUS, this.isDarkModeOn);
    notifyListeners();
  }
}