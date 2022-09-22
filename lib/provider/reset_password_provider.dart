// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ResetPasswordProvider extends BaseProvider {
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;
  bool newPasswordContentPadding = false;
  bool confirmPasswordContentPadding = false;

  Future resetPasswordCrew(
      BuildContext context, String password,String token) async {
    setState(ViewState.busy);
    try {
      var model = await api.resetPasswordCrew(context, password,token);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.popUntil(context, (route) {
          if (route.settings.name == RouteConstants.loginScreen) {
            return true;
          } else {
            return false;
          }
        });
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
