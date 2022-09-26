import 'dart:async';
import 'dart:io';

import 'package:beehive/helper/date_function.dart';
import 'package:beehive/model/crew_dashboard_response.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/model/project_detail_manager_response.dart';
import 'package:beehive/model/project_working_hour_detail.dart';
import 'package:beehive/model/weekely_data_model_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/image_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ProjectDetailsManagerProvider extends BaseProvider {
  Completer<GoogleMapController> controller = Completer();
  GoogleMapController? googleMapController;
  bool checkedInNoProjects = false;
  String? projectId;
  TabController? tabController;
  int selectedIndex = 0;
  List<Marker> markers = [];
  double lat = 0.0;
  double long = 0.0;
  BitmapDescriptor? pinLocationIconUser;

  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;

  ProjectDetailResponseManager? projectDetailResponse;
  List<WeekelyDataModelManager> weeklyData = [];

  void setCustomMapPinUser() async {
    pinLocationIconUser = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), ImageConstants.locationMark);
    notifyListeners();
  }

  final CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.7333, 76.7794),
      tilt: 20,
      zoom: 10);

  Future getProjectDetail(BuildContext context) async {
    setState(ViewState.busy);
    try {
      var model =
          await api.getProjectDetail(context, projectId!, startDate!, endDate!);
      if (model.success == true) {
        projectDetailResponse = model;
        createMarker();
        if (tabController!.index != 0) {
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

  void createMarker() {
    double latitude = projectDetailResponse?.projectData?.latitude ?? 0.0;
    double longitude = projectDetailResponse?.projectData?.longitude ?? 0.0;
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

  void groupDataByDate() {
    weeklyData.clear();
    for (int k = 0;
        k < projectDetailResponse!.projectData!.checkins!.length;
        k++) {
      var selectedDate = DateFunctions.getDateTimeFromString(
          projectDetailResponse!.projectData!.checkins![k].checkInTime!);
      var dateTimeString = DateFunctions.dateFormatWithDayName(selectedDate);
      if (weeklyData.isEmpty) {
        List<CheckInProjectDetailManager> projectDetailList = [];
        projectDetailList.add(projectDetailResponse!.projectData!.checkins![k]);
        var weekelyDataObject = WeekelyDataModelManager();
        weekelyDataObject.date = dateTimeString;
        weekelyDataObject.checkInDataList = projectDetailList;
        weeklyData.add(weekelyDataObject);
      } else {
        var index =
            weeklyData.indexWhere((element) => element.date == dateTimeString);
        if (index == -1) {
          List<CheckInProjectDetailManager> projectDetailList = [];
          projectDetailList
              .add(projectDetailResponse!.projectData!.checkins![k]);
          var weekelyDataObject = WeekelyDataModelManager();
          weekelyDataObject.date = dateTimeString;
          weekelyDataObject.checkInDataList = projectDetailList;
          weeklyData.add(weekelyDataObject);
        } else {
          weeklyData[index]
              .checkInDataList!
              .add(projectDetailResponse!.projectData!.checkins![k]);
        }
      }
    }
  }

  List<ProjectWorkingHourDetail> getTimeForStepper(
      CheckInProjectDetailManager detail) {
    List<Interruption> timeString = [];
    List<ProjectWorkingHourDetail> projectWorkingHourList = [];
    for (int i = 0; i < detail.checkinBreak!.length; i++) {
      if (detail.checkinBreak![i].interval != "Any") {
        var breakStartTimeString = detail.checkInTime!.substring(0, 10) +
            " " +
            detail.checkinBreak![i].startTime!
                .replaceAll("PM", "")
                .replaceAll("AM", "");
        var breakEndTimeString = detail.checkInTime!.substring(0, 10) +
            " " +
            DateFunctions.stringToDateAddMintues(
                detail.checkinBreak![i].startTime!,
                int.parse(detail.checkinBreak![i].interval!.substring(0, 2)));

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
