import 'dart:io';
import 'dart:math';

import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/all_projects_manager_response.dart';
import 'package:beehive/model/crew_on_this_project_response.dart';
import 'package:beehive/model/project_schduele_manager_crew.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProjectsManagerProvider extends BaseProvider {
  AllProjectsManagerResponse? allProjectsManagerResponse;
  String? totalHours = "0.0";
  ProjectScheduleManagerCrew? projectScheduleManager;
  List<Data> projectNameList = [];

  DateTime? selectedStartDate = DateTime.now().subtract(Duration(days: 6));
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;

  List<int> dates = [];
  List<int> dates2 = [20, 21, 22, 23, 24, 25, 26];
  List<String> days = [];
  List<String> daysUpperCase = [];
  List<String> weekDays = ["M", "Tu", "W", "Th", "F", "Sa", "Su"];
  List<String> days2 = [
    "MS",
    "MS",
  ];
  List<String> days3 = [
    "MS",
  ];
  List<String> name = [
    "AL",
    "AL",
    "KH",
    "AL",
    "MS",
    "KH",
  ];
  List<Color> colors = [
    ColorConstants.schedule1,
    ColorConstants.schedule2,
    ColorConstants.schedule3,
    ColorConstants.schedule4,
    ColorConstants.schedule5,
    ColorConstants.schedule6,
  ];
  List<Color> colors2 = [
    ColorConstants.schedule5,
    ColorConstants.schedule6,
  ];
  List<Color> colors3 = [
    ColorConstants.green6FCF97,
  ];

  Future getAllManagerProject(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      allProjectsManagerResponse = await api.getAllProjectsManager(context);
      getTotalHours();
      setState(ViewState.idle);
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void getTotalHours() {

    int totalMinutes = 0;
    for (var element in allProjectsManagerResponse!.projectData!) {
      element.checkins?.forEach((checkIn) {
        var startTime =
        DateFunctions.getDateTimeFromString(checkIn.checkInTime!);
        var endTime = DateFunctions.getDateTimeFromString(
            (checkIn.checkOutTime==null || checkIn.checkOutTime!.trim().isEmpty) ?
                DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now()):checkIn.checkOutTime!);
        var minutes = endTime.difference(startTime).inMinutes;
        totalMinutes = totalMinutes + minutes;
      });
    }
    totalHours = DateFunctions.minutesToHourString(totalMinutes);
  }

  String getTotalHoursPerProject(ProjectDatum? projectDetail) {
    int totalMinutes = 0;
    projectDetail?.checkins?.forEach((checkIn) {
      var startTime =
      DateFunctions.getDateTimeFromString(checkIn.checkInTime!);
      var endTime = DateFunctions.getDateTimeFromString(
          (checkIn.checkOutTime==null || checkIn.checkOutTime!.trim().isEmpty)?
              DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now()):checkIn.checkOutTime!);
      var minutes = endTime.difference(startTime).inMinutes;
      totalMinutes = totalMinutes + minutes;
    });
    return DateFunctions.minutesToHourString(totalMinutes);
  }


  List<String> projectNames = [];
  List<String> ids = [];
  List<Color> projectColors = [];

  Future getProjectSchedulesManager(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      projectScheduleManager = await api.getProjectSchedulesManagerCrew(context,
          (ApiConstantsManager.BASEURL + ApiConstantsManager.managerProjectSchedule));
      if(projectScheduleManager != null){
        projectNameList = projectScheduleManager!.data;

        for(var element in projectNameList){
          for(int i = 0 ; i < element.projectName.length ; i++){
            ids.add(element.projectName[i].sId.toString());
          }
        }

        // for(var element in projectNameList) {
        //   element.projectName.any((ele) {
        //     for(int i = 0 ; i < ids.toSet().toList().length ; i++) {
        //       if(ele.sId == ids.toSet().toList()[i]){
        //         ele.color = colors2[i];
        //         print(ele.color);
        //       }
        //      // return false;
        //     }
        //     return false;
        //   });
        // }

        /// for colors
          for(int i = 0 ; i < ids.toSet().toList().length ; i++) {
            projectColors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
            for(var element in projectNameList) {
            element.projectName.any((ele) {
              if(ele.sId == ids.toSet().toList()[i]){
                ele.color = projectColors[i];
              }
              return false;
            });
          }
        }

        /// for project name
        List<String> idss = ids.toSet().toList();
        for(var element in projectNameList){
          for(var projectElement in element.projectName){
            for(var idElement in idss){
              if(idElement == projectElement.sId){
                projectNames.add(projectElement.projectName.toString());
                idss.remove(idElement);
                break;
              }
            }
          }}


      } else{
        projectNameList = [];
      }
      print(projectNames);
      setState(ViewState.idle);
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      projectNameList = [];
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      projectNameList = [];
      DialogHelper.showMessage(context, "internet_connection".tr());
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
    dates = [];
    days = [];
    if(selectedStartDate!.month < selectedEndDate!.month){
      // Find the last day of the month.
      var lastDayDateTime = (selectedStartDate!.month < 12) ?
      DateTime(selectedStartDate!.year, selectedStartDate!.month + 1, 0) : DateTime(selectedStartDate!.year + 1, 1, 0);

      for(int i = selectedStartDate!.day ; i <= lastDayDateTime.day; i++){
        dates.add(i);
      }

      for(int i = 1 ; i <= selectedEndDate!.day; i++){
        dates.add(i);
      }
    } else{
      for(int i = selectedStartDate!.day ; i <= selectedEndDate!.day; i++){
        dates.add(i);
      }
    }

    days = gettingWeekDays(selectedStartDate!.weekday);
   // print(days);
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
    dates = [];
    days = [];
    if(selectedStartDate!.month < selectedEndDate!.month){
      // Find the last day of the month.
      var lastDayDateTime = (selectedStartDate!.month < 12) ?
      DateTime(selectedStartDate!.year, selectedStartDate!.month + 1, 0) : DateTime(selectedStartDate!.year + 1, 1, 0);

      for(int i = selectedStartDate!.day ; i <= lastDayDateTime.day; i++){
        dates.add(i);
      }

      for(int i = 1 ; i <= selectedEndDate!.day; i++){
        dates.add(i);
      }
    } else{
      for(int i = selectedStartDate!.day ; i <= selectedEndDate!.day; i++){
        dates.add(i);
      }
    }

    days = gettingWeekDays(selectedStartDate!.weekday);
    customNotify();
  }

  void weekTabBar(){
    weekFirstDate = DateFunctions.getMonthDay(selectedStartDate!);
    weekEndDate = DateFunctions.getMonthDay(selectedEndDate!);

    startDate = DateFormat("yyyy-MM-dd").format(selectedStartDate!);
    endDate = DateFormat("yyyy-MM-dd").format(selectedEndDate!);

    dates = [];
    days = [];
    for(int i = selectedStartDate!.day ; i <= selectedEndDate!.day; i++){
      dates.add(i);
    }
    days = gettingWeekDays(selectedStartDate!.weekday);

    customNotify();
  }

 List<String> gettingWeekDays(int startWeeKDay){
    switch(startWeeKDay){
      case 1:
        daysUpperCase = ["M", "TU", "W", "TH", "F", "SA", "SU"];
        return ["Tu", "W", "Th", "F", "Sa", "Su", "M"];
      case 2:
        daysUpperCase = ["TU", "W", "TH", "F", "SA", "SU", "M"];
        return ["Tu", "W", "Th", "F", "Sa", "Su", "M"];
      case 3:
        daysUpperCase = [ "W", "TH", "F", "SA", "SU", "M", "TU"];
        return ["W", "Th", "F", "Sa", "Su", "M", "Tu"];
      case 4:
        daysUpperCase = ["TH", "F", "SA", "SU", "M", "TU", "W"];
        return ["Th", "F", "Sa", "Su", "M", "Tu", "W"];
      case 5:
        daysUpperCase = ["F", "SA", "SU", "M", "TU", "W", "TH"];
        return ["F", "Sa", "Su", "M", "Tu", "W", "Th"];
      case 6:
        daysUpperCase = ["SA", "SU", "M", "TU", "W", "TH", "F"];
        return ["Sa", "Su", "M", "Tu", "W", "Th", "F"];
      case 7:
        daysUpperCase = ["SU", "M", "TU", "W", "TH", "F", "SA"];
        return ["Su", "M", "Tu", "W", "Th", "F", "Sa"];
      default:
        daysUpperCase = ["M", "TU", "W", "TH", "F", "SA", "SU"];
        return ["M", "Tu", "W", "Th", "F", "Sa", "Su"];
    }
  }

  /// crew on this project~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  ProjectData? projectData;

  Future<bool> crewOnThisProject(BuildContext context, String id) async {
    setState(ViewState.busy);
    try {
     var model = await api.crewOnThisProject(context, id);
     if(model.projectData != null){
       projectData = model.projectData;
     }
      setState(ViewState.idle);
     return true;
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
      return false;
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
      return false;
    }
  }
}
