import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/dashboard_manager_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class DashBoardPageManagerProvider extends BaseProvider{

  TabController? controller;
  bool checkedInNoProjects = false;

  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;
  bool noProject = false;
  updateNoProject(){
    noProject = !noProject;
    notifyListeners();
  }
  DashBoardResponseManager? responseManager;
List<String> projectNameInitials =[];


getInitials({required String string,required int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0 ; i < (split.length > 1? limitTo:split.length); i ++) {
      buffer.write(split[i][0]);
    }
      projectNameInitials.add(buffer.toString());
  }




  Future dashBoardApi(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await api.dashBoardApi(context,);
      if (model.success == true) {
        responseManager = model;
        customClass.logo = model.manager!.companyLogo ?? '';
        customClass.name = model.manager!.name?? '';
        customClass.progile = model.manager!.profileImage?? '';
        SharedPreference.prefs!.setString(SharedPreference.USER_LOGO, customClass.logo.toString());
        SharedPreference.prefs!.setString(SharedPreference.USER_NAME, customClass.name.toString());
        SharedPreference.prefs!.setString(SharedPreference.USER_PROFILE, customClass.progile.toString());


          for (int i = 0; i < model.crewOnProject!.length; i++) {
            if (model.crewOnProject![i].projectId!.projectName!= '') {
              getInitials(
                  string: model.crewOnProject![i].projectId!.projectName!,
                  limitTo: 1);
            } else {
              getInitials(string: "No Project", limitTo: 2);
            }
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










}