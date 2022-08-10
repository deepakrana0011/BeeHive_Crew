import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/create_project_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../helper/decoration.dart';

class CreateProjectManager extends StatelessWidget {
  const CreateProjectManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateProjectManagerProvider>(
        onModelReady: (provider) {
          provider.determinePosition().then((value) => {
            provider.addLatLongToMap(value.latitude, value.longitude),




          });

        },
        builder: (context, provider, _) {
          return Scaffold(
            appBar: CommonWidgets.appBarWithTitleAndAction(context,
                title: "create_a_project"),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: DimensionConstants.d19.h,
                  ),
                  titleWidget(context),
                  SizedBox(
                    height: DimensionConstants.d24.h,
                  ),
                  projectLocation(context),
                  SizedBox(
                    height: DimensionConstants.d19.h,
                  ),
                  locationFiled(context),
                  SizedBox(
                    height: DimensionConstants.d16.h,
                  ),
                  googleMapWidget(provider),
                ],
              ),
            ),
          );
        });
  }
}

Widget titleWidget(BuildContext context) {
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
            maxLines: 10,
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

Widget projectLocation(BuildContext context) {
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
            maxLines: 10,
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
        )
      ],
    ),
  );
}

Widget locationFiled(BuildContext context) {
  return Padding(
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
            SizedBox(width: DimensionConstants.d10.w,),
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
                Text("").regularText(
                    context, DimensionConstants.d14.sp, TextAlign.left,
                    color: ColorConstants.black333333)
              ],
            )
          ],
        ),
      ),
    ),
  );
}
Widget googleMapWidget(CreateProjectManagerProvider provider){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Container(
      height: DimensionConstants.d329.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r)
      ),
      child: Stack(
        children:<Widget> [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(DimensionConstants.d8.r),
            child: GoogleMap(
              mapType: provider.mapType,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: false,
              scrollGesturesEnabled: true,
              initialCameraPosition:CameraPosition(
                target: LatLng(provider.latitude, provider.longitude),
                zoom: 11.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                provider.controller.complete(controller);
              },
            ),
          ),
          Positioned(
            top: DimensionConstants.d8.h,
            left: DimensionConstants.d85.w,
            child: ToggleSwitch(
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
            labels: const ['Default', 'Satelite',],
            onToggle: (index) {
              provider.updateMapStyle(index!);
            },
          ),)


        ],
      ),

    ),
  );


}
