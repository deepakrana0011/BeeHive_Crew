import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../helper/date_function.dart';
import '../helper/dialog_helper.dart';
import '../model/crew_timesheet_model.dart';
import '../model/project_working_hour_detail.dart';
import '../model/weekly_timesheet_crew.dart';
import '../services/fetch_data_expection.dart';

class TimeSheetTabBarProviderCrew extends BaseProvider {
  TabController? controller;
  List<Widget> widgetList = [];
  List<int> hoursList = [60, 30, 240, 80, 60];
  bool isLoading = false;
  String? startDate;
  String? endDate;
  String? weekFirstDate;
  String? weekEndDate;
  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();
  CrewTimeSheetModel? crewTimeSheetModel;
  int selectedTabIndex = 0;
  String? totalHours;
  String? totalEarnings;
  String? averageRatePerHour;
  List<WeeklyTimeSheetCrew> weeklyData = [];

  void updateLoading(bool value) {
    isLoading = value;
    customNotify();
  }

  void updateSelectedTabIndex(int index) {
    selectedTabIndex = index;
    customNotify();
  }

/*  getWidget() {
    for (int i = 0; i < hoursList.length; i++) {
      widgetList.add(Flexible(
        flex: hoursList[i],
        child: Container(
          height: 5,
          color: i % 2 == 0 ? Colors.green : Colors.grey,
        ),
      ));
    }
  }*/

  Future<void> getTimesheet(BuildContext context,
      {showFullLoader = false}) async {
    showFullLoader ? setState(ViewState.busy) : updateLoading(true);
    try {
      var currentTime = DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now());
      var model =
          await api.crewTimeSheet(context, startDate!, endDate!, currentTime);
      if (model.success == true) {
        crewTimeSheetModel = model;
        getToTalHours();
        if (selectedTabIndex != 0) {
          groupDataByDate();
        }
      }
      showFullLoader ? setState(ViewState.idle) : updateLoading(false);
    } on FetchDataException catch (e) {
      showFullLoader ? setState(ViewState.idle) : updateLoading(false);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      showFullLoader ? setState(ViewState.idle) : updateLoading(false);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void getToTalHours() {
    var totalMinutes = 0;
    var totalPrice = 0.0;
    for (var element in crewTimeSheetModel!.allCheckin!) {
      var startTime = DateFunctions.getDateTimeFromString(element.checkInTime!);
      var endTime = DateFunctions.getDateTimeFromString(
          element.checkOutTime == null || element.checkOutTime!.trim().isEmpty
              ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now())
              : element.checkOutTime!);
      var minutes = endTime.difference(startTime).inMinutes;
      totalMinutes = totalMinutes + minutes;
      totalPrice = totalPrice +
          double.parse(
              element.assignProjectId!.projectRate![0].price.toString());
    }
    totalHours = DateFunctions.minutesToHourString(totalMinutes);
    double averagePricePerHour =
        totalPrice / crewTimeSheetModel!.allCheckin!.length;
    averageRatePerHour = averagePricePerHour.toStringAsFixed(2);
    double hoursForEarning = totalMinutes / 60;
    var value = hoursForEarning * averagePricePerHour;
    totalEarnings = value.toStringAsFixed(2);
    customNotify();
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

  List<ProjectWorkingHourDetail> getTimeForStepper(AllCheckin detail) {
    List<Interuption> timeString = [];
    List<ProjectWorkingHourDetail> projectWorkingHourList = [];
    for (int i = 0; i < detail.allCheckinBreak!.length; i++) {
      if (detail.allCheckinBreak![i].startTime?.toLowerCase() !=
          "Any Time".toLowerCase()) {
        var breakStartTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${detail.allCheckinBreak![i].startTime!.replaceAll("PM", "").replaceAll("AM", "")}";
        var breakEndTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${DateFunctions.stringToDateAddMintues(detail.allCheckinBreak![i].startTime!, int.parse(detail.allCheckinBreak![i].interval!.substring(0, 2)))}";
        var breakStartTimeDate =
            DateFunctions.getDateTimeFromString(breakStartTimeString);
        var checkInDate =
            DateFunctions.getDateTimeFromString(detail.checkInTime!);
        var checkOutDate = DateFunctions.getDateTimeFromString(DateFunctions.checkTimeIsNull(detail.checkOutTime));
        if (breakStartTimeDate.isAfter(checkInDate) &&
            breakStartTimeDate.isBefore(checkOutDate)) {
          var interruption = Interuption();
          interruption.startTime = breakStartTimeString;
          interruption.endTime = breakEndTimeString;
          interruption.selfMadeInterruption = true;
          timeString.add(interruption);
        }
      }
    }
    if (detail.interuption!.isNotEmpty) {
      timeString.addAll(detail.interuption!);
    }

    timeString.sort((a, b) {
      var aValue = DateFunctions.getDateTimeFromString(a.startTime!);
      var bValue = DateFunctions.getDateTimeFromString(b.startTime!);
      return aValue.compareTo(bValue);
    });

    if (timeString.isNotEmpty) {
      var checkInDate =
          DateFunctions.getDateTimeFromString(detail.checkInTime!);
      var checkInDateString = detail.checkInTime!;
      for (var value in timeString) {
        var breakStartTime =
            DateFunctions.getDateTimeFromString(value.startTime!);
        var breakEndTime = DateFunctions.getDateTimeFromString(value.endTime!);
        var workingMinutesDifference =
            breakStartTime.difference(checkInDate).inMinutes;
        projectWorkingHourList.add(ProjectWorkingHourDetail(
            startTime: checkInDateString,
            endTime: value.startTime!,
            timeInterval: workingMinutesDifference.abs(),
            type: 1));

        var breakMinutesDifference =
            breakEndTime.difference(breakStartTime).inMinutes;
        if (value.selfMadeInterruption!) {
          projectWorkingHourList.add(ProjectWorkingHourDetail(
              startTime: value.startTime!,
              endTime: value.endTime!,
              timeInterval: breakMinutesDifference.abs(),
              type: 2));
        } else {
          projectWorkingHourList.add(ProjectWorkingHourDetail(
              startTime: value.startTime!,
              endTime: value.endTime!,
              timeInterval: breakMinutesDifference.abs(),
              type: 3));
        }
        checkInDate = breakEndTime;
        checkInDateString = value.endTime!;
      }

      var checkOutDate = DateFunctions.getDateTimeFromString(
          DateFunctions.checkTimeIsNull(detail.checkOutTime));
      var checkOutDateString =
          DateFunctions.checkTimeIsNull(detail.checkOutTime);
      var workingMinutesDifference =
          checkInDate.difference(checkOutDate).inMinutes;
      projectWorkingHourList.add(ProjectWorkingHourDetail(
          startTime: checkInDateString,
          endTime: checkOutDateString,
          timeInterval: workingMinutesDifference,
          type: 1));
    } else {
      var checkInString = detail.checkInTime!;
      var checkOutString = DateFunctions.checkTimeIsNull(detail.checkOutTime);
      projectWorkingHourList.add(ProjectWorkingHourDetail(
          startTime: checkInString,
          endTime: checkOutString,
          timeInterval: 1,
          type: 1));
    }
    return projectWorkingHourList;
  }

  void groupDataByDate() {
    weeklyData.clear();
    for (int i = 0; i < crewTimeSheetModel!.allCheckin!.length; i++) {
      var selectedDate = DateFunctions.getDateTimeFromString(
          crewTimeSheetModel!.allCheckin![i].checkInTime!);
      var dateTimeString = DateFunctions.dateFormatWithDayName(selectedDate);
      if (weeklyData.isEmpty) {
        List<AllCheckin> projectDetailList = [];
        projectDetailList.add(crewTimeSheetModel!.allCheckin![i]);
        var weeklyDataObject = WeeklyTimeSheetCrew();
        weeklyDataObject.date = dateTimeString;
        weeklyDataObject.checkInDataList = projectDetailList;
        weeklyData.add(weeklyDataObject);
      } else {
        var index = weeklyData.indexWhere((element) => element.date == dateTimeString);
        if (index == -1) {
          List<AllCheckin> projectDetailList = [];
          projectDetailList.add(crewTimeSheetModel!.allCheckin![i]);
          var weeklyDataObject = WeeklyTimeSheetCrew();
          weeklyDataObject.date = dateTimeString;
          weeklyDataObject.checkInDataList = projectDetailList;
          weeklyData.add(weeklyDataObject);
        } else {
          weeklyData[index]
              .checkInDataList!
              .add(crewTimeSheetModel!.allCheckin![i]);
        }
      }
    }
  }
}
