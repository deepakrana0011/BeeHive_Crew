// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../view/light_theme_signup_login/reset_password_screen.dart';

class OtpPageProvider extends BaseProvider {
  final textEditController = TextEditingController();
  String otp = "";

  getOtp(String value) {
    otp = value;
    notifyListeners();
  }

  Future verifyOtpEmailCrew(
    BuildContext context,
    String email,
    bool isResetPassword,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.verifyOtpEmailCrew(context, email, otp);
      setState(ViewState.idle);
      if (model.success == true) {
        Navigator.pushNamed(context, RouteConstants.resetPasswordScreen,
            arguments: SharedPreference.prefs!.getString(SharedPreference.TOKEN)!);
      } else {
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

  Future verifyOtpSignupPhoneCrew(
      BuildContext context, String phoneNumber, bool isResetPassword) async {
    setState(ViewState.busy);
    try {
      var phoneNumberNew =
      phoneNumber.substring(phoneNumber.indexOf("-") + 1, phoneNumber.length);
      var countryCode = phoneNumber.substring(0, phoneNumber.indexOf("-"));
      var model = await api.verifyOtpSignupPhoneCrew(context, phoneNumberNew, otp,countryCode);
      setState(ViewState.idle);
      if (model.success == true) {
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model!.token!);
        SharedPreference.prefs!.setBool(SharedPreference.isLogin, true);
        SharedPreference.prefs!.setInt(SharedPreference.loginType, 1);
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteConstants.bottomNavigationBar,
              (route) => false,
        );
      } else {
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

  Future verifyOtpForgotPhoneCrew(
      BuildContext context, String phoneNumber, bool isResetPassword) async {
    setState(ViewState.busy);
    try {
      var phoneNumberNew = phoneNumber.substring(
          phoneNumber.indexOf("-") + 1, phoneNumber.length);
      var countryCode = phoneNumber.substring(0, phoneNumber.indexOf("-"));
      var model = await api.verifyOtpForgotPhoneCrew(context, phoneNumberNew, otp,countryCode);
      setState(ViewState.idle);
      if (model.success == true) {
        var token = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
        Navigator.pushNamed(context, RouteConstants.resetPasswordScreen,
            arguments: token);
      } else {
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

  Future resendOtpApiPhone(BuildContext context, String phoneNumber) async {
    setState(ViewState.busy);
    try {
      var phoneNumberNew =
      phoneNumber.substring(phoneNumber.indexOf("-") + 1, phoneNumber.length);
      var countryCode = phoneNumber.substring(0, phoneNumber.indexOf("-"));
      var model = await api.resendOtpByPhoneApi(context, phoneNumberNew,countryCode);
      if (model.success == true) {
        setState(ViewState.idle);
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

  Future resendOtpApiEmail(BuildContext context, String email) async {
    setState(ViewState.busy);
    try {
      var model = await api.resendOtpEmailApi(context, email);
      if (model.success == true) {
        setState(ViewState.idle);
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
