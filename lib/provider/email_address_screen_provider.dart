import 'dart:io';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../view/ light_theme_signup_login/otp_verification_page.dart';

class EmailAddressScreenProvider extends BaseProvider{


  Future emailVerifcationCrew(BuildContext context, String email) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.verifyCrewEmail(context,email );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.otpVerificationPage,arguments: OtpVerificationPage(phoneNumber: email, continueWithPhoneOrEmail: false, routeForResetPassword: 2,));
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
      var model = await apiCrew.getOtpForPasswordResetCrew(context,email );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.otpVerificationPage,arguments: OtpVerificationPage(phoneNumber: email, continueWithPhoneOrEmail: false, routeForResetPassword: 3,));
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