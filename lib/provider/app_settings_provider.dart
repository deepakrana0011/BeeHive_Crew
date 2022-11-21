import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';


class AppSettingsProvider extends BaseProvider {


  int _selectedFontIndex = 0;

  int get selectedFontIndex => _selectedFontIndex;

  set selectedFontIndex(int value) {
    _selectedFontIndex = value;
    notifyListeners();
  }

  String units = "Metric (m)";
  List<String> unitsList = ["Metric (m)", "Metric (km)", "Metric (mi)"];

  String currency = "USD";
  List<String> currencyList = ["USD"];

  String time = "AM/PM";
  List<String> timesList = ["AM/PM", "24 Hours"];

  String language = "English";
  List<String> languagesList = ["English"];

  List<String> fontSizeList = ["14 pt", "15 pt", "16 pt"];

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

  void onSelectedCurrency(value) {
    currency = value;
    notifyListeners();
  }

  Future<void> saveData() async {


    int selectedUnits = unitsList.indexOf(units);
    int selectedTime = timesList.indexOf(time);
    int selectedLanguage = languagesList.indexOf(language);
    int selectedCurrency = currencyList.indexOf(currency);



    SharedPreference.prefs?.setInt(SharedPreference.units, selectedUnits);
    SharedPreference.prefs?.setInt(SharedPreference.time, selectedTime);
    SharedPreference.prefs?.setInt(SharedPreference.language, selectedLanguage);
    SharedPreference.prefs?.setInt(SharedPreference.currency, selectedCurrency);

  }

  void getData() {

    selectedFontIndex =
        SharedPreference.prefs?.getInt(SharedPreference.fontSize) ?? 0;
    units =
        unitsList[SharedPreference.prefs?.getInt(SharedPreference.units) ?? 0];
    time =
        timesList[SharedPreference.prefs?.getInt(SharedPreference.time) ?? 0];
    language = languagesList[
        SharedPreference.prefs?.getInt(SharedPreference.language) ?? 0];
    currency = currencyList[
        SharedPreference.prefs?.getInt(SharedPreference.currency) ?? 0];
  }
}
