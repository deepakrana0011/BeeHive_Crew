// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/view/%20light_theme_signup_login/continue_with_phone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../helper/shared_prefs.dart';
import '../services/fetch_data_expection.dart';

class SignUpProvider extends BaseProvider {
  bool nameContentPadding = false;
  bool passwordContentPadding = false;
  bool passwordVisible = false;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  Future signUpCrew(BuildContext context, String emailController, String? fcmToken) async {
    setState(ViewState.busy);
    try {
      var model = await api.signUpCrew(context, nameController.text,
          emailController, passwordController.text,fcmToken);
      SharedPreference.prefs!.setString(SharedPreference.TOKEN, model.token!);
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.continueWithPhone,
            arguments: false);
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
