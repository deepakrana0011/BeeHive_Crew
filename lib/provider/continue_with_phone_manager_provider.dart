// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ContinueWithPhoneManagerProvider extends BaseProvider {
  final phoneNumberController = TextEditingController();

  String dialCode = "";

  getDialCode(String code) {
    dialCode = code;
    notifyListeners();
  }

  Future sendOtpSignupPhoneManager(
    BuildContext context,
    bool? isResetPassword,
  ) async {
    try {
      setState(ViewState.busy);
      var model = await api.sendOtpSignupPhoneManager(
          context, dialCode, phoneNumberController.text);
      if (model.success == true) {
        setState(ViewState.idle);
        var value = "$dialCode-${phoneNumberController.text}";
        Navigator.pushNamed(context, RouteConstants.otpVerificationPageManager,
            arguments: {
              "value": value,
              "isEmailVerification": false,
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

  Future sendOtpForgotPhoneManager(
    BuildContext context,
    bool? isResetPassword,
  ) async {
    try {
      setState(ViewState.busy);
      var model = await api.sendOtpForgotPhoneManager(
          context, dialCode, phoneNumberController.text);
      if (model.success == true) {
        setState(ViewState.idle);
        var value = "$dialCode-${phoneNumberController.text}";
        print("token ${model.token!}");
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model.token!);
        print("token ${SharedPreference.prefs!.getString(SharedPreference.TOKEN)}");
        Navigator.pushNamed(context, RouteConstants.otpVerificationPageManager,
            arguments: {
              "value": value,
              "isEmailVerification": false,
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
}
