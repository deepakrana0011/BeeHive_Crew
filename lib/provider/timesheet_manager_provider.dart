import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/material.dart';

class TimeSheetManagerProvider extends BaseProvider{

  int selectIndex = 0;
  indexCheck(int value){
    selectIndex=value;
    notifyListeners();
  }
  TabController? controller;
  bool loading = false;

  updateLoadingStatus(bool val){
    loading = val;
    notifyListeners();
  }

}