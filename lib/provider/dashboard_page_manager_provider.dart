import 'dart:io';

import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/model/weekely_data_model_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/drawer_manager_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class DashBoardPageManagerProvider extends BaseProvider {
  TabController? controller;
  bool checkedInNoProjects = false;
  DrawerManagerProvider drawerManagerProvider =
      locator<DrawerManagerProvider>();

  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;
  bool noProject = false;

  bool isLoading = false;

  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;
  String? allProjectHour;

  List<WeekelyDataModelManager> weeklyData = [];

  updateNoProject() {
    noProject = !noProject;
    notifyListeners();
  }

  ManagerDashboardResponse? managerResponse;
  List<String> projectNameInitials = [];

  getInitials({required String string, required int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0; i < (split.length > 1 ? limitTo : split.length); i++) {
      buffer.write(split[i][0]);
    }
    projectNameInitials.add(buffer.toString());
  }

  void updateLoading(bool value) {
    isLoading = value;
    customNotify();
  }

  Future dashBoardApi(
      BuildContext context, BottomBarManagerProvider? managerProvider,
      {showFullLoader = false}) async {
    if (showFullLoader) {
      setState(ViewState.busy);
    } else {
      updateLoading(true);
    }
    try {
      var model = await api.dashBoardApiManager(context, startDate!, endDate!);
      if (showFullLoader) {
        setState(ViewState.idle);
      } else {
        updateLoading(false);
      }
      if (model.success == true) {
        managerResponse = model;
        managerProvider!.updateDrawerData(
            model.manager?.name ?? '',
            model.manager?.profileImage ?? '',
            model.manager?.companyLogo ?? '');
        getAllProjectTotalHours();
        if (controller!.index != 0) {
          groupDataByDate();
        }
      }
    } on FetchDataException catch (e) {
      if (showFullLoader) {
        setState(ViewState.idle);
      } else {
        updateLoading(false);
      }
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      if (showFullLoader) {
        setState(ViewState.idle);
      } else {
        updateLoading(false);
      }
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void groupDataByDate() {
    weeklyData.clear();
    for (int i = 0; i < managerResponse!.projectData!.length; i++) {
      for (int k = 0;
          k < managerResponse!.projectData![i].checkins!.length;
          k++) {
        var selectedDate = DateFunctions.getDateTimeFromString(
            managerResponse!.projectData![i].checkins![k].checkInTime!);
        var dateTimeString = DateFunctions.dateFormatWithDayName(selectedDate);
        if (weeklyData.isEmpty) {
          List<CheckInProjectDetailManager> projectDetailList = [];
          projectDetailList.add(managerResponse!.projectData![i].checkins![k]);
          var weekelyDataObject = WeekelyDataModelManager();
          weekelyDataObject.date = dateTimeString;
          weekelyDataObject.checkInDataList = projectDetailList;
          weekelyDataObject.projectName =
              managerResponse!.projectData![i].projectName ?? "";
          weeklyData.add(weekelyDataObject);
        } else {
          var index = weeklyData
              .indexWhere((element) => element.date == dateTimeString);
          if (index == -1) {
            List<CheckInProjectDetailManager> projectDetailList = [];
            projectDetailList
                .add(managerResponse!.projectData![i].checkins![k]);
            var weekelyDataObject = WeekelyDataModelManager();
            weekelyDataObject.date = dateTimeString;
            weekelyDataObject.checkInDataList = projectDetailList;
            weekelyDataObject.projectName =
                managerResponse!.projectData![i].projectName ?? "";
            weeklyData.add(weekelyDataObject);
          } else {
            weeklyData[index]
                .checkInDataList!
                .add(managerResponse!.projectData![i].checkins![k]);
          }
        }
      }
    }
  }

  String getOneProjectTotalHours(List<CheckInProjectDetailManager>? checkins) {
    var totalMinutes = 0;
    for (var element in checkins!) {
      var startTime = DateFunctions.getDateTimeFromString(element.checkInTime!);
      var endTime = DateFunctions.getDateTimeFromString(element.checkOutTime!);
      var minutes = endTime.difference(startTime).inMinutes;
      totalMinutes = totalMinutes + minutes;
    }
    var totalHours = DateFunctions.durationToString(totalMinutes);
    return totalHours;
  }

  void getAllProjectTotalHours() {
    var totalMinutes = 0;
    for (var element in managerResponse!.projectData!) {
      for (var element in element.checkins!) {
        var startTime =
            DateFunctions.getDateTimeFromString(element.checkInTime!);
        var endTime =
            DateFunctions.getDateTimeFromString(element.checkOutTime!);
        var minutes = endTime.difference(startTime).inMinutes;
        totalMinutes = totalMinutes + minutes;
      }
    }
    var totalHours = DateFunctions.durationToString(totalMinutes);
    allProjectHour = totalHours;
  }

  void nextWeekDays(int numberOfDays) {
    if (selectedEndDate == null) {
      selectedStartDate = DateTime.now().subtract(Duration(days: numberOfDays));
      selectedEndDate = DateTime.now();
    } else {
      selectedStartDate = selectedEndDate!.add(const Duration(days: 1));
      var newDate = selectedEndDate!.add(Duration(days: numberOfDays));
      if (newDate.isAfter(DateTime.now())) {
        selectedEndDate = DateTime.now();
      } else {
        selectedEndDate = newDate;
      }
    }
    startDate = DateFormat("yyyy-MM-dd").format(selectedStartDate!);
    endDate = DateFormat("yyyy-MM-dd").format(selectedEndDate!);

    weekFirstDate = DateFunctions.getMonthDay(selectedStartDate!);
    weekEndDate = DateFunctions.getMonthDay(selectedEndDate!);
    customNotify();
  }

  void previousWeekDays(int numberOfDays) {
    selectedEndDate = selectedStartDate!.subtract(const Duration(days: 1));
    var newDate = selectedEndDate!.subtract(Duration(days: numberOfDays));
    selectedStartDate = newDate;

    startDate = DateFormat("yyyy-MM-dd").format(selectedStartDate!);
    endDate = DateFormat("yyyy-MM-dd").format(selectedEndDate!);

    weekFirstDate = DateFunctions.getMonthDay(selectedStartDate!);
    weekEndDate = DateFunctions.getMonthDay(selectedEndDate!);
    customNotify();
  }
}
