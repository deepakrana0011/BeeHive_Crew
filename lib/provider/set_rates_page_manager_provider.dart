import 'dart:io';

import 'package:beehive/model/get_assinged_crew_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../views_manager/projects_manager/project_setting_page_manager.dart';

class SetRatesPageManageProvider extends BaseProvider{
  final  singleRateController = TextEditingController();

  GetAssignedCrewInProject? assignedCrewInProject;
  List<CrewId> crewList = [];

  bool status = false;
  void updateSwitcherStatus(bool value,) {
    status = value;
    notifyListeners();
  }

  clearControllers(List<TextEditingController> controllers){
    singleRateController.text = "";
    controllers;
    notifyListeners();
  }



  Future getAssignedProject(BuildContext context,String projectId) async {
    setState(ViewState.busy);
    try {
      var model = await api.getAssignedVCrewInProject(context,projectId);
      if (model.success == true) {
        assignedCrewInProject = model;
        crewList.clear();
        crewList = model.data!.crewId!;
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
  Future setRateForCrew(BuildContext context, String projectId, List<TextEditingController> rateList,String sameRate,) async {
    setState(ViewState.busy);
    try {
      var model = await api.setProjectRate(context,crewList,projectId,rateList,sameRate,status);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.projectSettingsPageManager,arguments: ProjectSettingsPageManager(fromProjectOrCreateProject: true, projectId: projectId,));
        DialogHelper.showMessage(context, model.message!);
      } else {
        setState(ViewState.idle);
        DialogHelper.showMessage(context, model.message!);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }












}