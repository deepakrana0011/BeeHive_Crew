import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/helper/decoration.dart';
import 'package:beehive/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import '../constants/color_constants.dart';

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
            apiKey: googleApiKey,
            language: "en",
            offset: 0,
            radius: 0,
            types: [],
            strictbounds: false,
            region: "",
            components: []);

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: ColorConstants.colorWhite,
        title: AppBarPlacesAutoCompleteTextField(
          textStyle: ViewDecoration.textFieldStyle(
            DimensionConstants.d18.sp,
            FontWeight.w400,
            ColorConstants.colorBlack,
          ),
        ));
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p);
      },
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    print("error message is ${response.errorMessage}");
  }

  @override
  void onResponse(PlacesAutocompleteResponse? response) {
    super.onResponse(response);
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry?.location.lat;
      final lng = detail.result.geometry?.location.lng;
      Map<String, String> value = Map();
      value["latitude"] = lat.toString();
      value["longitude"] = lng.toString();
      value["address"] = p.description!;
      //hideKeyboard(context);
      Navigator.pop(context, value);
    }
  }
}
