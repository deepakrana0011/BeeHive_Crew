import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/bottom_bar_provider.dart';
import 'package:beehive/provider/dashboard_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/dashboard/dashboard.dart';
import 'package:beehive/view/profile/profile.dart';
import 'package:beehive/view/projects/projects_crew.dart';
import 'package:beehive/view/timesheets/timesheets_tab_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/route_constants.dart';
import '../../helper/common_widgets.dart';
import '../../provider/app_state_provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static final List<Widget> _widgetOptions = <Widget>[
    DashBoardPage(),
    const ProjectsCrew(),
    const TimeSheetsTabBar(),
    const Profile(),
  ];
  List<String> menuName = [
    ImageConstants.brandIocn,
    "Projects",
    "Timesheets",
    "Profile"
  ];
  List<String> actionIcon = [
    ImageConstants.notificationIcon,
    ImageConstants.searchIcon,
    ImageConstants.settingsIcon,
    ImageConstants.notificationIconBell
  ];
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<AppStateNotifier>(context);
    return BaseView<BottomBarProvider>(
        onModelReady: (provider){

        },
        builder: (context, provider, _) {
      return Scaffold(
        key: provider.scaffoldKey,
        drawer: drawer(context,provider),
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: provider.selectedIndex == 0
              ? ImageView(
                  path: menuName.elementAt(provider.selectedIndex,),
                  height: DimensionConstants.d56.h,
                  width: DimensionConstants.d56.w,
                )
              : Text(menuName.elementAt(provider.selectedIndex)).semiBoldText(
                  context,
                  DimensionConstants.d22.sp,
                  TextAlign.center,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
                ),
          leading: GestureDetector(
              onTap: () {
                provider.scaffoldKey.currentState!.openDrawer();
              },
              child: Padding(
                padding:  const EdgeInsets.all(DimensionConstants.d15),
                child: ImageView(
                  path: ImageConstants.drawerIcon,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
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
              padding: provider.selectedIndex == 0 ?EdgeInsets.only(right: DimensionConstants.d10.w):EdgeInsets.only(right: DimensionConstants.d10.w,top: DimensionConstants.d10.h),
              child: GestureDetector(
                onTap:(){
                  provider.routeNavigation(context, provider.selectedIndex);
                },
                child: ImageView(path: actionIcon.elementAt(provider.selectedIndex),
                height: DimensionConstants.d24.h,
                  width: DimensionConstants.d24.w,
                  color:provider.selectedIndex != 0? Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack:null,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(provider.selectedIndex),
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
          selectedLabelStyle:
              Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
          unselectedLabelStyle:
              Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          currentIndex: provider.selectedIndex,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
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

Widget drawer(BuildContext context,BottomBarProvider provider) {
  return Stack(
    children: [
      SizedBox(
        width: DimensionConstants.d340.w,
        child: Padding(
          padding:  EdgeInsets.only(right: DimensionConstants.d26.w),
          child: Drawer(
              width: DimensionConstants.d310.w,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      height: DimensionConstants.d300.h,
                      color: ColorConstants.deepBlue,
                      child: Stack(
                        children: [
                          SizedBox(
                              width: DimensionConstants.d314.w,
                              child: const ImageView(path: ImageConstants.maskIcon)),
                          Positioned(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: DimensionConstants.d56.h),
                                child: ImageView(path: ImageConstants.drawerProfile),
                              ),
                              // SizedBox(height: DimensionConstants.d19.h),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: DimensionConstants.d42.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(" welcome".tr()).semiBoldText(context,
                                        DimensionConstants.d20.sp, TextAlign.center,
                                        color: ColorConstants.colorWhite),
                                    // SizedBox(height: DimensionConstants.d3.h),
                                    Text(provider.crewName??"").boldText(context,
                                        DimensionConstants.d30.sp, TextAlign.center,
                                        color: ColorConstants.colorWhite),
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
                      onTap: (){
                        Navigator.pop(context); provider.onItemTapped(0);
                      },
                      child: drawerHeadingsRow(
                          context, ImageConstants.dashboardIcon, "dashboard".tr(),
                          active: provider.selectedIndex== 0?true:false),
                    ),
                    SizedBox(height: DimensionConstants.d36.h),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context); provider.onItemTapped(2);
                      },
                      child: drawerHeadingsRow(
                          context, ImageConstants.timeSheetsIcon, "time_sheets".tr(),active: provider.selectedIndex== 2?true:false),
                    ),
                    SizedBox(height: DimensionConstants.d33.h),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context); provider.onItemTapped(1);
                      },
                      child: drawerHeadingsRow(
                          context, ImageConstants.calendarIcon, "schedule".tr(),active: provider.selectedIndex== 1?true:false),
                    ),
                    SizedBox(height: DimensionConstants.d33.h),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, RouteConstants.archivedProjectsScreen);
                      },
                      child: drawerHeadingsRow(context, ImageConstants.openFolderIcon,
                          "archived_projects".tr()),
                    ),
                    SizedBox(height: DimensionConstants.d30.h),
                    const Divider(
                      color: ColorConstants.colorGreyDrawer,
                      thickness: 1.5,
                      height: 0.0,
                    ),
                    SizedBox(height: DimensionConstants.d30.h),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, RouteConstants.appSettings);
                        },
                        child: drawerHeadingsRow(context, ImageConstants.settingsIcon, "app_settings".tr())),
                    SizedBox(height: DimensionConstants.d37.h),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context); provider.onItemTapped(3);
                      },
                      child: drawerHeadingsRow(
                          context, ImageConstants.profileIcon, "my_account".tr(),active: provider.selectedIndex== 3?true:false),
                    ),
                    SizedBox(height: DimensionConstants.d34.h),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        SharedPreference.clearSharedPrefs();
                       SharedPreference.prefs!.setInt(SharedPreference.IS_CHECK_IN, 1);
                        Navigator.pushNamed(context, RouteConstants.selectToContinueScreen);
                      },
                      child: drawerHeadingsRow(
                          context, ImageConstants.logoutIcon, "logout".tr()),
                    ),
                    SizedBox(height: DimensionConstants.d19.h),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: DimensionConstants.d34.w),
                      child: CommonWidgets.commonButton(
                          context, "upgrade_to_crew_manager".tr(),
                          height: DimensionConstants.d50.h,
                          color1: ColorConstants.blueGradient2Color,
                          color2: ColorConstants.blueGradient1Color,
                          fontSize: DimensionConstants.d14.sp,
                        onBtnTap: (){
                            Navigator.of(context).pop();
                          Navigator.pushNamed(context, RouteConstants.upgradePage);
                        },
                        shadowRequired: false


                      ),
                    ),
                    SizedBox(height: DimensionConstants.d20.h),
                  ],
                ),
              )),
        ),
      ),
      Positioned(
          top: DimensionConstants.d60.h,
          left: DimensionConstants.d283.w,
          child: GestureDetector(
            onTap: (){
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
              ? Text(heading)
                  .regularText(context, DimensionConstants.d16.sp, TextAlign.left)
              : Text(heading)
                  .boldText(context, DimensionConstants.d16.sp, TextAlign.left)
        ],
      ),
    ),
  );
}
