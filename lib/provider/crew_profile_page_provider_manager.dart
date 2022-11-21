import 'dart:io';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../model/timesheet_crew_details.dart';

class CrewProfilePageProviderManager extends BaseProvider {
  bool _priceUpdateLoader = false;

  bool get priceUpdateLoader => _priceUpdateLoader;

  set priceUpdateLoader(bool value) {
    _priceUpdateLoader = value;
    notifyListeners();
  }

  String rateSetByManager = "20.00";
  TimesheetCrewDetails? crewDetails;

  Future<bool> getCrewDetails(BuildContext context, String crewId) async {
    setState(ViewState.busy);
    try {
      var model = await api.getTimeSheetCrewDetails(context, crewId);
      if (model.success!) {
        crewDetails = model;
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

  Future<bool> removingCrewOnThisProject(
      BuildContext context, String crewId, String projectId) async {
    setState(ViewState.busy);
    try {
      var model =
          await api.removingCrewOnThisProject(context, crewId, projectId);
      if (model == true) {
        Navigator.of(context).pop(true);
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

  Future<void> updateCrewRate(
      BuildContext context, String? crewId, String? price) async {
    priceUpdateLoader = true;
    try {
      var model = await api.updateCrewRate(context, crewId!, price);

      if (model.sucess!) {
        crewDetails!.data![0].projectRate = price;
      } else {
        DialogHelper.showMessage(context, model.message ?? '');
      }
      priceUpdateLoader = false;
    } on FetchDataException catch (e) {
      priceUpdateLoader = false;
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      priceUpdateLoader = false;
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }
}
