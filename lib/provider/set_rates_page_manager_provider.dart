import 'dart:io';

import 'package:beehive/locator.dart';
import 'package:beehive/model/create_project_request.dart';
import 'package:beehive/model/get_assinged_crew_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';
import '../views_manager/projects_manager/project_setting_page_manager.dart';

class SetRatesPageManageProvider extends BaseProvider {
  final singleRateController = TextEditingController();
  CreateProjectRequest createProjectRequest = locator<CreateProjectRequest>();
  List<TextEditingController>? myController;

  GetAssignedCrewInProject? assignedCrewInProject;
  bool isSameRate = false;

  void updateSwitcherStatus(
    bool value,
  ) {
    isSameRate = value;
    notifyListeners();
  }

  clearControllers(List<TextEditingController> controllers) {
    singleRateController.text = "";
    controllers;
    notifyListeners();
  }

  void navigateToNextPage(BuildContext context) {
    if (isSameRate) {
      if (singleRateController.text.trim().isEmpty) {
        DialogHelper.showMessage(context, "Please enter the crew hourly rate");
      } else {
        createProjectRequest.sameRate = singleRateController.text;
        Navigator.pushNamed(context, RouteConstants.projectSettingsPageManager,
            arguments:
                ProjectSettingsPageManager(fromProjectOrCreateProject: true));
      }
    } else {
      var index =
          myController!.indexWhere((element) => element.text.trim().isEmpty);
      if (index == -1) {
        List<ProjectRate> projectList = [];
        for (int i = 0; i < myController!.length; i++) {
          ProjectRate value = ProjectRate();
          value.crewId = createProjectRequest.selectedCrewMember![i].id;
          value.price = myController![i].text;
          projectList.add(value);
        }
        createProjectRequest.projectRate = projectList;
        Navigator.pushNamed(context, RouteConstants.projectSettingsPageManager,
            arguments:
                ProjectSettingsPageManager(fromProjectOrCreateProject: true));
      } else {
        DialogHelper.showMessage(
            context, "Please enter the hourly rate for all crew members");
      }
    }
  }
}
