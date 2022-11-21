// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/login_screen_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/sign_up_screen_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';

class EmailAddressScreenManagerProvider extends BaseProvider {
  Future sendOtpEmailManager(BuildContext context, String email,
      bool isVerificationProcess, bool isResetPassword) async {
    setState(ViewState.busy);
    try {
      var model = await api.sendOtpForgotEmailManager(context, email);
      setState(ViewState.idle);
      if (model.success == true) {
        SharedPreference.prefs!
            .setString(SharedPreference.TOKEN, model.token!);
        Navigator.pushNamed(context, RouteConstants.otpVerificationPageManager,
            arguments: {
              "value": email,
              "isEmailVerification": true,
              "isResetPassword": isResetPassword
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

  Future isEmailExist(BuildContext context, String email) async {
    setState(ViewState.busy);
    try {
      var status = await api.isEmailExistManager(email);
      setState(ViewState.idle);
      if (status) {
        Navigator.pushNamed(context, RouteConstants.loginScreenManager,
            arguments: email);
      } else {
        Navigator.pushNamed(context, RouteConstants.signUpScreenManager,
            arguments: email);
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
