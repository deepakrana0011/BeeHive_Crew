import 'dart:io';

import 'package:beehive/model/project_days_list_model.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../views_manager/projects_manager/project_details_manager.dart';

class ProjectSettingsManagerProvider extends BaseProvider{

  bool value = false;
  updateValue(bool getValue){
    value = getValue;
    notifyListeners();
  }

  List<int> breakWidget = [];
  List<String> daysName = ["SU","M","TU","W","TH","F","SA"];
  List<DaysModel> weekDays = [];
  List<String> selectedDays = [];
  removeImageFromList(int index) {
    breakWidget.removeAt(index);
    notifyListeners();
  }


  addIndexToList(){
    breakWidget.add(1);
    notifyListeners();
  }


  updateColor(int index){
    weekDays[index].selected = !weekDays[index].selected;
    if( weekDays[index].selected == true){
      selectedDays.add(weekDays[index].day!);
    }else{
      selectedDays.remove(weekDays[index].day!);
    }
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

  String shiftStartingTime = "";
  List<String> fromTimeListPM = ["12 AM", "12:30 AM", "1 AM", "1:30 AM", "2 AM", "2:30 AM", "3 PM", "3:30 AM", "4 AM", "4:30 AM", "5 AM", "5:30 AM", "6 AM", "6:30 AM", "7 AM", "7:30 AM", "8 AM", "8:30 AM", "9 AM", "9:30 AM", "10 AM", "10:30 AM", "11 AM", "11:30 AM", "12 PM", "12:30 PM", "1 PM", "1:30 PM", "2 PM", "2:30 PM", "3 PM", "3:30 PM", "4 PM", "4:30 PM", "5 PM", "5:30 PM", "6 PM", "6:30 PM", "7 PM", "7:30 PM", "8 PM", "8:30 PM", "9 PM", "9:30 PM", "10 PM", "10:30 PM", "11 PM", "11:30 PM",
  ];
  List<String> fromTimeListBreakTime = [
    "15 Min",
    "30 Min",
    "45 Hour",
    "1 Hour",
  ];
  List<String> fromTimeListAM = [
    "12 AM", "12:30 AM", "1 AM", "1:30 AM", "2 AM", "2:30 AM", "3 PM", "3:30 AM", "4 AM", "4:30 AM", "5 AM", "5:30 AM", "6 AM", "6:30 AM", "7 AM", "7:30 AM", "8 AM", "8:30 AM", "9 AM", "9:30 AM", "10 AM", "10:30 AM", "11 AM", "11:30 AM", "12 PM", "12:30 PM", "1 PM", "1:30 PM", "2 PM", "2:30 PM", "3 PM", "3:30 PM", "4 PM", "4:30 PM", "5 PM", "5:30 PM", "6 PM", "6:30 PM", "7 PM", "7:30 PM", "8 PM", "8:30 PM", "9 PM", "9:30 PM", "10 PM", "10:30 PM", "11 PM", "11:30 PM",

  ];
  List<String> fromTimeListAMOnTime = ["Any Time", "12 AM", "12:30 AM", "1 AM", "1:30 AM", "2 AM", "2:30 AM", "3 PM", "3:30 AM", "4 AM", "4:30 AM", "5 AM", "5:30 AM", "6 AM", "6:30 AM", "7 AM", "7:30 AM", "8 AM", "8:30 AM", "9 AM", "9:30 AM", "10 AM", "10:30 AM", "11 AM", "11:30 AM",
  ];
  /// After hours rate dropDown value
  onSelected(value) {
    dropDownValue = value;
    notifyListeners();
  }
  ///Hours dropDown To
  onSelectedFromValue(value) {
    dropDownValueFromTime = value;
    notifyListeners();
  }
  ///Hours dropDown From
  onSelectedToValue(value) {
    dropDownValueToTime = value;
    notifyListeners();
  }
  ///Duration of break time dropDown value
  onSelectedFromValueBreakTime(value) {
    dropDownValueFromTimeBreakTime = value;
    notifyListeners();
  }
  /// On which time ypu want to take a break
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

  String breakWidgetBreakTime ="";
  String breakWidgetBreakTimeToTime ="";


  int selectedIndex = -1;
   List<String> roundTimeSheet= [
    "5 Mins",
     "10 Mins",
     "15 Mins",
     "30 Mins",
     "Hour",
     "Exact",
   ];
  bool loading = false;

  updateLoadingStatus(bool val){
    loading = val;
    notifyListeners();
  }
  String startingHour = "";
  String endingHours = "";


  Future projectSettingsApi(BuildContext context, String projectId,) async {
    setState(ViewState.busy);
    try {
      var model = await api.projectSettingsApi(context,breakTo: breakWidgetBreakTimeToTime,  afterHourRate: dropDownValue!, projectId: projectId, breakFrom: breakWidgetBreakTime, workdays: selectedDays, roundTimeSheetValue:roundTimeSheet[selectedIndex], endingHours: endingHours, hoursStarting: startingHour );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.projectDetailsPageManager, arguments: ProjectDetailsPageManager(createProject: true, projectId: model.data!.assignProjectId!,));
        DialogHelper.showMessage(context, model.message!);
      } else {
        setState(ViewState.idle);
        DialogHelper.showMessage(context, model.message!);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }










}