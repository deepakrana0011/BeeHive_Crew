import 'dart:io';

import 'package:beehive/model/get_crew_profile_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../helper/shared_prefs.dart';
import '../services/fetch_data_expection.dart';

class ProfilePageProvider extends BaseProvider{

  GetCrewProfileResponse? getObj;

  Future getCrewProfile(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await api.getCrewProfile(context);
      if (model.success == true) {
        SharedPreference.prefs!.setString(SharedPreference.USER_PROFILE, model.data!.profileImage??'');
        SharedPreference.prefs!.setString(SharedPreference.USER_NAME, model.data!.name!);
        getObj = model;
        setState(ViewState.idle);
      } else {
        setState(ViewState.idle);
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