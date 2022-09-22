import 'dart:io';

import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/drawer_manager_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class DashBoardPageManagerProvider extends BaseProvider {
  TabController? controller;
  bool checkedInNoProjects = false;
  DrawerManagerProvider drawerManagerProvider =
      locator<DrawerManagerProvider>();

  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;
  bool noProject = false;

  bool isLoading = false;

  DateTime? selectedStartDate = DateTime.now();
  DateTime? selectedEndDate = DateTime.now();

  String? startDate;
  String? endDate;

  String? weekFirstDate;
  String? weekEndDate;

  updateNoProject() {
    noProject = !noProject;
    notifyListeners();
  }

  ManagerDashboardResponse? responseManager;
  List<String> projectNameInitials = [];

  getInitials({required String string, required int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0; i < (split.length > 1 ? limitTo : split.length); i++) {
      buffer.write(split[i][0]);
    }
    projectNameInitials.add(buffer.toString());
  }

  void updateLoading(bool value) {
    isLoading = value;
    customNotify();
  }

  Future dashBoardApi(BuildContext context, String startDate, String endDate,
      BottomBarManagerProvider? managerProvider,
      {showFullLoader = false}) async {
    if (showFullLoader) {
      setState(ViewState.busy);
    } else {
      updateLoading(true);
    }
    try {
      var model = await api.dashBoardApiManager(context, startDate, endDate);
      if (showFullLoader) {
        setState(ViewState.idle);
      } else {
        updateLoading(false);
      }
      if (model.success == true) {
        responseManager = model;
        managerProvider!.updateDrawerData(
            model.manager?.name ?? '',
            model.manager?.profileImage ?? '',
            model.manager?.companyLogo ?? '');
        for (int i = 0; i < model.projectData!.length; i++) {
          if (model.projectData![i]!.projectName != '') {
            getInitials(
                string: model.projectData![i]!.projectName!, limitTo: 1);
          } else {
            getInitials(string: "No Project", limitTo: 2);
          }
        }
      }
    } on FetchDataException catch (e) {
      if (showFullLoader) {
        setState(ViewState.idle);
      } else {
        updateLoading(false);
      }
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      if (showFullLoader) {
        setState(ViewState.idle);
      } else {
        updateLoading(false);
      }
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  void nextWeekDays(int numberOfDays) {
    if(selectedEndDate==null){
      selectedStartDate=DateTime.now().subtract( Duration(days: numberOfDays));
      selectedEndDate=DateTime.now();
    }else{
      selectedStartDate = selectedEndDate!.add(const Duration(days: 1));
      var newDate = selectedEndDate!.add(Duration(days: numberOfDays));
      if (newDate.isAfter(DateTime.now())) {
        selectedEndDate = DateTime.now();
      } else {
        selectedEndDate = newDate;
      }
    }
   /* var newDate = selectedEndDate!.add(Duration(days: numberOfDays));
    if (newDate.isAfter(DateTime.now())) {
      selectedEndDate = DateTime.now();
    } else {
      selectedEndDate = newDate;
    }*/
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
}
