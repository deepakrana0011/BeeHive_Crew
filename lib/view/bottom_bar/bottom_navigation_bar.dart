import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/provider/bottom_bar_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/dashboard/dashboard.dart';
import 'package:beehive/view/profile/profile.dart';
import 'package:beehive/view/projects/projects.dart';
import 'package:beehive/view/timesheets/timesheets.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static final List<Widget> _widgetOptions = <Widget>[
     DashBoardPage(),
    const Projects(),
    const TimeSheets(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return BaseView<BottomBarProvider>
        (builder: (context, provider, _){
          return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(provider.selectedIndex),
        ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: ImageView(
                      path: ImageConstants.dashboardIcon, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: const ImageView(
                      path: ImageConstants.dashboardIcon,
                    ),
                  ),
                  label: 'Dashboard',
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: ImageView(
                      path: ImageConstants.projectsIcon, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: const ImageView(
                      path: ImageConstants.projectsIcon, color: ColorConstants.primaryColor,
                    ),
                  ),
                  label: 'Projects',
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: ImageView(
                      path: ImageConstants.timeSheetsIcon, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: const ImageView(
                      path: ImageConstants.timeSheetsIcon, color: ColorConstants.primaryColor,
                    ),
                  ),
                  label: 'Timesheets',
                ),

                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: ImageView(
                      path: ImageConstants.profileIcon, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: DimensionConstants.d8.h, bottom: DimensionConstants.d3.h),
                    child: const ImageView(
                      path: ImageConstants.profileIcon, color: ColorConstants.primaryColor,
                    ),
                  ),
                  label: 'Profile',
                ),

              ],
              selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
              unselectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              currentIndex: provider.selectedIndex,
              selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
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
