import 'dart:io';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/all_archive_projects_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:beehive/views_manager/dashboard_manager/archived_projects_screen_manager.dart';
import 'package:beehive/views_manager/projects_manager/archived_project_details_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/image_constants.dart';
import '../constants/route_constants.dart';
import '../views_manager/dashboard_manager/dashboard_manager.dart';
import '../views_manager/profile_manager/profile_page_manager.dart';
import '../views_manager/projects_manager/project_details_manager.dart';
import '../views_manager/projects_manager/projects_page_manager.dart';
import '../views_manager/timesheet_manager/timesheet_page_manager.dart';

class BottomBarManagerProvider extends BaseProvider {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  int fromBottomNav = 1;

  String? _managerName;
  String? _managerProfilePic;
  String? _companyLogo;
  String? _drawerBgColor;

  String get managerName => _managerName ?? "";

  String get managerProfilePic => _managerProfilePic ?? "";

  String get companyLogo => _companyLogo ?? "";

  String get drawerBgColor => _drawerBgColor ?? "";


  String? projectId;
  bool createProject=false;
  bool archiveProject = false;

  void updateDrawerData(String name, String? profilePic, String? companyLogo, String? color) {
    _companyLogo = companyLogo;
    _managerProfilePic = profilePic;
    _managerName = name;
    _drawerBgColor = color;
    customNotify();
  }

  updateNavigationValue(int newValue,{String? projectId,bool createProject=false, bool? archiveProject}) {
    fromBottomNav = newValue;
    this.projectId=projectId;
    this.createProject=createProject;
    this.archiveProject = archiveProject ?? false;
    notifyListeners();
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    updateNavigationValue(1);
    notifyListeners();
  }

  routeNavigation(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushNamed(context, RouteConstants.notificationsScreenManager);
    } else if (index == 3) {
      Navigator.pushNamed(context, RouteConstants.notificationsScreenManager);
    }
  }

  final List<Widget> widgetOptions = <Widget>[
    const DashBoardPageManager(),
     ProjectsPageManager(),
    const TimeSheetPageManager(),
    const ProfilePageManager(),
  ];

  pageView(int index) {
    if (index == 0) {
      return const DashBoardPageManager();
    } else if (index == 1) {
      if (fromBottomNav == 1) {
        return  ProjectsPageManager();
      } else if (fromBottomNav == 2) {
        return ArchivedProjectDetailsManager(
            archivedOrProject: true, fromProject: false);
      } else if (fromBottomNav == 3) {
        return const ArchivedProjectsScreenManager();
      } else if (fromBottomNav == 4) {
        return ArchivedProjectDetailsManager(
            archivedOrProject: false, fromProject: true);
      } else if (fromBottomNav == 5) {
        return ProjectDetailsPageManager(
          createProject: createProject,
          projectId: projectId!,
          archiveProject: archiveProject,
        );
      }
    } else if (index == 2) {
      return const TimeSheetPageManager();
    } else if (index == 3) {
      return const ProfilePageManager();
    }
    notifyListeners();
  }

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

  /// all archive projects!!!!!!!!
  ///

  AllArchiveProjectsResponse? allArchiveProjectsResponse;

  Future<void> allArchiveProjects(BuildContext context) async {
    setState(ViewState.busy);
    try{
      var model = await api.allArchiveProjects(context);
      if(model.success == true){
        allArchiveProjectsResponse = model;
      }
      setState(ViewState.idle);
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }
}
