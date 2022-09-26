// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/allProjectCrewResponse.dart';
import 'package:beehive/model/check_box_model_crew.dart';
import 'package:beehive/model/check_in_response_crew.dart';
import 'package:beehive/model/check_out_response_crew.dart';
import 'package:beehive/model/dash_board_page_response_crew.dart';
import 'package:beehive/model/project_working_hour_detail.dart';
import 'package:beehive/model/weekely_data_model.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/provider/bottom_bar_provider.dart';
import 'package:beehive/widget/get_time.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../model/crew_dashboard_response.dart';
import '../services/fetch_data_expection.dart';

class DashboardProvider extends BaseProvider {
  String projectName = '';
  bool checkedInNoProjects = false;

  int? hours;
  String? hourOut;
  String? minOut;
  String? amPm;
  String? min;
  String? time;
  TimeOfDay? selectedTime;

  int hour = 0;
  int minutes = 0;
  int timerHour = 0;
  int minuteCount = 0;
  Timer? timer;

  String? checkOutTime;
  String? firstDate;
  String? secondDate;

  String? currentCheckInProjectId;
  List<int> hoursList = [];
  List<Widget> widgetList = [];
  List<String> projectNameInitials = [];

  String? initialDate;

  CrewDashboardResponse? crewResponse;
  int selectedTabIndex = 0;
  AllProjectCrewResponse? allProjectCrewResponse;
  String assignProjectId = "";
  String timeFromLastCheckedIn = "0h 0m";
  String totalSpendTime = "0h 0m";
  String? totalHours;

  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;

  TimeOfDay initialTime = TimeOfDay.now();
  String? selectedCheckOutTime;
  List<WeekelyDataModelCrew> weeklyData = [];

  Future getDashBoardData(
    BuildContext context,
    BottomBarProvider? managerProvider,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.dashBoardApi(context, startDate!, endDate!);
      if (model.success ?? false) {
        crewResponse = model;
        managerProvider!.updateDrawerData(
          model.crew?.name ?? '',
          model.crew?.profileImage ?? '',
        );
        //model.crew?.companyLogo ?? ''//

        getToTalHours();
        if (selectedTabIndex != 0) {
          groupDataByDate();
        }
        setState(ViewState.idle);
      } else {
        setState(ViewState.idle);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void getToTalHours() {
    var totalMinutes = 0;
    for (var element in crewResponse!.allCheckin!) {
      var startTime = DateFunctions.getDateTimeFromString(element.checkInTime!);
      var endTime = DateFunctions.getDateTimeFromString(element.checkOutTime!);
      var minutes = endTime.difference(startTime).inMinutes;
      totalMinutes = totalMinutes + minutes;
    }
    totalHours = DateFunctions.minutesToHourString(totalMinutes);
    customNotify();
  }

  void groupDataByDate() {
    weeklyData.clear();
    for (int i = 0; i < crewResponse!.allCheckin!.length; i++) {
      var selectedDate = DateFunctions.getDateTimeFromString(
          crewResponse!.allCheckin![i].checkInTime!);
      var dateTimeString = DateFunctions.dateFormatWithDayName(selectedDate);
      if (weeklyData.isEmpty) {
        List<CheckInProjectDetailCrew> projectDetailList = [];
        projectDetailList.add(crewResponse!.allCheckin![i]);
        var weekelyDataObject = WeekelyDataModelCrew();
        weekelyDataObject.date = dateTimeString;
        weekelyDataObject.checkInDataList = projectDetailList;
        weeklyData.add(weekelyDataObject);
      } else {
        var index =
            weeklyData.indexWhere((element) => element.date == dateTimeString);
        if (index == -1) {
          List<CheckInProjectDetailCrew> projectDetailList = [];
          projectDetailList.add(crewResponse!.allCheckin![i]);
          var weekelyDataObject = WeekelyDataModelCrew();
          weekelyDataObject.date = dateTimeString;
          weekelyDataObject.checkInDataList = projectDetailList;
          weeklyData.add(weekelyDataObject);
        } else {
          weeklyData[index].checkInDataList!.add(crewResponse!.allCheckin![i]);
        }
      }
    }
  }

  Future checkInApi(
    context, BottomBarProvider bottomBarProvider,
  ) async {
    setState(ViewState.busy);
    try {
      var checkInTime = DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now());
      var model = await api.checkInApi(context, assignProjectId, checkInTime);
      assignProjectId = "";
      if (model.success == true) {
        getDashBoardData(context,bottomBarProvider);
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

  Future checkOutApi(
    context, BottomBarProvider bottomBarProvider,
  ) async {
    setState(ViewState.busy);
    try {
      var checkoutTime = DateFunctions.tweleveTo24Hour(selectedCheckOutTime);
      var value = DateFunctions.getCurrentDateMonthYear();
      var checkInTimeFinal = value + " " + checkoutTime;
      var model = await api.checkOutApiCrew(
          context, crewResponse!.userCheckin!.id!, checkInTimeFinal);
      if (model.success == true) {
        setState(ViewState.idle);
        getDashBoardData(context,bottomBarProvider);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  Future getAllProjectsWithoutCheckout(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      allProjectCrewResponse = await api.getAllProjectsCrew(context);
      setState(ViewState.idle);
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  getTimeDifferenceBetweenTime(String timeDifference) {
    DateTime time = DateTime.parse(timeDifference);
    var getDifference = time.difference(DateTime.now()).inHours;
    print(getDifference);
  }

  showTimePickerWidget(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstants.primaryColor,
              onSurface: ColorConstants.primaryColor,
            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.green,
              ),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );
    if (pickedTime != null) {
      var checkInDate = DateFunctions.getDateTimeFromString(
          crewResponse!.userCheckin!.checkInTime!);
      var pickedTimeString = DateFunctions.getCurrentDateMonthYear() +
          " " +
          pickedTime.format(context);
      var checkOutDate = DateFunctions.getDateTimeFromString(pickedTimeString);
      if (checkOutDate.isBefore(checkInDate)) {
        DialogHelper.showMessage(
            context, "Checkout Time should be greater than check in time");
      } else {
        initialTime = pickedTime;
        selectedCheckOutTime =
            DateFunctions.twentyFourHourTO12Hour(initialTime.format(context));
      }
    }
  }

  getInitials({required String string, required int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0; i < (split.length > 1 ? limitTo : split.length); i++) {
      buffer.write(split[i][0]);
    }
    projectNameInitials.add(buffer.toString());
  }

  void updateSelectedTabIndex(int index) {
    selectedTabIndex = index;
    customNotify();
  }

  void calculateCheckInTime() {
    var time;
    if (crewResponse!.userCheckin!.interuption!.length > 0) {
      time = crewResponse!
          .userCheckin!
          .interuption![crewResponse!.userCheckin!.interuption!.length - 1]
          .endTime!;
    } else {
      time = crewResponse!.userCheckin!.checkInTime;
    }
    var checkIntDateTime = DateFunctions.getDateTimeFromString(time);
    var timeInMinutes = DateTime.now().difference(checkIntDateTime).inMinutes;
    timeFromLastCheckedIn = DateFunctions.minutesToHourString(timeInMinutes);
    customNotify();
  }

  void calculateTotalHourTime() {
    var checkIntDateTime = DateFunctions.getDateTimeFromString(
        crewResponse!.userCheckin!.checkInTime!);
    var timeInMinutes = DateTime.now().difference(checkIntDateTime).inMinutes;
    totalSpendTime = DateFunctions.minutesToHourString(timeInMinutes);
    customNotify();
  }

  void startTimer(Timer? timer) {
    if (crewResponse!.userCheckin != null) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (crewResponse!.userCheckin == null) {
          timer!.cancel();
        } else {
          calculateCheckInTime();
          calculateTotalHourTime();
        }
      });
    }
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

  List<ProjectWorkingHourDetail> getTimeForStepper(
      CheckInProjectDetailCrew detail) {
    List<Interruption> timeString = [];
    List<ProjectWorkingHourDetail> projectWorkingHourList = [];
    for (int i = 0; i < detail.allCheckinBreak!.length; i++) {
      if (detail.allCheckinBreak![i].interval != "Any") {
        var breakStartTimeString = detail.checkInTime!.substring(0, 10) +
            " " +
            detail.allCheckinBreak![i].startTime!
                .replaceAll("PM", "")
                .replaceAll("AM", "");
        var breakEndTimeString = detail.checkInTime!.substring(0, 10) +
            " " +
            DateFunctions.stringToDateAddMintues(
                detail.allCheckinBreak![i].startTime!,
                int.parse(
                    detail.allCheckinBreak![i].interval!.substring(0, 2)));

        var breakStartTimeDate =
            DateFunctions.getDateTimeFromString(breakStartTimeString);
        var checkInDate =
            DateFunctions.getDateTimeFromString(detail.checkInTime!);
        var checkOutDate =
            DateFunctions.getDateTimeFromString(detail.checkOutTime!);
        if (breakStartTimeDate.isAfter(checkInDate) &&
            breakStartTimeDate.isBefore(checkOutDate)) {
          var interruption = Interruption();
          interruption.startTime = breakStartTimeString;
          interruption.endTime = breakEndTimeString;
          interruption.selfMadeInterruption = true;
          timeString.add(interruption);
        }
      }
    }
    if (detail.interuption!.length > 0) {
      timeString.addAll(detail.interuption!);
    }

    timeString.sort((a, b) {
      var aValue = DateFunctions.getDateTimeFromString(a.startTime!);
      var bValue = DateFunctions.getDateTimeFromString(b.startTime!);
      return aValue.compareTo(bValue);
    });

    print("data sorted ${timeString}");

    if (timeString.length > 0) {
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

      var checkOutDate =
          DateFunctions.getDateTimeFromString(detail.checkOutTime!);
      var checkOutDateString = detail.checkOutTime!;
      var workingMinutesDifference =
          checkInDate.difference(checkOutDate).inMinutes;
      projectWorkingHourList.add(ProjectWorkingHourDetail(
          startTime: checkInDateString,
          endTime: checkOutDateString,
          timeInterval: workingMinutesDifference,
          type: 1));
    } else {
      var checkInString = detail.checkInTime!;
      var checkOutString = detail.checkOutTime!;
      projectWorkingHourList.add(ProjectWorkingHourDetail(
          startTime: checkInString,
          endTime: checkOutString,
          timeInterval: 1,
          type: 1));
    }
    return projectWorkingHourList;
  }
}
