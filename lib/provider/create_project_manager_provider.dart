import 'dart:async';

import 'package:beehive/provider/base_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateProjectManagerProvider extends BaseProvider {
  Completer<GoogleMapController> controller = Completer();

  final CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.7333, 76.7794),
      tilt: 20,
      zoom: 10);

  int initialIndex = 0;
  MapType mapType = MapType.terrain;

  double latitude = 0;
  double longitude = 0;
  addLatLongToMap(double lat, double long){
    latitude = lat;
    longitude = long;
    notifyListeners();
  }

  ///Update MapType of google Map
  updateMapStyle(int index) {
    if (index == 0) {
      mapType = MapType.terrain;
    } else {
      mapType = MapType.satellite;
    }
    initialIndex = index;
    notifyListeners();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
