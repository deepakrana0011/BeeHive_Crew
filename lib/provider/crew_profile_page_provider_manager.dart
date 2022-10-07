import 'dart:io';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CrewProfilePageProviderManager extends BaseProvider{
  String rateSetByManager = "20.00";


  Future<bool> removingCrewOnThisProject(BuildContext context, String crewId, String projectId) async {
    setState(ViewState.busy);
    try {
      var model = await api.removingCrewOnThisProject(context, crewId, projectId);
       if(model == true){
         Navigator.of(context).pop();
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