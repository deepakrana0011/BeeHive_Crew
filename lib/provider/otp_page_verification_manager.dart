import 'dart:io';
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


class OtpPageProviderManager extends BaseProvider{
  final textEditController = TextEditingController();

  String otp= "";
  getOtp(String value){
    otp = value;
    notifyListeners();
  }

  Future otpVerificationPhone(BuildContext context, String phoneNumber) async {
    setState(ViewState.busy);
    try {
      var model = await api.verifyOtp(context,phoneNumber,otp );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.bottomBarManager, arguments: BottomBarManager(pageIndex: 0,fromBottomNav: 1,));
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
      var model = await api.verifyEmailForOtp(context,email ,otp);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamedAndRemoveUntil(context, RouteConstants.bottomBarManager, (route) => false);
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
      var model = await api.verifyEmailForResetPassword(context,email ,otp);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamedAndRemoveUntil(context, RouteConstants.resetPasswordScreenManager,arguments: ResetPasswordScreenManager(email: email, byPhoneOrEmail: false,), (route) => true);
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
      var model = await api.verifyingOtpByPhone(context,phoneNumber, otp);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.resetPasswordScreenManager,arguments: ResetPasswordScreenManager(email: phoneNumber, byPhoneOrEmail: false,));
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

  Future resendOtpApiEmail(BuildContext context, String email,) async {
    setState(ViewState.busy);
    try {
      var model = await api.resendOtpApiEmail(context,email ,);
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
  Future resendOtpApiPhone(BuildContext context, String phoneNumber,) async {
    setState(ViewState.busy);
    try {
      var model = await api.resendOtpByPhoneApi(context,phoneNumber,);
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