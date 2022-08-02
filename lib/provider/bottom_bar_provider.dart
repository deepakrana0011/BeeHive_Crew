import 'package:beehive/provider/base_provider.dart';

class BottomBarProvider extends BaseProvider{
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}