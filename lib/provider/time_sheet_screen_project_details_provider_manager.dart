import 'package:beehive/model/project_timesheet_response.dart';
import 'package:beehive/provider/base_provider.dart';

import '../helper/date_function.dart';
import '../model/crew_dashboard_response.dart';
import '../model/manager_dashboard_response.dart';
import '../model/project_working_hour_detail.dart';

class TimeSheetScreenProjectDetailsProvider extends BaseProvider {
  List<ProjectWorkingHourDetail> getTimeForStepper(Checkins detail) {
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
        var checkOutDate =
            DateFunctions.getDateTimeFromString(detail.checkOutTime!);
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
      var checkOutDate =
          (detail.checkOutTime == null || detail.checkOutTime!.trim().isEmpty)
              ? DateTime.now()
              : DateFunctions.getDateTimeFromString(detail.checkOutTime!);
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
      var checkOutString =
          (detail.checkOutTime == null || detail.checkOutTime!.trim().isEmpty)
              ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now())
              : detail.checkOutTime;
      projectWorkingHourList.add(ProjectWorkingHourDetail(
          startTime: checkInString,
          endTime: checkOutString,
          timeInterval: 1,
          type: 1));
    }
    return projectWorkingHourList;
  }
}
