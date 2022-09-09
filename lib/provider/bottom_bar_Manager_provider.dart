import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class BottomBarManagerProvider extends BaseProvider{

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  routeNavigation(BuildContext context, int index){
    if(index == 0){
      Navigator.pushNamed(context, RouteConstants.notificationsScreenManager);
    }else if(index == 3){
      Navigator.pushNamed(context, RouteConstants.notificationsScreenManager);
    }
  }




}