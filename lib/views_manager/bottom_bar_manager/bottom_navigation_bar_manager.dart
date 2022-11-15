import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/dashboard_page_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/billing_information/billing_information_page_manager.dart';
import 'package:beehive/views_manager/dashboard_manager/drawer_manager.dart';
import 'package:beehive/views_manager/profile_manager/profile_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/projects_page_manager.dart';
import 'package:beehive/views_manager/timesheet_manager/timesheet_page_manager.dart';
import 'package:beehive/widget/custom_class.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/route_constants.dart';
import '../../provider/app_state_provider.dart';
import '../dashboard_manager/dashboard_manager.dart';

class BottomBarManager extends StatefulWidget {
  int? pageIndex;
  int? fromBottomNav;

  BottomBarManager({Key? key, this.pageIndex, this.fromBottomNav})
      : super(key: key);

  @override
  _BottomBarManagerState createState() => _BottomBarManagerState();
}

class _BottomBarManagerState extends State<BottomBarManager> {
  static final List<Widget> _widgetOptions = <Widget>[
    const DashBoardPageManager(),
   const ProjectsPageManager(),
    const TimeSheetPageManager(),
    const ProfilePageManager(),
  ];
  List<String> menuName = [
    ImageConstants.dashBoardIcon,
    "Projects",
    "Timesheets",
    "Profile"
  ];
  List<String> actionIcon = [
    ImageConstants.notificationIcon,
    ImageConstants.searchIcon,
    ImageConstants.searchIcon,
    ImageConstants.notificationIconBell
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomBarManagerProvider>(onModelReady: (provider) {
      provider.onItemTapped(widget.pageIndex!);
      provider.updateNavigationValue(widget.fromBottomNav!);
    }, builder: (context, provider, _) {
      return provider.state == ViewState.busy
          ? const Scaffold(
              body: Center(
              child: CircularProgressIndicator(
                color: ColorConstants.primaryGradient2Color,
              ),
            ))
          : Scaffold(
              backgroundColor: ColorConstants.colorWhite,
              key: provider.scaffoldKey,
              drawer: DrawerManager(
                provider: provider,

              ) /*drawer(
                context,
                provider,
              )*/
              ,
              appBar: provider.fromBottomNav == 1
                  ? AppBar(
                      centerTitle: true,
                      elevation: 1,
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                      title: provider.selectedIndex == 0
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  DimensionConstants.d24.r),
                              child: ImageView(
                                path: provider.companyLogo.isEmpty
                                    ? menuName.elementAt(
                                        provider.selectedIndex,
                                      )
                                    : ApiConstantsCrew.BASE_URL_IMAGE +
                                    provider.companyLogo,
                                height: DimensionConstants.d48.h,
                                width: DimensionConstants.d48.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(menuName.elementAt(provider.selectedIndex))
                              .semiBoldText(
                              context,
                              DimensionConstants.d22.sp,
                              TextAlign.center,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack,
                            ),
                      leading: GestureDetector(
                          onTap: () {
                            provider.scaffoldKey.currentState!.openDrawer();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.all(DimensionConstants.d15),
                            child: ImageView(
                              path: ImageConstants.drawerIcon,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack,
                              height: DimensionConstants.d24.h,
                              width: DimensionConstants.d24.w,
                            ),
                          )),
                      actions: [
                        // provider.selectedIndex == 0 ? Switch(
                        //     value: themeChange.isDarkModeOn,
                        //     onChanged: (boolVal) {
                        //       themeChange.updateTheme(boolVal);
                        //       provider.updateLoadingStatus(true);
                        //     },
                        //   ):Container(),
                        Padding(
                          padding: provider.selectedIndex == 0
                              ? EdgeInsets.only(right: DimensionConstants.d20.w)
                              : EdgeInsets.only(
                                  right: DimensionConstants.d10.w,
                                  top: DimensionConstants.d10.h),
                          child: GestureDetector(
                            onTap: () {
                              provider.routeNavigation(
                                  context, provider.selectedIndex);
                            },
                            child: ImageView(
                              path:
                                  actionIcon.elementAt(provider.selectedIndex),
                              height: DimensionConstants.d24.h,
                              width: DimensionConstants.d24.w,
                              color: provider.selectedIndex != 0
                                  ? Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorConstants.colorWhite
                                      : ColorConstants.colorBlack
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
              body: Center(
                child: provider.pageView(
                  provider.selectedIndex,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: const ImageView(
                        path: ImageConstants.bottomBarDashBoardInActive,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: const ImageView(
                        path: ImageConstants.dashboardIcon,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: ImageView(
                        path: ImageConstants.projectsIcon,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack),
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: const ImageView(
                        path: ImageConstants.bottomBarProjectActive,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    label: 'Projects',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: ImageView(
                        path: ImageConstants.timeSheetsIcon,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack),
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: const ImageView(
                        path: ImageConstants.bottomBarTimeSheetActive,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    label: 'Timesheets',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: ImageView(
                        path: ImageConstants.profileIcon,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack),
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d3.h),
                      child: const ImageView(
                        path: ImageConstants.bottomBarProfileActive,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
                selectedLabelStyle: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedLabelStyle,
                unselectedLabelStyle: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedLabelStyle,
                type: BottomNavigationBarType.fixed,
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                currentIndex: provider.selectedIndex,
                selectedItemColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                unselectedItemColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                iconSize: 25,
                onTap: provider.onItemTapped,
                elevation: 5,
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),
            );
    });
  }
}

Widget drawer(BuildContext context, BottomBarManagerProvider provider,) {
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
                      decoration:  BoxDecoration(
                        color: Color(int.parse(provider.drawerBgColor)),
                         /* gradient: LinearGradient(colors: [
                        ColorConstants.blueGradient1Color,
                        ColorConstants.blueGradient2Color
                      ])*/),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: DimensionConstants.d15.h,
                                left: DimensionConstants.d15.w),
                            child: SizedBox(
                                width: DimensionConstants.d314.w,
                                child: const ImageView(
                                    path: ImageConstants.groupIcon)),
                          ),
                          Positioned(
                              child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: DimensionConstants.d60.h,
                                    left: DimensionConstants.d30.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      DimensionConstants.d55.r),
                                  child: ImageView(
                                    path: ApiConstantsManager.BASEURL_IMAGE+ provider.managerProfilePic, /*SharedPreference.prefs!.getString(SharedPreference.USER_PROFILE) == null? ImageConstants.drawerProfile : ApiConstantsCrew.BASE_URL_IMAGE + SharedPreference.prefs!.getString(SharedPreference.USER_PROFILE)!,*/
                                    height: DimensionConstants.d110.h,
                                    width: DimensionConstants.d110.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: DimensionConstants.d110.h,
                                  left: DimensionConstants.d110.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        DimensionConstants.d27.r),
                                    child: ImageView(
                                      path:ApiConstantsManager.BASEURL_IMAGE+ provider.companyLogo, /*SharedPreference.prefs!.getString(SharedPreference.USER_LOGO) == null? ImageConstants.brandIocn : ApiConstantsCrew.BASE_URL_IMAGE + SharedPreference.prefs!.getString(SharedPreference.USER_LOGO)!*/
                                      height: DimensionConstants.d55.h,
                                      width: DimensionConstants.d55.w,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: DimensionConstants.d35.w, top: 160),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("welcome".tr()).semiBoldText(
                                        context,
                                        DimensionConstants.d20.sp,
                                        TextAlign.center,
                                        color: ColorConstants.colorWhite),
                                    Text(SharedPreference.prefs!.getString(
                                                SharedPreference.USER_NAME) ??
                                            "")
                                        .boldText(
                                            context,
                                            DimensionConstants.d30.sp,
                                            TextAlign.center,
                                            color: ColorConstants.colorWhite),
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
                                            horizontal:
                                                DimensionConstants.d8.w),
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
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: DimensionConstants.d41.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        provider.onItemTapped(0);
                      },
                      child: drawerHeadingsRow(context,
                          ImageConstants.dashboardIcon, "dashboard".tr(),
                          active: provider.selectedIndex == 0 ? true : false),
                    ),
                    SizedBox(height: DimensionConstants.d36.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        provider.onItemTapped(2);
                      },
                      child: drawerHeadingsRow(context,
                          ImageConstants.timeSheetsIcon, "time_sheets".tr(),
                          active: provider.selectedIndex == 2 ? true : false),
                    ),
                    SizedBox(height: DimensionConstants.d33.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        provider.onItemTapped(1);
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
                        provider.onItemTapped(1);
                        provider.updateNavigationValue(3);
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
                        child: drawerHeadingsRow(context,
                            ImageConstants.settingsIcon, "app_settings".tr())),
                    SizedBox(height: DimensionConstants.d37.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context,
                            RouteConstants.billingInformationPageManager,
                            arguments:
                                BillingInformationPageManager(texOrNot: true));
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
                        /*Navigator.pushNamed(
                            context, RouteConstants.selectToContinueScreen);*/

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteConstants.selectToContinueScreen, (Route<dynamic> route) => false);
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

Widget drawerHeadingsRow(BuildContext context, String iconPath, String heading,
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
              : Text(heading)
                  .boldText(context, DimensionConstants.d16.sp, TextAlign.left)
        ],
      ),
    ),
  );
}
