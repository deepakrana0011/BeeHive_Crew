import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../view/light_theme_signup_login/reset_password_screen.dart';

class OtpPageProvider extends BaseProvider{
  String otp= "";

  updateProvider(String value){
    otp = value;
    notifyListeners();

  }
  Future otpVerificationCrewPhone(BuildContext context, String phoneNumber,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.verifyOtpCrewPhone(context,phoneNumber,otp );
      if (model.success == true) {
        setState(ViewState.idle);
          Navigator.pushNamedAndRemoveUntil(context, RouteConstants.loginScreen, (route) => false);
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
  Future verifyEmailForOtp(BuildContext context, String email,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.verifyEmailForOtp(context,email ,otp);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.loginScreen, );
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

  Future verifyEmailForOtpResetPassword(BuildContext context, String email,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.verifyEmailForResetPassword(context,email ,otp);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.resetPasswordScreen,arguments: ResetPasswordScreen(email: email, byPhoneOrEmail: false,),);
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

  Future verifyingOtpByPhone(BuildContext context, String phoneNumber,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.verifyingOtpByPhone(context,phoneNumber, otp);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.resetPasswordScreen,arguments: ResetPasswordScreen(email: phoneNumber, byPhoneOrEmail: true,));
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