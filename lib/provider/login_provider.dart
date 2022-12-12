// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/view/%20light_theme_signup_login/continue_with_phone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../helper/shared_prefs.dart';
import '../services/fetch_data_expection.dart';

class LoginProvider extends BaseProvider {
  bool emailContentPadding = false;
  bool passwordContentPadding = false;
  bool passwordVisible = false;

  Future loginCrew(BuildContext context, String email, String password,String? deviceToken) async {
    setState(ViewState.busy);
    try {
      var model = await api.loginCrew(context, email, password,deviceToken);
      setState(ViewState.idle);
      if (model.success == true) {
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model.token!);
        if (model.data!.status == 1) {
          SharedPreference.prefs!.setString(SharedPreference.USER_ID, model.data!.sId!);
          SharedPreference.prefs!.setInt(SharedPreference.loginType, 1);
          SharedPreference.prefs!.setBool(SharedPreference.isLogin, true);
          Navigator.pushNamedAndRemoveUntil(
              context, RouteConstants.bottomNavigationBar, (route) => false);
        } else {
          Navigator.pushNamed(context, RouteConstants.continueWithPhone,
              arguments: false);
        }

        /* setState(ViewState.idle);
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model.token!);
        SharedPreference.prefs!.setString(SharedPreference.USER_ID, model.data!.sId!);
        SharedPreference.prefs!.setString(SharedPreference.Crew_NAME, model.data!.name!);
        if(model.data!.status == 0){
          SharedPreference.prefs!.setBool(SharedPreference.IS_LOGIN , true);
          SharedPreference.prefs!.setBool(SharedPreference.ISCREW_LOGIN , true);

        }else{
          Navigator.pushNamedAndRemoveUntil(context, RouteConstants.bottomNavigationBar, (route) => false);
        }
        DialogHelper.showMessage(context, model.message!);*/
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
