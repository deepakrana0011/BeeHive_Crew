import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class AddCrewPageManagerProvider extends BaseProvider{
  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share("Beehive Network",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }





  Future getCrewList(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await api.getCrewList(context);
      if (model.success == true) {
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