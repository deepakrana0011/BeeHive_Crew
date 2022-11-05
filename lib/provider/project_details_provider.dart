import 'dart:async';
import 'dart:io';

import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/crew_dashboard_response.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/model/project_detail_crew_response.dart';
import 'package:beehive/model/project_working_hour_detail.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProjectDetailsPageProvider extends BaseProvider {
  Completer<GoogleMapController> controller = Completer();
  BitmapDescriptor? pinLocationIconUser;
  GoogleMapController? googleMapController;
  String? projectId;
  List<Marker> markers = [];

  ProjectDetailCrewResponse? projectDetailCrewResponse;

  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;




  final CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.7333, 76.7794),
      tilt: 20,
      zoom: 10);
  bool checkedInNoProjects = false;

  TabController? tabController;
  int selectedIndex = 0;

  Future getProjectDetail(BuildContext context) async {
    setState(ViewState.busy);
    try {
      projectDetailCrewResponse = await api.getProjectDetailCrew(
          context, projectId!, startDate!, endDate!);
      createMarker();
      setState(ViewState.idle);
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void setCustomMapPinUser() async {
    pinLocationIconUser = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), ImageConstants.locationMark);
    notifyListeners();
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

  void createMarker() {
    double latitude = projectDetailCrewResponse?.projectData?.latitude ?? 0.0;
    double longitude = projectDetailCrewResponse?.projectData?.longitude ?? 0.0;
    markers.add(Marker(
      markerId: const MarkerId("ID1"),
      position: LatLng(latitude, longitude),
      icon: pinLocationIconUser!,
      flat: true,
      anchor: const Offset(0.5, 0.5),
    ));
    googleMapController?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 14));
  }

  List<ProjectWorkingHourDetail> getTimeForStepper(
      CheckInProjectDetailManager detail) {
    List<Interruption> timeString = [];
    List<ProjectWorkingHourDetail> projectWorkingHourList = [];
    for (int i = 0; i < detail.checkinBreak!.length; i++) {
      if (detail.checkinBreak![i].startTime?.toLowerCase() !=
          "Any Time".toLowerCase()) {
        var breakStartTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${detail.checkinBreak![i].startTime!.replaceAll("PM", "").replaceAll("AM", "")}";
        var breakEndTimeString =
            "${detail.checkInTime!.substring(0, 10)} ${DateFunctions.stringToDateAddMintues(detail.checkinBreak![i].startTime!, int.parse(detail.checkinBreak![i].interval!.substring(0, 2)))}";

        var breakStartTimeDate =
            DateFunctions.getDateTimeFromString(breakStartTimeString);
        var checkInDate =
            DateFunctions.getDateTimeFromString(detail.checkInTime!);
        var checkOutDate = DateFunctions.getDateTimeFromString(
            detail.checkOutTime ??
                DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now()));
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
          (detail.checkOutTime == null || detail.checkOutTime!.trim().isEmpty)
              ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now())
              : detail.checkOutTime!);

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
      var checkOutString = detail.checkOutTime ??
          DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now());
      projectWorkingHourList.add(ProjectWorkingHourDetail(
          startTime: checkInString,
          endTime: checkOutString,
          timeInterval: 1,
          type: 1));
    }
    return projectWorkingHourList;
  }

  static String calculateTotalHourTime(
      String checkInTime, String checkoutTime) {
    var checkIntDateTime = DateFunctions.getDateTimeFromString(checkInTime);
    var checkOutTime = DateFunctions.getDateTimeFromString(checkoutTime);
    var timeInMinutes = checkOutTime.difference(checkIntDateTime).inMinutes;
    var totalSpendTime = DateFunctions.minutesToHourString(timeInMinutes);
    return totalSpendTime;
  }

  String getToTalHours() {
    var totalMinutes = 0;
    if(projectDetailCrewResponse!=null){
      for (var element in projectDetailCrewResponse!.projectData!.checkins!) {
        var startTime = DateFunctions.getDateTimeFromString(element.checkInTime!);
        var endTime = DateFunctions.getDateTimeFromString(
            (element.checkOutTime == null || element.checkOutTime!.trim().isEmpty)
                ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now())
                : element.checkOutTime!);
        var minutes = endTime.difference(startTime).inMinutes;
        totalMinutes = totalMinutes + minutes;
      }
    }

    var totalHours = DateFunctions.minutesToHourString(totalMinutes);
    return totalHours;
  }

}
