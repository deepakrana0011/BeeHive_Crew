import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ChangePasswordCrewProvider extends BaseProvider{

  Future<bool> changePassword(BuildContext context, String oldPassword, String newPassword) async {
    setState(ViewState.busy);
    try {
      var model =  await api.changePassword(context, (ApiConstantsCrew.BASEURL + ApiConstantsCrew.crewNewPassword), oldPassword, newPassword);
      if(model.success == true){
        Navigator.pop(context, true);
      } else{
        DialogHelper.showMessage(context, model.message.toString());
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