import 'package:another_flushbar/flushbar.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/provider/notification_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';
import 'common_widgets.dart';
import 'decoration.dart';

class DialogHelper {
  static getPhotoDialog(BuildContext context,
      {required VoidCallback photoFromGallery,
      required VoidCallback photoFromCamera}) {
    return Dialog(
      insetPadding: EdgeInsets.only(
          left: DimensionConstants.d10.w,
          right: DimensionConstants.d10.w,
          top: DimensionConstants.d560.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
      ),
      child: Container(
        height: DimensionConstants.d195.h,
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite90
                : ColorConstants.grayD8D8D8,
            borderRadius: BorderRadius.circular(DimensionConstants.d12.r)),
        child: Column(
          children: <Widget>[
            Container(
              height: DimensionConstants.d123.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorBlack
                      : ColorConstants.colorWhite,
                  borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
                  border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : Colors.transparent,
                      width: DimensionConstants.d1.w)),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: photoFromGallery,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: DimensionConstants.d25.h,
                              bottom: DimensionConstants.d15.h),
                          child: Text("photo_gallery".tr()).regularText(
                            context,
                            DimensionConstants.d18.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.blue007AFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: DimensionConstants.d1.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.grayD2D2D7,
                  ),
                  GestureDetector(
                    onTap: photoFromCamera,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: DimensionConstants.d15.h,
                          ),
                          child: Text("camera".tr()).regularText(
                            context,
                            DimensionConstants.d18.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.blue007AFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.maxFinite,
                height: DimensionConstants.d60.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorBlack
                        : ColorConstants.colorWhite,
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d10.r),
                    border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : Colors.transparent,
                        width: DimensionConstants.d1.w)),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: DimensionConstants.d20.h,
                  ),
                  child: Text("cancel".tr()).boldText(
                    context,
                    DimensionConstants.d18.sp,
                    TextAlign.center,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.blue007AFF,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static exportFileDialog(BuildContext context,
      {required VoidCallback photoFromGallery,
      required VoidCallback photoFromCamera}) {
    return Dialog(
      insetPadding: EdgeInsets.only(
          left: DimensionConstants.d10.w,
          right: DimensionConstants.d10.w,
          top: DimensionConstants.d560.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
      ),
      child: Container(
        height: DimensionConstants.d195.h,
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite90
                : ColorConstants.grayD8D8D8,
            borderRadius: BorderRadius.circular(DimensionConstants.d12.r)),
        child: Column(
          children: <Widget>[
            Container(
              height: DimensionConstants.d123.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorBlack
                      : ColorConstants.colorWhite,
                  borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
                  border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : Colors.transparent,
                      width: DimensionConstants.d1.w)),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: photoFromGallery,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: DimensionConstants.d25.h,
                              bottom: DimensionConstants.d15.h),
                          child: Text("export_as_csv".tr()).regularText(
                            context,
                            DimensionConstants.d18.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.blue007AFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: DimensionConstants.d1.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.grayD2D2D7,
                  ),
                  GestureDetector(
                    onTap: photoFromCamera,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: DimensionConstants.d15.h,
                          ),
                          child: Text("export_as_pdf".tr()).regularText(
                            context,
                            DimensionConstants.d18.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.blue007AFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.maxFinite,
                height: DimensionConstants.d60.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorBlack
                        : ColorConstants.colorWhite,
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d10.r),
                    border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : Colors.transparent,
                        width: DimensionConstants.d1.w)),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: DimensionConstants.d20.h,
                  ),
                  child: Text("cancel".tr()).boldText(
                    context,
                    DimensionConstants.d18.sp,
                    TextAlign.center,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.blue007AFF,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static callDialogBox(BuildContext context,
      {required VoidCallback photoFromGallery,
      required VoidCallback photoFromCamera}) {
    return Dialog(
      insetPadding: EdgeInsets.only(
          left: DimensionConstants.d10.w,
          right: DimensionConstants.d10.w,
          top: DimensionConstants.d510.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
      ),
      child: Container(
        height: DimensionConstants.d256.h,
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite90
                : ColorConstants.grayD8D8D8,
            borderRadius: BorderRadius.circular(DimensionConstants.d12.r)),
        child: Column(
          children: <Widget>[
            Container(
              height: DimensionConstants.d185.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorBlack
                      : ColorConstants.colorWhite,
                  borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
                  border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : Colors.transparent,
                      width: DimensionConstants.d1.w)),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: photoFromGallery,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: DimensionConstants.d25.h,
                              bottom: DimensionConstants.d15.h),
                          child: Text("Call 416 555 1234").regularText(
                            context,
                            DimensionConstants.d18.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.blue007AFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: DimensionConstants.d1.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.grayD2D2D7,
                  ),
                  GestureDetector(
                    onTap: photoFromGallery,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: DimensionConstants.d20.h,
                              bottom: DimensionConstants.d15.h),
                          child: Text("send_message".tr()).regularText(
                            context,
                            DimensionConstants.d18.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.blue007AFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: DimensionConstants.d1.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.grayD2D2D7,
                  ),
                  GestureDetector(
                    onTap: photoFromCamera,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: DimensionConstants.d15.h,
                          ),
                          child: Text("add_to_contacts".tr()).regularText(
                            context,
                            DimensionConstants.d18.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.blue007AFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.maxFinite,
                height: DimensionConstants.d60.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorBlack
                        : ColorConstants.colorWhite,
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d10.r),
                    border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : Colors.transparent,
                        width: DimensionConstants.d1.w)),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: DimensionConstants.d20.h,
                  ),
                  child: Text("cancel".tr()).boldText(
                    context,
                    DimensionConstants.d18.sp,
                    TextAlign.center,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.blue007AFF,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static notificationDialog(BuildContext context,
      {required VoidCallback photoFromGallery,
      required VoidCallback photoFromCamera}) {
    return BaseView<NotificationProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Container(
            height: DimensionConstants.d448.h,
            width: DimensionConstants.d343.w,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.colorWhite,
                border: Theme.of(context).brightness == Brightness.dark
                    ? Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorWhite,
                        width: DimensionConstants.d1.w)
                    : null,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: DimensionConstants.d280.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: ImageView(
                      path: ImageConstants.closeIconDialog,
                      height: DimensionConstants.d11.h,
                      width: DimensionConstants.d11.w,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                    ),
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d8.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstants.d40.w),
                    child: Text(
                            "benjamin_poole_invited_you_to_join_a_new_project"
                                .tr())
                        .boldText(
                      context,
                      DimensionConstants.d18.sp,
                      TextAlign.center,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                    )),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                Container(
                  height: DimensionConstants.d158.h,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d8.r),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d8.r),
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      scrollGesturesEnabled: true,
                      initialCameraPosition: provider.kLake,
                      onMapCreated: (GoogleMapController controller) {
                        provider.controller.complete(controller);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                Text("momentum_smart_house_project".tr()).boldText(
                    context, DimensionConstants.d16.sp, TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d6.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImageView(
                      path: ImageConstants.locationIcon,
                      height: DimensionConstants.d16.h,
                      width: DimensionConstants.d16.w,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                    ),
                    SizedBox(
                      width: DimensionConstants.d4.w,
                    ),
                    const Text("123 Northfield Road, Toronto").regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack),
                  ],
                ),
                SizedBox(
                  height: DimensionConstants.d5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d27.w),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? MaterialStateProperty.all(
                                      ColorConstants.primaryColor)
                                  : null,
                          visualDensity: VisualDensity.comfortable,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  DimensionConstants.d8.r)),
                          value: provider.checkValue,
                          onChanged: (newValue) {
                            provider.updateCheckValue(newValue!);
                          },
                        ),
                      ),
                      Text("accept_all_future_invites_from_benjamin".tr())
                          .regularText(context, DimensionConstants.d14.sp,
                              TextAlign.left,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack),
                    ],
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d24.w),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d136.w,
                        child: CommonWidgets.commonButton(
                            context, "accept".tr(),
                            height: DimensionConstants.d50.h,
                            color1: ColorConstants.primaryGradient2Color,
                            color2: ColorConstants.primaryGradient1Color,
                            fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(
                              context, RouteConstants.projectDetailsPage);
                        }),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d136.w,
                        child: CommonWidgets.commonButton(
                            context, "decline".tr(),
                            height: DimensionConstants.d50.h,
                            color1: ColorConstants.deepBlue,
                            color2: ColorConstants.deepBlue,
                            fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(
                            context,
                            RouteConstants.archivedProjectsScreen,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static deleteDialogBoxManager(BuildContext context,
      {required VoidCallback cancel, required VoidCallback delete}) {
    return BaseView<NotificationProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Container(
            height: DimensionConstants.d220.h,
            width: DimensionConstants.d343.w,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.colorWhite,
                border: Theme.of(context).brightness == Brightness.dark
                    ? Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorWhite,
                        width: DimensionConstants.d1.w)
                    : null,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: DimensionConstants.d24.h,
                      left: DimensionConstants.d285.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const ImageView(
                      path: ImageConstants.closeIconDialog,
                    ),
                  ),
                ),
                Text("delete_project_mark".tr()).boldText(
                    context, DimensionConstants.d18.sp, TextAlign.center,
                    color: ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d23.h,
                ),
                Text("are_you_sure_delete".tr()).regularText(
                    context, DimensionConstants.d14.sp, TextAlign.center,
                    color: ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d35.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d24.w),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d141.w,
                        child: CommonWidgets.commonButton(
                            context, "cancel".tr(),
                            color1: ColorConstants.deepBlue,
                            color2: ColorConstants.deepBlue,
                            fontSize: DimensionConstants.d16.sp, onBtnTap: () {
                          Navigator.of(context).pop();
                        }, shadowRequired: false),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d141.w,
                        child: CommonWidgets.commonButton(
                            context, "delete".tr(),
                            color1: ColorConstants.redColorEB5757,
                            color2: ColorConstants.redColorEB5757,
                            fontSize: DimensionConstants.d16.sp,
                            onBtnTap: () {},
                            shadowRequired: false),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static archiveDialogBox(BuildContext context,
      {required VoidCallback cancel, required VoidCallback delete}) {
    return BaseView<NotificationProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Container(
            height: DimensionConstants.d220.h,
            width: DimensionConstants.d343.w,
            decoration: BoxDecoration(
                color: ColorConstants.colorWhite,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: DimensionConstants.d24.h,
                      left: DimensionConstants.d285.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const ImageView(
                      path: ImageConstants.closeIconDialog,
                    ),
                  ),
                ),
                Text("archive_project_mark".tr()).boldText(
                    context, DimensionConstants.d18.sp, TextAlign.center,
                    color: ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d23.h,
                ),
                Text("are_you_sure_you_want_to_archive_this_project".tr())
                    .regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center,
                        color: ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d35.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d24.w),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d141.w,
                        child: CommonWidgets.commonButton(
                            context, "cancel".tr(),
                            color1: ColorConstants.deepBlue,
                            color2: ColorConstants.deepBlue,
                            fontSize: DimensionConstants.d16.sp, onBtnTap: () {
                          Navigator.of(context).pop();
                        }, shadowRequired: false),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d141.w,
                        child: CommonWidgets.commonButton(
                            context, "Archive".tr(),
                            color1: ColorConstants.redColorEB5757,
                            color2: ColorConstants.redColorEB5757,
                            fontSize: DimensionConstants.d16.sp,
                            onBtnTap: () {},
                            shadowRequired: false),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static removeProjectDialog(BuildContext context,
      {required VoidCallback cancel, required VoidCallback delete}) {
    return BaseView<NotificationProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Container(
            height: DimensionConstants.d220.h,
            width: DimensionConstants.d343.w,
            decoration: BoxDecoration(
                color: ColorConstants.colorWhite,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: DimensionConstants.d24.h,
                      left: DimensionConstants.d285.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const ImageView(
                      path: ImageConstants.closeIconDialog,
                    ),
                  ),
                ),
                Text("remove_from_project".tr()).boldText(
                    context, DimensionConstants.d18.sp, TextAlign.center,
                    color: ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d23.h,
                ),
                Text("are_you_sure_you_want_to".tr()).regularText(
                    context, DimensionConstants.d14.sp, TextAlign.center,
                    color: ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d35.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d24.w),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d141.w,
                        child: CommonWidgets.commonButton(
                            context, "cancel".tr(),
                            color1: ColorConstants.deepBlue,
                            color2: ColorConstants.deepBlue,
                            fontSize: DimensionConstants.d16.sp, onBtnTap: () {
                          Navigator.of(context).pop();
                        }, shadowRequired: false),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: DimensionConstants.d50.h,
                        width: DimensionConstants.d141.w,
                        child: CommonWidgets.commonButton(
                            context, "remove".tr(),
                            color1: ColorConstants.redColorEB5757,
                            color2: ColorConstants.redColorEB5757,
                            fontSize: DimensionConstants.d16.sp, onBtnTap: () {
                          Navigator.of(context).pop();
                        }, shadowRequired: false),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showMessage(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundGradient: const LinearGradient(colors: [
        ColorConstants.primaryGradient1Color,
        ColorConstants.primaryGradient2Color
      ]),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static editRateDialogBox(BuildContext context,
      {required VoidCallback cancel, required VoidCallback delete}) {
    FocusNode focusNode = FocusNode();
    FocusScope.of(context).requestFocus(focusNode);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(top: DimensionConstants.d275.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(DimensionConstants.d41.r),
            topRight: Radius.circular(DimensionConstants.d41.r)),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: DimensionConstants.d280.h,
            child: Padding(
              padding: EdgeInsets.only(top: DimensionConstants.d40.h),
              child: Container(
                height: DimensionConstants.d240.h,
                width: DimensionConstants.d375.w,
                decoration: BoxDecoration(
                  color: ColorConstants.colorWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(DimensionConstants.d41.r),
                      topRight: Radius.circular(DimensionConstants.d41.r)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: DimensionConstants.d25.h,
                    ),
                    Text("edit_rate".tr()).boldText(
                        context, DimensionConstants.d20.sp, TextAlign.center,
                        color: ColorConstants.deepBlue),
                    SizedBox(
                      height: DimensionConstants.d15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: DimensionConstants.d100.w),
                      child: Row(
                        children: <Widget>[
                          const ImageView(
                            path: ImageConstants.dollarIcon,
                          ),
                          SizedBox(
                            width: DimensionConstants.d8.w,
                          ),
                          Container(
                            height: DimensionConstants.d54.h,
                            width: DimensionConstants.d125.w,
                            decoration: BoxDecoration(
                              color: ColorConstants.grayF2F2F2,
                              borderRadius: BorderRadius.circular(
                                  DimensionConstants.d8.r),
                            ),
                            child: TextFormField(
                              focusNode: focusNode,
                              keyboardType: TextInputType.phone,
                              decoration: ViewDecoration.inputDecorationBox(
                                  fieldName: "20.00".tr(),
                                  radius: DimensionConstants.d8.r,
                                  fillColor: ColorConstants.littleDarkGray,
                                  color: ColorConstants.grayF2F2F2,
                                  hintTextColor: ColorConstants.colorBlack,
                                  hintTextSize: DimensionConstants.d16.sp,
                                  textFiledColor: ColorConstants.colorBlack),
                            ),
                          ),
                          SizedBox(
                            width: DimensionConstants.d8.w,
                          ),
                          const ImageView(
                            path: ImageConstants.hrIcon,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DimensionConstants.d17.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionConstants.d16.w),
                      child: CommonWidgets.commonButton(context, "save".tr(),
                          color1: ColorConstants.primaryGradient1Color,
                          color2: ColorConstants.primaryGradient2Color,
                          fontSize: DimensionConstants.d16.sp, onBtnTap: () {
                        Navigator.of(context).pop();
                      }, shadowRequired: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: DimensionConstants.d190.h,
              left: DimensionConstants.d270.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const ImageView(
                  path: ImageConstants.crossIcon,
                ),
              )),
        ],
      ),
    );
  }
}
