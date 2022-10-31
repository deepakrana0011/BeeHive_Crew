import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/drawer_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/billing_information/billing_information_page_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';

class DrawerManager extends StatefulWidget {
  BottomBarManagerProvider? provider;

  DrawerManager({Key? key, this.provider}) : super(key: key);

  @override
  State<DrawerManager> createState() => _DrawerManagerState();
}

class _DrawerManagerState extends State<DrawerManager> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: DimensionConstants.d340.w,
          child: Padding(
            padding: EdgeInsets.only(right: DimensionConstants.d26.w),
            child: Drawer(
                width: DimensionConstants.d310.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        height: DimensionConstants.d300.h,
                        width: DimensionConstants.d314.w,
                        decoration: widget.provider!.drawerBgColor != "" ?
                        BoxDecoration(
                            color: Color(int.parse(widget.provider!.drawerBgColor.toString())),/*Color(int.parse(SharedPreference.prefs!.getString(SharedPreference.COLORFORDRAWER)!))*/
                        )
                            : const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          ColorConstants.blueGradient1Color,
                          ColorConstants.blueGradient2Color
                          ]
                         )
                  ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: DimensionConstants.d15.h,
                                  left: DimensionConstants.d15.w),
                              child: SizedBox(
                                  width: DimensionConstants.d314.w,
                                  height: DimensionConstants.d300.h,
                                  child: const ImageView(
                                      path: ImageConstants.groupIcon)),
                            ),
                            Positioned.fill(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DimensionConstants.d43.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: DimensionConstants.d130.w,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              DimensionConstants.d55.r),
                                          child: Container(
                                            color: Colors.white,
                                            height: DimensionConstants.d110.h,
                                            width: DimensionConstants.d110.w,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: ImageView(
                                                path: widget.provider!.managerProfilePic.isEmpty ? "" : ApiConstantsCrew.BASE_URL_IMAGE + widget.provider!.managerProfilePic,/*SharedPreference.prefs!.getString(SharedPreference.USER_PROFILE) != null ?ApiConstantsManager.BASEURL_IMAGE+SharedPreference.prefs!.getString(SharedPreference.USER_PROFILE)!: "" ,*/
                                                height:
                                                    DimensionConstants.d110.h,
                                                width:
                                                    DimensionConstants.d110.w,
                                                circleCrop: true,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (widget.provider!.companyLogo.isNotEmpty)
                                          Positioned(
                                              bottom: 10,
                                              right: 5,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        DimensionConstants
                                                            .d27.r),
                                                child: ImageView(
                                                  path: ApiConstantsCrew.BASE_URL_IMAGE + widget.provider!.companyLogo,/*SharedPreference.prefs!.getString(SharedPreference.USER_LOGO) != null? ApiConstantsManager.BASEURL_IMAGE+SharedPreference.prefs!.getString(SharedPreference.USER_LOGO)!:"" ,*/
                                                  height:
                                                      DimensionConstants.d55.h,
                                                  width:
                                                      DimensionConstants.d55.w,
                                                  fit: BoxFit.cover,
                                                ),
                                              ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: DimensionConstants.d15.h,
                                  ),
                                  Text("welcome".tr()).semiBoldText(
                                      context,
                                      DimensionConstants.d20.sp,
                                      TextAlign.center,
                                      color: ColorConstants.colorWhite),
                                  Text(widget.provider!.managerName/*SharedPreference.prefs!.getString(SharedPreference.USER_NAME)!*/).boldText(
                                      context,
                                      DimensionConstants.d30.sp,
                                      TextAlign.start,
                                      color: ColorConstants.colorWhite,
                                      maxLines: 2),
                                  SizedBox(
                                    height: DimensionConstants.d8.h,
                                  ),
                                  Container(
                                    height: DimensionConstants.d27.h,
                                    width: DimensionConstants.d158.w,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.deepBlue,
                                      borderRadius: BorderRadius.circular(
                                          DimensionConstants.d8.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: DimensionConstants.d8.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          ImageView(
                                            path: ImageConstants.crewIcon,
                                            width: DimensionConstants.d19.w,
                                            height: DimensionConstants.d17.h,
                                          ),
                                          SizedBox(
                                            width: DimensionConstants.d4.w,
                                          ),
                                          Text("crew_manager".tr())
                                              .semiBoldText(
                                                  context,
                                                  DimensionConstants.d14.sp,
                                                  TextAlign.left,
                                                  color: ColorConstants
                                                      .colorWhite),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(height: DimensionConstants.d41.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.provider!.onItemTapped(0);
                        },
                        child: drawerHeadingsRow(context,
                            ImageConstants.dashboardIcon, "dashboard".tr(),
                            active: widget.provider!.selectedIndex == 0
                                ? true
                                : false),
                      ),
                      SizedBox(height: DimensionConstants.d36.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.provider!.onItemTapped(2);
                        },
                        child: drawerHeadingsRow(context,
                            ImageConstants.timeSheetsIcon, "time_sheets".tr(),
                            active: widget.provider!.selectedIndex == 2
                                ? true
                                : false),
                      ),
                      SizedBox(height: DimensionConstants.d33.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.provider!.onItemTapped(1);
                        },
                        child: drawerHeadingsRow(
                          context,
                          ImageConstants.calendarIcon,
                          "schedule".tr(),
                        ),
                      ),
                      SizedBox(height: DimensionConstants.d33.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.provider!.onItemTapped(1);
                          widget.provider!.updateNavigationValue(3);
                        },
                        child: drawerHeadingsRow(
                          context,
                          ImageConstants.openFolderIcon,
                          "archived_projects".tr(),
                        ),
                      ),
                      SizedBox(height: DimensionConstants.d30.h),
                      const Divider(
                        color: ColorConstants.colorGreyDrawer,
                        thickness: 1.5,
                        height: 0.0,
                      ),
                      SizedBox(height: DimensionConstants.d30.h),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, RouteConstants.appSettingsManager);
                          },
                          child: drawerHeadingsRow(
                              context,
                              ImageConstants.settingsIcon,
                              "app_settings".tr())),
                      SizedBox(height: DimensionConstants.d37.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context,
                              RouteConstants.billingInformationPageManager,
                              arguments: BillingInformationPageManager(
                                  texOrNot: true));
                        },
                        child: drawerHeadingsRow(
                          context,
                          ImageConstants.billingIcon,
                          "billing".tr(),
                        ),
                      ),
                      SizedBox(height: DimensionConstants.d34.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          SharedPreference.clearSharedPrefs();
                          Navigator.pushNamed(
                              context, RouteConstants.selectToContinueScreen);
                        },
                        child: drawerHeadingsRow(
                            context, ImageConstants.logoutIcon, "logout".tr()),
                      ),
                      SizedBox(height: DimensionConstants.d19.h),
                      SizedBox(height: DimensionConstants.d20.h),
                    ],
                  ),
                )),
          ),
        ),
        Positioned(
            top: DimensionConstants.d60.h,
            left: DimensionConstants.d280.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ImageView(
                path: ImageConstants.crossIcon,
              ),
            ))
      ],
    );
  }

  Widget drawerHeadingsRow(
      BuildContext context, String iconPath, String heading,
      {bool active = false, Color? color}) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(left: DimensionConstants.d38.w),
        child: Row(
          children: [
            ImageView(
                path: iconPath,
                color: active
                    ? ColorConstants.primaryColor
                    : (Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack)),
            SizedBox(width: DimensionConstants.d16.w),
            !active
                ? Text(heading).regularText(
                    context, DimensionConstants.d16.sp, TextAlign.left)
                : Text(heading).boldText(
                    context, DimensionConstants.d16.sp, TextAlign.left)
          ],
        ),
      ),
    );
  }
}
