import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../view/ light_theme_signup_login/otp_verification_page.dart';
import '../views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';

class ContinueWithPhoneProvider extends BaseProvider{
final phoneNumberController = TextEditingController();
String dialCode = "";
getDialCode(String code){
  dialCode = code;
  notifyListeners();

}


Future phoneVerificationCrew(BuildContext context, int routeForResetPassword,) async {
  setState(ViewState.busy);
  try {
    var model = await apiCrew.phoneNumberVerificationCrew(context,dialCode,phoneNumberController.text );
    if (model.success == true) {
      setState(ViewState.idle);
      Navigator.pushNamed(context, RouteConstants.otpVerificationPage,arguments: OtpVerificationPage(phoneNumber: phoneNumberController.text, continueWithPhoneOrEmail: true, routeForResetPassword: routeForResetPassword,));
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

Future resetPasswordByPhone(BuildContext context, String phoneNumber,) async {
  setState(ViewState.busy);
  try {
    var model = await apiCrew.resetPasswordByPhone(context,phoneNumber);
    if (model.success == true) {
      setState(ViewState.idle);
      Navigator.pushNamed(context, RouteConstants.otpVerificationPage,arguments: OtpVerificationPage(phoneNumber: phoneNumber, continueWithPhoneOrEmail: true, routeForResetPassword: 4));
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