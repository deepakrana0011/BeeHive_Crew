import 'dart:io';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/model/project_timesheet_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../helper/date_function.dart';
import '../helper/dialog_helper.dart';
import '../model/project_working_hour_detail.dart';
import '../services/fetch_data_expection.dart';

class TimeSheetScreenProjectDetailsProvider extends BaseProvider {
  late TimeSheetProjectData? projectData;

  bool _removeInterruption = false;

  bool get removeInterruption => _removeInterruption;

  set removeInterruption(bool value) {
    _removeInterruption = value;
    notifyListeners();
  }

  List<ProjectWorkingHourDetail> getTimeForStepper(TimeSheetCheckins detail) {
    List<Interuption> timeString = [];
    List<ProjectWorkingHourDetail> projectWorkingHourList = [];
    for (int i = 0; i < detail.breaks!.length; i++) {
      if (detail.breaks![i].startTime?.toLowerCase() != "any time") {
        var breakStartTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${detail.breaks![i].startTime!.replaceAll("PM", "").replaceAll("AM", "")}";
        var breakEndTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${DateFunctions.stringToDateAddMintues(detail.breaks![i].startTime!, int.parse(detail.breaks![i].interval!.substring(0, 2)))}";
        var breakStartTimeDate =
            DateFunctions.getDateTimeFromString(breakStartTimeString);
        var checkInDate =
            DateFunctions.getDateTimeFromString(detail.checkInTime!);
        var checkOutDate = DateFunctions.getDateTimeFromString(
            DateFunctions.checkTimeIsNull(detail.checkOutTime));
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
          checkOutDate.difference(checkInDate).inMinutes;
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

  int? getTotalMinutes(String? checkInTime, String? checkOutTime) {
    var startTime = DateFunctions.getDateTimeFromString(checkInTime!);
    var endTime = DateFunctions.getDateTimeFromString(
        (checkOutTime == null || checkOutTime.trim().isEmpty)
            ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now())
            : checkOutTime);
    return endTime.difference(startTime).inMinutes;
  }

  Future<void> ignoreAllInteruptions(
      BuildContext context, String checkInId, int index) async {
    try {
      setState(ViewState.busy);
      var model = await api.ignoreAllInteruptions(context, checkInId);
      if (model.success!) {
        removeInterruption = true;
        projectData?.checkins[index].ignoredInteruption =
            projectData?.checkins[index].interuption ?? [];
        projectData?.checkins[index].interuption = [];
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

  Future<void> revertCheckinInteruptions(
      BuildContext context, String checkInId, int index) async {
    try {
      setState(ViewState.busy);
      var model = await api.revertCheckinInteruptions(context, checkInId);

      if (model.success!) {
        removeInterruption = false;
        projectData?.checkins[index].interuption =
            model.details?.interuption ?? [];
        projectData?.checkins[index].ignoredInteruption =
            model.details?.ignoredInteruption ?? [];
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

  Future<void> changeCheckInOutTime(BuildContext context, String checkInId,
      int index, DateTime date, int type) async {
    //type 0 for checkin and 1 for checkout
    String time = DateFunctions.dateFormatyyyyMMddHHmm(date);
    try {
      setState(ViewState.busy);
      var model =
          await api.updateCheckInOutTime(context, checkInId, type, time);

      if (model.success!) {
        if (type == 0) {
          projectData?.checkins[index].checkInTime = time;
        } else {
          projectData?.checkins[index].checkOutTime = time;
        }
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
}
