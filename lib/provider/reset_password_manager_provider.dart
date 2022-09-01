import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ResetPasswordManagerProvider extends BaseProvider{



  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;
  bool newPasswordContentPadding = false;
  bool confirmPasswordContentPadding = false;

  Future resetPassword(BuildContext context,String password, String email) async {
    setState(ViewState.busy);
    try {
      var model = await api.resetPasswordManager(context,password, email);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamedAndRemoveUntil(context, RouteConstants.loginScreenManager, (route) => false);
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

  Future resetPasswordManagerByPhone(BuildContext context,
      {required String phone, required String password}) async {
    setState(ViewState.busy);
    try {
      var model = await api.resetPasswordByPhoneNumber(context, phoneNumber: phone, password: password,);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamedAndRemoveUntil(context, RouteConstants.loginScreenManager, (route) => false);
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