import 'package:beehive/provider/base_provider.dart';

import '../helper/date_function.dart';
import '../model/crew_timesheet_model.dart';
import '../model/project_working_hour_detail.dart';

class TimeSheetsScreenProvider extends BaseProvider {
  int? getTotalMinutes(String? checkInTime, String? checkOutTime) {
    var startTime = DateFunctions.getDateTimeFromString(checkInTime!);
    var endTime = DateFunctions.getDateTimeFromString(
        (checkOutTime == null || checkOutTime.trim().isEmpty)
            ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now())
            : checkOutTime);
    return endTime.difference(startTime).inMinutes;
  }

  String checkInOutTime(String? time) {
    return DateFunctions.dateTO12Hour(DateFunctions.checkTimeIsNull(time))
        .substring(
      0,
      DateFunctions.dateTO12Hour(DateFunctions.checkTimeIsNull(time)).length -
          1,
    );
  }


  List<ProjectWorkingHourDetail> getTimeForStepper(AllCheckin detail) {
    List<Interuption> timeString = [];
    List<ProjectWorkingHourDetail> projectWorkingHourList = [];
    for (int i = 0; i < detail.allCheckinBreak!.length; i++) {
      if (detail.allCheckinBreak![i].startTime?.toLowerCase() != "any time") {
        var breakStartTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${detail.allCheckinBreak![i].startTime!.replaceAll("PM", "").replaceAll("AM", "")}";
        var breakEndTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${DateFunctions.stringToDateAddMintues(detail.allCheckinBreak![i].startTime!, int.parse(detail.allCheckinBreak![i].interval!.substring(0, 2)))}";
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

}
