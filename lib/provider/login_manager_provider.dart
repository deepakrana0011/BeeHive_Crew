// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../helper/shared_prefs.dart';
import '../services/fetch_data_expection.dart';
import '../views_manager/bottom_bar_manager/bottom_navigation_bar_manager.dart';

class LoginManagerProvider extends BaseProvider {
  bool emailContentPadding = false;
  bool passwordContentPadding = false;
  bool passwordVisible = false;

  Future loginManager(
      BuildContext context, String email, String password) async {
    setState(ViewState.busy);
    try {
      var model = await api.loginManager(context, email, password);
      if (model.success == true) {
        setState(ViewState.idle);
        SharedPreference.prefs!.setString(SharedPreference.TOKEN, model.token!);
        if (model.data!.status == 1) {
          SharedPreference.prefs!
              .setString(SharedPreference.USER_ID, model.data!.sId!);
          SharedPreference.prefs!.setInt(SharedPreference.loginType, 2);
          SharedPreference.prefs!.setBool(SharedPreference.isLogin, true);

          Navigator.of(context).pushNamedAndRemoveUntil(
              RouteConstants.bottomBarManager, (route) => false,
              arguments: BottomBarManager(fromBottomNav: 1, pageIndex: 0));
        } else {
          Navigator.pushNamed(context, RouteConstants.continueWithPhoneManager,
              arguments: false);
        }
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
