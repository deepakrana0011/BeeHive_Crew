import 'dart:io';

import 'package:beehive/model/dashboard_manager_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class DashBoardPageManagerProvider extends BaseProvider{


  bool checkedInNoProjects = false;

  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;
  bool noProject = false;
  updateNoProject(){
    noProject = !noProject;
    notifyListeners();
  }
  DashBoardResponseManager? responseManager;


  Future dashBoardApi(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await api.dashBoardApi(context,);
      if (model.success == true) {
        responseManager = model;
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