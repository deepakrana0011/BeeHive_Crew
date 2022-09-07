import 'dart:io';

import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/check_box_model_crew.dart';
import 'package:beehive/model/check_in_response_crew.dart';
import 'package:beehive/model/dash_board_page_response_crew.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class DashboardProvider extends BaseProvider{
  String projectName = '';
  bool checkedInNoProjects = false;
  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;
  bool noProject = true;
  updateNoProject(){
    noProject = !noProject;
    notifyListeners();

  }
  String checkIn = "";
  updateDropDownValueOfCheckBox(val){
    checkIn = val;
    notifyListeners();
  }
  bool notCheckedIn = true;
  updateNotChecked(){
    notCheckedIn = !notCheckedIn;
    notifyListeners();
  }
  List<CheckBoxModelCrew> checkInItems = [];

  String assignProjectId ="";
  String? checkInTime;
  getCheckInTime(){
    checkInTime =  DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    notifyListeners();
  }
  int hour =0;
  int minutes =0;
  convertTime(String timeToConvert){
     DateTime time = DateTime.parse(timeToConvert);
     hour = time.hour;
     minutes = time.minute;
     notifyListeners();
  }
  getAmAndPm(int hours){
    if(hours> 12){
      return "AM";
    }else{
      return "PM";
    }


  }




DashBoardPageResponseCrew? crewResponse;

  Future dashBoardApi(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.dashBoardApi(context,);
      if (model.success == true) {
        crewResponse= model;
        for(int i =0; i<model.myProject!.length ; i++){
        var crewModel = CheckBoxModelCrew();
          crewModel.projectId = model.myProject![i].projectId!.sId!;
          crewModel.projectName = model.myProject![i].projectId!.projectName;
          checkInItems.add(crewModel);
        }
        checkIn = model.myProject![0].projectId!.projectName!;
        setState(ViewState.idle);
      } else {
        setState(ViewState.idle);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }

  CheckInResponseCrew? checkInResponse;
  Future checkInApi(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.checkInApi(context,assignProjectId, checkInTime!);
      if (model.success == true) {
        checkInResponse = model;
       SharedPreference.prefs!.setInt(SharedPreference.IS_CHECK_IN , 2);
        convertTime(model.data!.lastCheckIn!);
        setState(ViewState.idle);
        DialogHelper.showMessage(context, model.message!);
      } else {
        setState(ViewState.idle);
        DialogHelper.showMessage(context, model.message!);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }





}