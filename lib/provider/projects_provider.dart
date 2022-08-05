import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/material.dart';

class ProjectsProvider extends BaseProvider{


  int selectIndex = 0;
  indexCheck(int value){
    selectIndex=value;
    notifyListeners();
  }

  List<int> dates = [
    13,14,15,16,17,18,19

  ];
  List<int> dates2 = [
    20,21,22,23,24,25,26

  ];
  List<String> days = [
   "M","Tu","W","Th","F","Sa","Su"
  ];
  List<String> days2 = [
    "MS","MS",
  ];
  List<String> days3 = [
    "MS",
  ];
  List<String> name = [
    "AL","AL","KH","AL","MS","KH",
  ];
  List<Color> colors = [
   ColorConstants.schedule1,
    ColorConstants.schedule2,
    ColorConstants.schedule3,
    ColorConstants.schedule4,
    ColorConstants.schedule5,
    ColorConstants.schedule6,
  ];
  List<Color> colors2 = [

    ColorConstants.schedule5,
    ColorConstants.schedule5,

  ];
  List<Color> colors3 = [

    ColorConstants.green6FCF97,

  ];






}