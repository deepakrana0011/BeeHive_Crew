import 'dart:io';

import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/all_projects_manager_response.dart';
import 'package:beehive/model/project_schduele_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProjectsManagerProvider extends BaseProvider {
  AllProjectsManagerResponse? allProjectsManagerResponse;
  String? totalHours = "0.0";
  ProjectScheduleManager? projectScheduleManager;
  List<Data> projectNameList = [];

  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;

  List<int> dates = [];
  List<int> dates2 = [20, 21, 22, 23, 24, 25, 26];
  List<String> days = ["M", "Tu", "W", "Th", "F", "Sa", "Su"];
  List<String> daysUpperCase = ["M", "TU", "W", "TH", "F", "SA", "SU"];
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
    ColorConstants.schedule5,
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
    int value = 0;
    allProjectsManagerResponse!.projectData!.forEach((element) {
      value = value + element.totalHours!;
    });
    totalHours = DateFunctions.minutesToHourString(value);
  }

  Future getProjectSchedulesManager(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      projectScheduleManager = await api.getProjectSchedulesManager(context);
      if(projectScheduleManager != null){
        projectNameList = projectScheduleManager!.data;
      } else{
        projectNameList = [];
      }
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
    for(int i = selectedStartDate!.day ; i <= selectedEndDate!.day; i++){
      dates.add(i);
    }
    notifyListeners();
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
    for(int i = selectedStartDate!.day ; i <= selectedEndDate!.day; i++){
      dates.add(i);
    }
    notifyListeners();
    customNotify();
  }
}
