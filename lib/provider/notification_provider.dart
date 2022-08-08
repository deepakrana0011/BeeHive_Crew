import 'dart:async';

import 'package:beehive/provider/base_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NotificationProvider extends BaseProvider{

  Completer<GoogleMapController> controller = Completer();

  final CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.7333, 76.7794),
      tilt: 20,
      zoom:10);
bool checkValue = false;
updateCheckValue(bool checkValueGet){
  checkValue = checkValueGet;
  notifyListeners();

}







}