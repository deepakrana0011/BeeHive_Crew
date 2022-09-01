import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ContinueWithPhoneManagerProvider extends BaseProvider{
final phoneNumberController = TextEditingController();

String dialCode = "";
getDialCode(String code){
  dialCode = code;
  notifyListeners();

}
Future phoneVerification(BuildContext context,) async {
  setState(ViewState.busy);
  try {
    var model = await api.phoneNumberVerification(context,dialCode,phoneNumberController.text );
    if (model.success == true) {
      setState(ViewState.idle);
      Navigator.pushNamed(context, RouteConstants.otpVerificationPageManager,arguments: OtpVerificationPageManager(phoneNumber: phoneNumberController.text, continueWithPhoneOrEmail: true, resetPasswordWithEmail: 1,));
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



Future resetPasswordByPhone(BuildContext context,) async {
  setState(ViewState.busy);
  try {
    var model = await api.resetPasswordByPhone(context,phoneNumberController.text );
    if (model.success == true) {
      setState(ViewState.idle);
      Navigator.pushNamed(context, RouteConstants.otpVerificationPageManager,arguments: OtpVerificationPageManager(phoneNumber: phoneNumberController.text, continueWithPhoneOrEmail: true, resetPasswordWithEmail: 4));
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