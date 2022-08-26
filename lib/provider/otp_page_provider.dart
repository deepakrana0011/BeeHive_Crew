import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class OtpPageProvider extends BaseProvider{
  String otp= "";

  updateProvider(String value){
    otp = value;
    notifyListeners();

  }

  Future otpVerificationCrew(BuildContext context, String phoneNumber, bool routeForDashBordOrResetPassword) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.verifyOtpCrew(context,phoneNumber,otp );
      if (model.success == true) {
        setState(ViewState.idle);
        if(routeForDashBordOrResetPassword == false){
          Navigator.pushNamedAndRemoveUntil(context, RouteConstants.bottomNavigationBar, (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, RouteConstants.resetPasswordScreen, (route) => false);
        }
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
        Navigator.pushNamed(context, RouteConstants.bottomNavigationBar, );
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