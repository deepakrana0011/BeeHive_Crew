import 'package:beehive/provider/base_provider.dart';

class SetRatesPageManageProvider extends BaseProvider{


  bool status = false;
  void updateSwitcherStatus(bool value) {
    status = value;
    notifyListeners();
  }








}