 import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class SignUpManagerProvider extends BaseProvider{

  bool nameContentPadding = false;
  bool passwordContentPadding = false;
  bool passwordVisible = false;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();


  Future signUp(BuildContext context,String emailController) async {
    setState(ViewState.busy);
    try {
      var model = await api.signUp(context, nameController.text,emailController, passwordController.text);
      if (model.success == true) {
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model.token!);
        SharedPreference.prefs!.setString(SharedPreference.USER_ID, model.data!.sId!);
        setState(ViewState.idle);
         Navigator.pushNamed(context, RouteConstants.continueWithPhoneManager);
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
