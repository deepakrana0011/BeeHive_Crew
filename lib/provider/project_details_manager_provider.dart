import 'dart:async';
import 'dart:io';

import 'package:beehive/model/project_detail_response.dart';
import 'package:beehive/model/project_details_response_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/image_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ProjectDetailsManagerProvider extends BaseProvider {
  Completer<GoogleMapController> controller = Completer();
  bool checkedInNoProjects = false;
  TabController? tabController;
  int selectedIndex = 0;
  List<Marker> markers = [];
  double lat = 0.0;
  double long = 0.0;
  BitmapDescriptor? pinLocationIconUser;

  ProjectDetailResponseManager? projectDetailResponse;

  void setCustomMapPinUser() async {
    pinLocationIconUser = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), ImageConstants.locationMark);
    notifyListeners();
  }

  final CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.7333, 76.7794),
      tilt: 20,
      zoom: 10);

  onMapCreated() {
    markers.add(Marker(
      markerId: const MarkerId("ID1"),
      position: const LatLng(30.7046, 76.7179),
      icon: pinLocationIconUser!,
      flat: true,
      anchor: const Offset(0.5, 0.5),
    ));
    customNotify();
  }

  Future getProjectDetail(BuildContext context, String projectId) async {
    setState(ViewState.busy);
    try {
      var model = await api.getProjectDetail(context, projectId);
      if (model.success == true) {
        projectDetailResponse = model;
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
