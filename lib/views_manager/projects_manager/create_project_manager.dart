import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/create_project_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/projects_manager/add_crew_page_manager.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../helper/decoration.dart';

class CreateProjectManager extends StatefulWidget {
  const CreateProjectManager({Key? key}) : super(key: key);

  @override
  CreateProjectManagerState createState() => CreateProjectManagerState();
}

class CreateProjectManagerState extends State<CreateProjectManager> {
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateProjectManagerProvider>(
        onModelReady: (provider) async {
      provider.createProjectRequest.clearCreateProjectRequest();
      await provider.determinePosition().then((value) async => {
            await provider.getLngLt(context),
            //provider.setCustomMapPinUser(),
          });
    }, builder: (context, provider, _) {
      Set<Circle> mCircle = {
        Circle(
          strokeColor: ColorConstants.primaryGradient2Color,
          fillColor: ColorConstants.primaryColor.withOpacity(0.2),
          strokeWidth: 2,
          circleId: const CircleId("id1"),
          center: LatLng(provider.latitude, provider.longitude),
          radius: provider.locationRadius,
        ),
      };
      return Scaffold(
        appBar: CommonWidgets.appBarWithTitleAndAction(context,
            title: "create_a_project", popFunction: () {
          CommonWidgets.hideKeyboard(context);
          Navigator.pop(context);
        }),
        body: provider.state == ViewState.busy
            ? const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.blueGradient2Color,
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: DimensionConstants.d16.h,
                        ),
                        titleWidget(context, provider),
                        SizedBox(
                          height: DimensionConstants.d20.h,
                        ),
                        projectLocation(context, provider, addressController),
                        if (provider.isCurrentAddress)
                          Column(
                            children: [
                              SizedBox(
                                height: DimensionConstants.d16.h,
                              ),
                              locationFiled(context, provider),
                            ],
                          ),
                        SizedBox(
                          height: DimensionConstants.d16.h,
                        ),
                        googleMapWidget(provider, mCircle),
                        SizedBox(
                          height: DimensionConstants.d16.h,
                        ),
                        locationRadiusWidget(context, provider),
                        SizedBox(
                          height: DimensionConstants.d30.h,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: DimensionConstants.d16.w),
                            child: CommonWidgets.commonButton(
                                context, "next".tr(),
                                color1: ColorConstants.primaryGradient2Color,
                                color2: ColorConstants.primaryGradient1Color,
                                fontSize: DimensionConstants.d16.sp,
                                onBtnTap: () {
                              CommonWidgets.hideKeyboard(context);
                              provider.navigateToNextPage(context);
                            }, shadowRequired: true)),
                        SizedBox(
                          height: DimensionConstants.d50.h,
                        ),
                      ],
                    ),
                  ),
                  if (provider.state == ViewState.busy)
                    const CustomCircularBar()
                ],
              ),
      );
    });
  }

  Widget titleWidget(
      BuildContext context, CreateProjectManagerProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("project_name".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d8.h,
          ),
          Container(
            height: DimensionConstants.d45.h,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.littleDarkGray
                  : ColorConstants.colorBlack,
              border: Theme.of(context).brightness == Brightness.dark
                  ? Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : Colors.transparent)
                  : null,
              borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
            ),
            child: TextFormField(
              controller: provider.projectNameController,
              maxLines: 1,
              keyboardType: TextInputType.name,
              decoration: ViewDecoration.inputDecorationBox(
                fieldName: "project_name".tr(),
                radius: DimensionConstants.d8.r,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.littleDarkGray,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.littleDarkGray,
                hintTextColor: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.darkGray4F4F4F,
                hintTextSize: DimensionConstants.d16.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget projectLocation(BuildContext context,
      CreateProjectManagerProvider provider, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("project_location".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          Text("type_an_address_or_drag_pin_on_map".tr()).regularText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.autoComplete,
                      arguments: provider.currentCountryIsoCode ?? 'US')
                  .then((value) async {
                if (value != null) {
                  Map<String, String> detail = value as Map<String, String>;
                  final lat = value["latitude"];
                  final lng = value["longitude"];
                  final selectedAddress = detail["address"];
                  provider.latitude = double.parse(lat ?? "0.0");
                  provider.longitude = double.parse(lng ?? "0.0");
                  provider.pickUpLocation = selectedAddress ?? "";
                  provider.moveToSelectedAddress();
                  provider.updateCurrentAddressValue(false);
                  controller.text = selectedAddress ?? "";
                }
              });
            },
            child: Container(
              height: DimensionConstants.d45.h,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.littleDarkGray
                    : ColorConstants.colorBlack,
                border: Theme.of(context).brightness == Brightness.dark
                    ? Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : Colors.transparent)
                    : null,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
              ),
              child: TextFormField(
                maxLines: 10,
                enabled: false,
                controller: controller,
                decoration: ViewDecoration.inputDecorationBox(
                  fieldName: "enter_address".tr(),
                  radius: DimensionConstants.d8.r,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.littleDarkGray,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorBlack
                      : ColorConstants.littleDarkGray,
                  hintTextColor: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.darkGray4F4F4F,
                  hintTextSize: DimensionConstants.d16.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget locationFiled(
      BuildContext context, CreateProjectManagerProvider provider) {
    return GestureDetector(
      onTap: () {
        addressController.text = provider.pickUpLocation;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
          child: Container(
            height: DimensionConstants.d60.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: DimensionConstants.d8.w,
                ),
                const ImageView(
                  path: ImageConstants.currentLocation,
                ),
                SizedBox(
                  width: DimensionConstants.d10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: DimensionConstants.d10.h,
                    ),
                    Text("current_location".tr()).boldText(
                        context, DimensionConstants.d16.sp, TextAlign.left,
                        color: ColorConstants.black333333),
                    SizedBox(
                      height: DimensionConstants.d4.h,
                    ),
                    SizedBox(
                      width: DimensionConstants.d280.w,
                      height: DimensionConstants.d20.h,
                      child: Text(provider.pickUpLocation).regularText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: ColorConstants.black333333),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget googleMapWidget(
      CreateProjectManagerProvider provider, Set<Circle> circle) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Container(
        height: DimensionConstants.d329.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: !provider.showMap
            ? const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.primaryGradient2Color,
                ),
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d8.r),
                      child: Stack(
                        children: [
                          GoogleMap(
                              mapType: provider.mapType,
                              myLocationButtonEnabled: false,
                              compassEnabled: false,
                              zoomControlsEnabled: false,
                              scrollGesturesEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    provider.latitude, provider.longitude),
                                zoom: 11.0,
                              ),
                              onMapCreated: provider.onMapCreated,
                              onCameraMove: (CameraPosition cameraPosition) {
                                provider.position = cameraPosition;
                              },
                              onCameraIdle: () {
                                if (provider.position != null) {
                                  provider.getPickUpAddress(
                                      provider.position!.target.latitude,
                                      provider.position!.target.longitude);
                                }
                              },
                              circles: circle,
                              gestureRecognizers: {
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
                              // onCameraIdle: () => provider.cameraIdle(provider.position),
                              markers: Set<Marker>.of(provider.markers)),
                          Center(
                            child: ImageView(
                              path: ImageConstants.icMarker,
                              height: 40.w,
                              width: 40.w,
                            ),
                          )
                        ],
                      )),
                  Positioned(
                    top: DimensionConstants.d8.h,
                    left: DimensionConstants.d85.w,
                    child: ToggleSwitch(
                      activeBorders: [
                        Border.all(
                            color: ColorConstants.colorBlack,
                            width: DimensionConstants.d2.w)
                      ],
                      minWidth: DimensionConstants.d91.w,
                      minHeight: DimensionConstants.d41.h,
                      fontSize: DimensionConstants.d14.sp,
                      initialLabelIndex: provider.initialIndex,
                      radiusStyle: true,
                      cornerRadius: DimensionConstants.d8.r,
                      activeBgColor: [ColorConstants.colorWhite],
                      activeFgColor: ColorConstants.deepBlue,
                      inactiveBgColor: ColorConstants.deepBlue,
                      inactiveFgColor: ColorConstants.colorWhite,
                      totalSwitches: 2,
                      labels: const [
                        'Default',
                        'Satelite',
                      ],
                      onToggle: (index) {
                        provider.updateMapStyle(index!);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget locationRadiusWidget(
      BuildContext context, CreateProjectManagerProvider provider) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
          child: Row(
            children: <Widget>[
              Text("location_radius".tr()).boldText(
                  context, DimensionConstants.d16.sp, TextAlign.left,
                  color: ColorConstants.deepBlue),
              Expanded(child: Container()),
              Text("<".tr()).boldText(
                  context, DimensionConstants.d16.sp, TextAlign.left,
                  color: ColorConstants.deepBlue),
              SizedBox(
                width: DimensionConstants.d5.w,
              ),
              Text(provider.locationRadius.toStringAsFixed(0)).boldText(
                  context, DimensionConstants.d16.sp, TextAlign.left,
                  color: ColorConstants.deepBlue),
              SizedBox(
                width: DimensionConstants.d5.w,
              ),
              Text("m".tr()).boldText(
                  context, DimensionConstants.d16.sp, TextAlign.left,
                  color: ColorConstants.deepBlue),
            ],
          ),
        ),
        SizedBox(
          width: DimensionConstants.d470.w,
          child: SfSlider(
            min: 25.0,
            max: 100.0,
            value: provider.locationRadius,
            activeColor: ColorConstants.primaryColor,
            inactiveColor: ColorConstants.grayF3F3F3,
            interval: 20,
            minorTicksPerInterval: 1,
            onChanged: (dynamic value) {
              provider.updateValue(value);
            },
          ),
        ),
      ],
    );
  }
}
