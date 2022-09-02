import 'package:beehive/model/project_days_list_model.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class ProjectSettingsManagerProvider extends BaseProvider{

  bool value = false;
  updateValue(bool getValue){
    value = getValue;
    notifyListeners();
  }

  List<int> breakWidget = [];
  List<String> daysName = ["SU","M","TU","W","TH","F","SA"];
  List<DaysModel> weekDays = [];
  removeImageFromList(int index) {
    breakWidget.removeAt(index);
    notifyListeners();
  }

  addIndexToList(){
    breakWidget.add(1);
    notifyListeners();
  }
  String breakTime0 = "";
  String onTime0 = "";
  String breakTime1 = "";
  String onTime2 = "";




  updateColor(int index){
    weekDays[index].selected = !weekDays[index].selected;
    notifyListeners();
  }

  String? dropDownValue;
  String? dropDownValueFromTime;
  String? dropDownValueToTime;
  String? dropDownValueFromTimeBreakTime;
  String? dropDownValueFromTimeBreakOnTime;
  List<String> vehicles = [
    "1.5X",
    "2X",
    "2.5X",
    "3X",
    "3.5X",
    "4X"

  ];
  List<String> fromTimeListPM = [
    "12 PM",
    "12:30 PM",
    "1 PM",
    "1:30 PM",
    "2 PM",
    "2:30 PM",
    "3 PM",
    "3:30 PM",
    "4 PM",
    "4:30 PM",
    "5 PM",
    "5:30 PM",
    "6 PM",
    "6:30 PM",
    "7 PM",
    "7:30 PM",
    "8 PM",
    "8:30 PM",
    "9 PM",
    "9:30 PM",
    "10 PM",
    "10:30 PM",
    "11 PM",
    "11:30 PM",
  ];
  List<String> fromTimeListBreakTime = [
    "15 Min",
    "30 Min",
    "45 Hour",
    "1 Hour",

  ];
  List<String> fromTimeListAM = [
    "12 AM",
    "12:30 AM",
    "1 AM",
    "1:30 AM",
    "2 AM",
    "2:30 AM",
    "3 PM",
    "3:30 AM",
    "4 AM",
    "4:30 AM",
    "5 AM",
    "5:30 AM",
    "6 AM",
    "6:30 AM",
    "7 AM",
    "7:30 AM",
    "8 AM",
    "8:30 AM",
    "9 AM",
    "9:30 AM",
    "10 AM",
    "10:30 AM",
    "11 AM",
    "11:30 AM",
  ];
  List<String> fromTimeListAMOnTime = [
    "Any Time",
    "12 AM",
    "12:30 AM",
    "1 AM",
    "1:30 AM",
    "2 AM",
    "2:30 AM",
    "3 PM",
    "3:30 AM",
    "4 AM",
    "4:30 AM",
    "5 AM",
    "5:30 AM",
    "6 AM",
    "6:30 AM",
    "7 AM",
    "7:30 AM",
    "8 AM",
    "8:30 AM",
    "9 AM",
    "9:30 AM",
    "10 AM",
    "10:30 AM",
    "11 AM",
    "11:30 AM",
  ];
  onSelected(value) {
    dropDownValue = value;
    notifyListeners();
  }
  onSelectedFromValue(value) {
    dropDownValueFromTime = value;
    notifyListeners();
  }
  onSelectedToValue(value) {
    dropDownValueToTime = value;
    notifyListeners();
  }
  onSelectedFromValueBreakTime(value) {
    dropDownValueFromTimeBreakTime = value;
    notifyListeners();
  }
  onSelectedFromValueBreakOnTime(value) {
    dropDownValueFromTimeBreakOnTime = value;
    notifyListeners();
  }




  addModelToList(){
    for(int i = 0; i < daysName.length;i++){
      DaysModel daysModel = DaysModel();
      daysModel.day = daysName[i];
      daysModel.selected = false;
      weekDays.add(daysModel);
      notifyListeners();
    }
  }
  bool status = false;
  void updateSwitcherStatus(bool value) {
    status = value;
    notifyListeners();
  }



}