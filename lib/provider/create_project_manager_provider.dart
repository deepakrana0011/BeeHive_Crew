import 'dart:async';
import 'dart:io';

import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/model/create_project_request.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/projects_manager/add_crew_page_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/image_constants.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class CreateProjectManagerProvider extends BaseProvider {
  final projectNameController = TextEditingController();
  CreateProjectRequest createProjectRequest = locator<CreateProjectRequest>();
  final Completer<GoogleMapController> _controller = Completer();
  late final GoogleMapController? mapController;
  bool _showMap = false;

  bool get showMap => _showMap;

  set showMap(bool value) {
    _showMap = value;
    notifyListeners();
  } //BitmapDescriptor? pinLocationIconUser;

  int initialIndex = 0;
  MapType mapType = MapType.terrain;
  double latitude = 0.0;
  double longitude = 0.0;
  var value;
  String pickUpLocation = "";
  double locationRadius = 10;
  bool isCurrentAddress = true;
  String? currentCountryIsoCode;
  CameraPosition? position;

  Future getLngLt(context) async {
    value = await Geolocator.getCurrentPosition();
    latitude = value.latitude;
    longitude = value.longitude;
    getPickUpAddress(latitude, longitude);
    showMap = true;
  }

  void updateCurrentAddressValue(bool value) {
    isCurrentAddress = value;
    customNotify();
  }

/*  void setCustomMapPinUser() async {
    pinLocationIconUser = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), ImageConstants.locationMark);
    notifyListeners();
  }*/

  List<Marker> markers = [];

  onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
      mapController = controller;
    }
    /* markers.add(Marker(
      draggable: true,
      markerId: const MarkerId("ID1"),
      position: LatLng(latitude, longitude),
      icon: pinLocationIconUser!,
      onDragEnd: (newLocation) {
        getPickUpAddress(newLocation.latitude, newLocation.longitude);
        longitude = newLocation.longitude;
        latitude = newLocation.latitude;
        notifyListeners();
      },
      flat: true,
      anchor: const Offset(0.5, 0.5),
    ));*/
  }

  Future<void> getPickUpAddress(double lat, double long) async {
    try {
      List<Placemark> placeMark = await placemarkFromCoordinates(lat, long);
      pickUpLocation =
          "${placeMark.first.street} ${placeMark.first.thoroughfare}${placeMark.first.subLocality}";
      currentCountryIsoCode = placeMark.first.isoCountryCode.toString();
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
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

  updateValue(double value) {
    locationRadius = value;
    notifyListeners();
  }

  String meterToKmOrMi(double value) {
    double distanceInKMorMi = 0;
    var metricType =
        SharedPreference.prefs?.getInt(SharedPreference.units) ?? 0;
    if (metricType == 0) {
      distanceInKMorMi = value;
    } else if (metricType == 1) {
      distanceInKMorMi = value / 1000;
    } else {
      distanceInKMorMi = value / 1609.344;
    }
    return distanceInKMorMi.toStringAsFixed(metricType == 0 ? 0 : 2);
  }

  void navigateToNextPage(BuildContext context) {
    if (projectNameController.text.trim().isEmpty) {
      DialogHelper.showMessage(context, "please_enter_project_name".tr());
    } else if (pickUpLocation.isEmpty) {
      DialogHelper.showMessage(context, "Please enter the address");
    } else {
      createProjectRequest.projectName = projectNameController.text.toString();
      createProjectRequest.latitude = latitude.toString();
      createProjectRequest.longitude = longitude.toString();
      createProjectRequest.address = pickUpLocation;
      createProjectRequest.locationRadius = locationRadius.toString();
      Navigator.pushNamed(context, RouteConstants.addCrewPageManager);
    }
  }

  Future<void> moveToSelectedAddress() async {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        zoom: 14.5,
        target: LatLng(latitude, longitude),
      ),
    ));
  }

  String getMetricType() {
    var metricType =
        SharedPreference.prefs?.getInt(SharedPreference.units) ?? 0;
    if (metricType == 0) {
      return "m".tr();
    } else if (metricType == 1) {
      return "km".tr();
    } else {
      return "mi".tr();
    }
  }
}
