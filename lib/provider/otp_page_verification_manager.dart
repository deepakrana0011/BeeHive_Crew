// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/bottom_bar_manager/bottom_navigation_bar_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/reset_password_screen_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../view/light_theme_signup_login/reset_password_screen.dart';

class OtpPageProviderManager extends BaseProvider {
  final textEditController = TextEditingController();

  String otp = "";

  getOtp(String value) {
    otp = value;
    notifyListeners();
  }

  Future verifyOtpSignupPhoneManager(
      BuildContext context, String phoneNumber, bool isResetPassword) async {
    setState(ViewState.busy);
    var phoneNumberNew =
        phoneNumber.substring(phoneNumber.indexOf("-") + 1, phoneNumber.length);
    var countryCode = phoneNumber.substring(0, phoneNumber.indexOf("-"));
    try {
      var model = await api.verifyOtpSignupPhoneManager(
          context, phoneNumberNew, otp, countryCode);
      setState(ViewState.idle);
      if (model.success == true) {
        SharedPreference.prefs!
            .setString(SharedPreference.TOKEN, model.token!);
        SharedPreference.prefs!
            .setString(SharedPreference.USER_ID, model.data!.id!);
        SharedPreference.prefs!.setInt(SharedPreference.loginType, 2);
        SharedPreference.prefs!.setBool(SharedPreference.isLogin, true);
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.bottomBarManager, (route) => false,
            arguments: BottomBarManager(
              pageIndex: 0,
              fromBottomNav: 1,
            ));
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

  Future verifyOtpForgotPhoneManager(
      BuildContext context, String phoneNumber, bool isResetPassword) async {
    setState(ViewState.busy);
    try {
      var phoneNumberNew = phoneNumber.substring(
          phoneNumber.indexOf("-") + 1, phoneNumber.length);
      var countryCode = phoneNumber.substring(0, phoneNumber.indexOf("-"));
      var model = await api.verifyOtpForgotPhoneManager(
          context, phoneNumberNew, otp, countryCode);
      setState(ViewState.idle);
      if (model.success == true) {
        var token = SharedPreference.prefs!.getString(SharedPreference.TOKEN);
        print(token);
        Navigator.pushNamed(context, RouteConstants.resetPasswordScreenManager, arguments: token);
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

  Future verifyOtpEmailManager(
    BuildContext context,
    String email,
    bool isResetPassword,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.verifyOtpEmailManager(context, email, otp);
      setState(ViewState.idle);
      if (model.success == true) {
        Navigator.pushNamed(context, RouteConstants.resetPasswordScreenManager,
            arguments:
                SharedPreference.prefs!.getString(SharedPreference.TOKEN)!);
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

  Future resendOtpApiEmail(
    BuildContext context,
    String email,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.resendOtpApiEmail(
        context,
        email,
      );
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

  Future resendOtpApiPhone(
    BuildContext context,
    String phoneNumber,
  ) async {
    setState(ViewState.busy);
    try {
      var phoneNumberNew=phoneNumber.substring(phoneNumber.indexOf("-") + 1, phoneNumber.length);
      var countryCode = phoneNumber.substring(0, phoneNumber.indexOf("-"));
      var model = await api.resendOtpByPhoneApiManager(context, phoneNumberNew,countryCode);
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
    } on SocketException {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }
}
