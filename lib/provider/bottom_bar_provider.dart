import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/dashboard/dashboard.dart';
import '../view/profile/profile.dart';
import '../view/projects/projects_crew.dart';

class BottomBarProvider extends BaseProvider{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  String? _crewName;
  String? _crewProfilePic;
  String? _companyLogo;

  String get crewName => _crewName ?? "";

  String get crrewProfilePic => _crewProfilePic ?? "";

  String get companyLogo => _companyLogo ?? "";

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  routeNavigation(BuildContext context, int index){
    if(index == 0){
      Navigator.pushNamed(context, RouteConstants.notificationsScreen);
    }else if(index == 3){
      Navigator.pushNamed(context, RouteConstants.notificationsScreen);

    }
  }

  void updateDrawerData(String name, String profilePic) {
    //_companyLogo = companyLogo;
    _crewProfilePic = profilePic;
    _crewName = name;
    customNotify();
  }

}