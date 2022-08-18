import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/material.dart';

class TimeSheetFromCrewProvider extends BaseProvider{

  int selectIndex = 0;
  indexCheck(int value){
    selectIndex=value;
    notifyListeners();
  }
  void doNothing(BuildContext context) {}

  TabController? controller;







}