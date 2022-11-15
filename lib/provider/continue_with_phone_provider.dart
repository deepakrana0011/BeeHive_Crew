// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../view/ light_theme_signup_login/otp_verification_page.dart';
import '../views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';

class ContinueWithPhoneProvider extends BaseProvider {
  final phoneNumberController = TextEditingController();
  String dialCode = "";
  String countryCode = "";

  setDialCode(PhoneNumber value) {
    dialCode = value.dialCode ?? "+1";
    countryCode = value.isoCode ?? "US";
    notifyListeners();
  }

  Future sendOtpSignupPhoneCrew(
    BuildContext context,
    bool? isResetPassword,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.sendOtpSignupPhoneCrew(
          context, dialCode, phoneNumberController.text);
      if (model.success == true) {
        setState(ViewState.idle);
        var value = "$dialCode-${phoneNumberController.text}";
        Navigator.pushNamed(context, RouteConstants.otpVerificationPage,
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

  Future sendOtpForgotPhoneCrew(
    BuildContext context,
    bool? isResetPassword,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.sendOtpForgotPhoneCrew(
          context, dialCode, phoneNumberController.text);
      if (model.success == true) {
        setState(ViewState.idle);
        var value = "$dialCode-${phoneNumberController.text}";
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model!.token!);
        Navigator.pushNamed(context, RouteConstants.otpVerificationPage,
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
