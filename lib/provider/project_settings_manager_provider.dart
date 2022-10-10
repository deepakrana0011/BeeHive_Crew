import 'dart:io';

import 'package:beehive/locator.dart';
import 'package:beehive/model/breakTimeModel.dart';
import 'package:beehive/model/project_days_list_model.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/projects_manager/projects_page_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../model/create_project_request.dart';
import '../services/fetch_data_expection.dart';
import '../views_manager/projects_manager/project_details_manager.dart';

class ProjectSettingsManagerProvider extends BaseProvider {
  CreateProjectRequest createProjectRequest = locator<CreateProjectRequest>();
  bool value = false;
  List<BreakTimeModel> breakWidgetList = [];
  List<String> daysName = ["SU", "M", "TU", "W", "TH", "F", "SA"];
  List<DaysModel> weekDays = [];
  DateTime? breakWidgetBreakTimeFromTime;
  String? selectedAfterHourRate;
  String? projectStartTime;
  String? projectEndTime;
  String? dropDownValueFromTimeBreakTime;
  String? dropDownValueFromTimeBreakOnTime;
  List<String> afterHoursRate = ["1.5X", "2X", "2.5X", "3X", "3.5X", "4X"];

  DateTime? startingHour;
  DateTime? endingHours;
  bool status = false;
  bool loading = false;
  int selectedRoundSheetIndex = -1;
  List<String> fromTimeListPM = [
    "12:00 AM",
    "12:30 AM",
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
  ];
  List<String> breakTimeList = [
    "Any Time",
    "12:00 AM",
    "12:30 AM",
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
  ];

  List<String> minutesBreakList = [
    "15 Mins",
    "30 Mins",
    "45 Mins",
    "60 Mins",
  ];

  List<String> roundTimeSheet = [
    "5 Mins",
    "10 Mins",
    "15 Mins",
    "30 Mins",
    "Hour",
    "Exact",
  ];

  void updateValue(bool getValue) {
    value = getValue;
    notifyListeners();
  }

  void updateDaySelection(int index) {
    weekDays[index].selected = !weekDays[index].selected;
    notifyListeners();
  }

  void onSelectedAfterHourRate(value) {
    selectedAfterHourRate = value;
    notifyListeners();
  }

  ///Hours dropDown To
  onSelectedProjectStartTime(value) {
    projectStartTime = value;
    notifyListeners();
  }

  ///Hours dropDown From
  void onSelectedProjectEndTime(value) {
    projectEndTime = value;
    notifyListeners();
  }

  void addModelToList() {
    for (int i = 0; i < daysName.length; i++) {
      DaysModel daysModel = DaysModel();
      daysModel.day = daysName[i];
      daysModel.selected = false;
      weekDays.add(daysModel);
      notifyListeners();
    }
  }

  void addBreakToList(BreakTimeModel data) {
    breakWidgetList.add(data);
    customNotify();
  }

  void updateBreakInList(int index, String breakValue, bool isInterval) {
    if (isInterval) {
      breakWidgetList[index].breakIntervalTime = breakValue;
    } else {
      breakWidgetList[index].breakStartTime = breakValue;
    }
    customNotify();
  }

  void removeBreakFromList(int index) {
    breakWidgetList.removeAt(index);
    customNotify();
  }

  void updateSwitcherStatus(bool value) {
    status = value;
    notifyListeners();
  }

  Future<void> handleButtonClick(BuildContext context) async {
    var value = weekDays.indexWhere((element) => element.selected);
    // if (value == -1) {
    //   DialogHelper.showMessage(context, "Please choose the work day");
    // } else if (projectStartTime == null || projectEndTime == null) {
    //   DialogHelper.showMessage(context, "Please choose the work hour");
    // } else if (selectedAfterHourRate == null) {
    //   DialogHelper.showMessage(context, "Please choose after hour rate");
    // } else if (selectedRoundSheetIndex == -1) {
    //   DialogHelper.showMessage(
    //       context, "Please choose round timesheet to nearest");
    // } else {
      setState(ViewState.busy);
      var list = weekDays.where((element) => element.selected);
      createProjectRequest.workDays = list.map((e) => e.day!).toList();
      createProjectRequest.hoursFrom = projectStartTime;
      createProjectRequest.hoursTo = projectEndTime;
      createProjectRequest.afterHoursRate = selectedAfterHourRate;
      List<Break> breakList = [];
      for (var element in breakWidgetList) {
        Break value = Break();
        value.startTime = element.breakStartTime;
        value.interval = element.breakIntervalTime;
        breakList.add(value);
      }
      createProjectRequest.breakList = breakList;
      createProjectRequest.roundTimesheets =
          selectedRoundSheetIndex == -1 ?  "" : roundTimeSheet[selectedRoundSheetIndex];
      try {
        var model = await api.createProject(context, createProjectRequest);
        if (model.success!) {
          ProjectsPageManager.isProjectCreated = true;
          ProjectsPageManager.projectId = model.data!.id!;
          Navigator.popUntil(context, (route) {
            if (route.settings.name == "bottomBarManager") {
              return true;
            } else {
              return false;
            }
          });
        } else {
          DialogHelper.showMessage(context, model.message!);
        }
        setState(ViewState.idle);
      } on FetchDataException catch (e) {
        setState(ViewState.idle);
        DialogHelper.showMessage(context, e.toString());
      } on SocketException catch (e) {
        setState(ViewState.idle);
        DialogHelper.showMessage(context, "internet_connection".tr());
      }
   // }
  }
}
