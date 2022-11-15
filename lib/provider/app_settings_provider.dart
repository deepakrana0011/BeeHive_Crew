import 'package:beehive/provider/base_provider.dart';

class AppSettingsProvider extends BaseProvider {
  String? units;
  List<String> unitsList = ["Metric", "Metric (km)", "Metric (ml)"];

  String? time;
  List<String> timesList = ["AM", "PM"];

  String? language;
  List<String> languagesList = ["English", "Japanese"];

  List<String> fontSizeList = ["14 pt", "15 pt", "16 pt"];
  int selectedIndex = -1;

  void onSelectedUnits(value) {
    units = value;
    notifyListeners();
  }

  void onSelectedTime(value) {
    time = value;
    notifyListeners();
  }

  void onSelectedLanguage(value) {
    language = value;
    notifyListeners();
  }
}
