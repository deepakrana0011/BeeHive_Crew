import 'dart:async';
import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../model/notifications_model.dart';
import '../services/fetch_data_expection.dart';

class NotificationProvider extends BaseProvider {
  List<Notifications> notifications = [];

  Completer<GoogleMapController> controller = Completer();

  final CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.7333, 76.7794),
      tilt: 20,
      zoom: 10);
  bool checkValue = false;

  updateCheckValue(bool checkValueGet) {
    checkValue = checkValueGet;
    notifyListeners();
  }

  Future getNotifications(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    var userId = SharedPreference.prefs?.getString(SharedPreference.USER_ID);
    try {
      var model = await api.getNotifications(context, userId!);
      if (model.success == true) {
        notifications = model.data ?? [];
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
