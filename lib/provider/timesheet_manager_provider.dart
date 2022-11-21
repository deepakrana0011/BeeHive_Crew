import 'dart:io';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/project_timesheet_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../model/get_all_crew_on_project_response.dart';
import '../model/timesheet_weekly_data_model_manager.dart';
import '../model/weekely_data_model_manager.dart';

class TimeSheetManagerProvider extends BaseProvider {
  List<TimeSheetProjectData> projectDataResponse = [];
  List<String> projectsTotalHours = [];
  GetAllCrewOnProject? getAllCrewResponse;
  int totalActiveProjects = 0;
  int? totalHoursAllActiveProjects;

  String? allProjectHour;

  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;

  int selectIndex = 0;

  List<TimeSheetWeeklyDataModelManager> weeklyData = [];

  indexCheck(int value) {
    selectIndex = value;
    notifyListeners();
  }

  TabController? controller;

  bool isLoading = false;

  void updateLoading(bool value) {
    isLoading = value;
    customNotify();
  }

  dateConvertorWeekly(String date) {
    var getDate = DateTime.parse(date);
    return DateFormat("EEE MMM, dd").format(getDate);
  }

  String getOneProjectTotalHours(List<TimeSheetCheckins>? checkins) {
    var totalMinutes = 0;
    for (var element in checkins!) {
      var startTime = DateFunctions.getDateTimeFromString(element.checkInTime!);
      var endTime =
          (element.checkOutTime == null || element.checkOutTime!.trim().isEmpty)
              ? DateTime.now()
              : DateFunctions.getDateTimeFromString(element.checkOutTime!);
      var minutes = startTime.difference(endTime).inMinutes;
      totalMinutes = totalMinutes + minutes;
    }
    var totalHours = DateFunctions.minutesToHourString(totalMinutes);
    return totalHours;
  }

  var totalMinutes = 0;

  Future<void> projectTimeSheetManager(BuildContext context,
      {showFullLoader = false}) async {
    showFullLoader ? setState(ViewState.busy) : updateLoading(true);
    try {
      var currentTime = DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now());
      var model = await api.projectTimeSheetManager(
          context, startDate!, endDate!, currentTime);
      if (model.success == true) {
        totalActiveProjects = model.activeProject ?? 0;
        totalHoursAllActiveProjects = model.totalHours ?? 0;
        if (model.projectData.isNotEmpty) {
          projectDataResponse = [];
          projectDataResponse = model.projectData;
          if (controller?.index != 0) {
            groupDataByDate();
          }
          for (var element in projectDataResponse) {
            int projectDataIndex = projectDataResponse.indexOf(element);
            for (var checkInElement in element.checkins) {
              int checkinsIndex = element.checkins.indexOf(checkInElement);
              var startTime = DateFunctions.getDateTimeFromString(
                  checkInElement.checkInTime!);
              var endTime = DateFunctions.getDateTimeFromString(
                  (checkInElement.checkOutTime == null ||
                          checkInElement.checkOutTime!.trim().isEmpty)
                      ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now())
                      : checkInElement.checkOutTime!);
              var minutes = endTime.difference(startTime).inMinutes;
              totalMinutes = totalMinutes + minutes;

              projectDataResponse[projectDataIndex]
                  .checkins[checkinsIndex]
                  .totalMinutes = minutes;
            }
            var totalHours = DateFunctions.minutesToHourString(totalMinutes);
            projectsTotalHours.add(totalHours);
            totalMinutes = 0;
          }
          getAllProjectTotalHours();
        } else {
          projectDataResponse = [];
          allProjectHour = "00:00";
        }
      }
      showFullLoader ? setState(ViewState.idle) : updateLoading(false);
    } on FetchDataException catch (e) {
      projectDataResponse = [];
      showFullLoader ? setState(ViewState.idle) : updateLoading(false);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      projectDataResponse = [];
      showFullLoader ? setState(ViewState.idle) : updateLoading(false);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void getAllProjectTotalHours() {
    var totalHours = 0;
    for (var element in projectDataResponse) {
      var totalMinutes = 0;
      for (var element in element.checkins) {
        var startTime =
            DateFunctions.getDateTimeFromString(element.checkInTime!);
        var endTime = (element.checkOutTime == null ||
                element.checkOutTime!.trim().isEmpty)
            ? DateTime.now()
            : DateFunctions.getDateTimeFromString(element.checkOutTime!);
        var minutes = startTime.difference(endTime).inMinutes;
        totalMinutes = totalMinutes + minutes.abs();
      }
      totalHours = totalHours + totalMinutes;
    }

    allProjectHour = DateFunctions.minutesToHourString(totalHours);
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

  String getTotalHoursOnProjects(List<Datum>? getData) {
    var totalMinutes = 0;
    for (var element in getData!) {
      if (element.totalHours != null) {
        totalMinutes = totalMinutes + element.totalHours!;
      }
    }
    var totalHours = DateFunctions.minutesToHourString(totalMinutes);
    return totalHours;
  }

  Future<void> getAllCrewOnProject(context) async {
    setState(ViewState.busy);
    try {
      var model = await api.getAllCrewOnProjects(context);
      if (model.success == true) {
        getAllCrewResponse = model;
      }
      setState(ViewState.idle);
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void groupDataByDate() {
    weeklyData.clear();
    for (int i = 0; i < projectDataResponse.length; i++) {
      var selectedDate =
          DateFormat("yyyy-MM-dd").parse(projectDataResponse[i].date!);
      var dateTimeString = DateFunctions.dateFormatWithDayName(selectedDate);
      if (weeklyData.isEmpty) {
        List<TimeSheetProjectData> projectDataList = [];
        projectDataList.add(projectDataResponse[i]);
        var weeklyDataObject = TimeSheetWeeklyDataModelManager();
        weeklyDataObject.date = dateTimeString;
        weeklyDataObject.projectDataList = projectDataList;
        weeklyData.add(weeklyDataObject);
      } else {
        var index =
            weeklyData.indexWhere((element) => element.date == dateTimeString);
        if (index == -1) {
          List<TimeSheetProjectData> projectDataList = [];
          projectDataList.add(projectDataResponse[i]);
          var weeklyDataObject = TimeSheetWeeklyDataModelManager();
          weeklyDataObject.date = dateTimeString;
          weeklyDataObject.projectDataList = projectDataList;
          weeklyData.add(weeklyDataObject);
        } else {
          weeklyData[index].projectDataList?.add(projectDataResponse[i]);
        }
      }
    }
  }
}
