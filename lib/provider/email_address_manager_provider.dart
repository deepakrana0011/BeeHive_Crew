import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';

class EmailAddressScreenManagerProvider extends BaseProvider{

  Future emailVerificationManager(BuildContext context, String email) async {
    setState(ViewState.busy);
    try {
      var model = await api.verifyManagerEmail(context,email );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.otpVerificationPageManager,arguments: OtpVerificationPageManager(phoneNumber: email, continueWithPhoneOrEmail: false, resetPasswordWithEmail: 2,));
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
      var model = await api.getOtpForPasswordReset(context,email );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.otpVerificationPageManager,arguments: OtpVerificationPageManager(phoneNumber: email, resetPasswordWithEmail: 3,continueWithPhoneOrEmail: false,));
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

