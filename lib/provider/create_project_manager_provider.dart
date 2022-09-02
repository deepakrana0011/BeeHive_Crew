import 'dart:async';
import 'dart:io';

import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
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
  Completer<GoogleMapController> controller = Completer();
  BitmapDescriptor? pinLocationIconUser;

  final CameraPosition kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.7333, 76.7794),
      tilt: 20,
      zoom: 10);
  int initialIndex = 0;
  MapType mapType = MapType.terrain;
  double latitude = 0;
  double longitude = 0;
  var value;
  String pickUpLocation = "";
  Future getLngLt(context) async {
    setState(ViewState.busy);
    value = await Geolocator.getCurrentPosition();
    latitude = value.latitude;
    longitude = value.longitude;
    setState(ViewState.idle);
  }

  void setCustomMapPinUser() async {
    pinLocationIconUser = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), ImageConstants.locationMark);
    notifyListeners();
  }

  List<Marker> markers = [];
  onMapCreated(GoogleMapController controller) {
    setState(ViewState.busy);
    markers.add(Marker(
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
    ));
    setState(ViewState.idle);
  }

  CameraPosition? position;

  Future<void> getPickUpAddress(double lat, double long) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, long);
    pickUpLocation = placeMark.first.street.toString() +
        " " +
        placeMark.first.thoroughfare.toString() +
        placeMark.first.subLocality.toString();
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

  double valueFor = 0;
  updateValue(double value) {
    valueFor = value;
    notifyListeners();
  }

  Future createProjectManager(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.createProjectManager(
        context,
        projectName: projectNameController.text,
        longitude: longitude.toString(),
        locationRadius: valueFor.toString(),
        latitude: latitude.toString(),
        address: pickUpLocation,
      );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pushNamed(context, RouteConstants.addCrewPageManager,
            arguments: AddCrewPageManager(projectId: model.data!.sId!));
        DialogHelper.showMessage(context, model.message!);
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
