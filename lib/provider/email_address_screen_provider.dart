// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../helper/shared_prefs.dart';
import '../services/fetch_data_expection.dart';
import '../view/ light_theme_signup_login/otp_verification_page.dart';

class EmailAddressScreenProvider extends BaseProvider{

  Future isEmailExist(BuildContext context, String email) async {
    setState(ViewState.busy);
    try {
      var status = await api.isEmailExistCrew(email);
      setState(ViewState.idle);
      if (status) {
        Navigator.pushNamed(context, RouteConstants.loginScreen,arguments: email);
      } else {
        Navigator.pushNamed(context, RouteConstants.signUpScreen,
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

  Future sendOtpEmailCrew(BuildContext context, String email,
      bool isVerificationProcess, bool isResetPassword) async {
    setState(ViewState.busy);
    try {
      var model = await api.sendOtpEmailCrew(context, email);
      SharedPreference.prefs!.setString(SharedPreference.TOKEN, model!.token!);
      setState(ViewState.idle);
      if (model.success == true) {
        Navigator.pushNamed(context, RouteConstants.otpVerificationPage,
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















}