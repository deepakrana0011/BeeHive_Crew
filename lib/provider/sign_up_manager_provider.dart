// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/continue_with_phone_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class SignUpManagerProvider extends BaseProvider {
  bool nameContentPadding = false;
  bool passwordContentPadding = false;
  bool passwordVisible = false;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  Future signUp(BuildContext context, String email) async {
    setState(ViewState.busy);
    try {
      var model = await api.signUp(
          context, nameController.text, email, passwordController.text);
      if (model.success == true) {
        setState(ViewState.idle);
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model.token!);
        Navigator.pushNamed(context, RouteConstants.continueWithPhoneManager,
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
