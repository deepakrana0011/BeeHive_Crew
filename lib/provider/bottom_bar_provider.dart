import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/dashboard/dashboard.dart';
import '../view/profile/profile.dart';
import '../view/projects/projects.dart';

class BottomBarProvider extends BaseProvider{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  routeNavigation(BuildContext context, int index){
    if(index == 0){
      Navigator.pushNamed(context, RouteConstants.notificationsScreen);
    }
  }

}