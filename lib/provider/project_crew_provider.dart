import 'dart:io';

import 'package:beehive/Constants/color_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/all_checkout_projects_crew.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProjectsCrewProvider extends BaseProvider {
  AllCheckoutProjectCrewResponse? allCheckoutProjectCrewResponse;
  String? totalHours = "0";
  List<int> dates = [13, 14, 15, 16, 17, 18, 19];
  List<int> dates2 = [20, 21, 22, 23, 24, 25, 26];
  List<String> days = ["M", "Tu", "W", "Th", "F", "Sa", "Su"];
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

  Future getAllCheckoutProjectsCrew(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      allCheckoutProjectCrewResponse = await api.getAllCheckoutOutCrewProjects(context);
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
    allCheckoutProjectCrewResponse!.projectData!.forEach((element) {
      value = value + element.totalHours!;
    });
    totalHours =DateFunctions.minutesToHourString(value);
  }

}
