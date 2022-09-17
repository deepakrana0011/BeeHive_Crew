import 'dart:async';
import 'dart:io';

import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/check_box_model_crew.dart';
import 'package:beehive/model/check_in_response_crew.dart';
import 'package:beehive/model/check_out_response_crew.dart';
import 'package:beehive/model/dash_board_page_response_crew.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/widget/get_time.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../model/crew_dashboard_response.dart';
import '../services/fetch_data_expection.dart';

class DashboardProvider extends BaseProvider{
  String projectName = '';
  bool checkedInNoProjects = false;
  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;
  bool noProject = true;
  AllCheckIns? checkInDetail;
  int? hours;
  String? hourOut;
  String? minOut;
  String? amPm;
  String? min;
  String? time;
  TimeOfDay? selectedTime ;
  TimeOfDay initialTime = TimeOfDay.now();
  List<CheckBoxModelCrew> checkInItems = [];
  int hour =0;
  int minutes =0;
  int timerHour = 0;
  int minuteCount = 0;
  Timer? timer;
  String? selectedCheckOutTime;

  String assignProjectId ="";
  String? checkInTime;
  String? checkOutTime;
  bool notCheckedIn = true;
  String checkIn = "";
  String? firstDate;
  String? secondDate;
  List<AllCheckIns> key=[];
  CrewDashboardResponse? crewResponse;
  String? currentCheckInProjectId;
  List<int> hoursList=[];
  List<Widget> widgetList=[];
  List<String> projectNameInitials =[];
  DateTime initialDay1 =DateTime.now();
  DateTime initialDay2 =DateTime.now().subtract(const Duration(days:7));
  String? initialDate;
  String? day;
  String? month;
  String? year;


  updateNoProject(){
    noProject = !noProject;
    notifyListeners();

  }

  updateDropDownValueOfCheckBox(val){
    checkIn = val;
    notifyListeners();
  }

  updateNotChecked(){
    notCheckedIn = !notCheckedIn;
    notifyListeners();
  }

  getCheckInTime(){
    checkInTime =  DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    notifyListeners();
  }


   getCheckOutTimeWithCurrentDate(String time){
     DateTime date= DateTime.now();
     day=date.day<10 ? "0${date.day}": date.day.toString();
     month=date.month<10 ? "0${date.month}": date.month.toString();
     year=date.year.toString();
     checkOutTime=  "$year-$month-$day $time";
   }


  convertTime(String timeToConvert){
     DateTime time = DateTime.parse(timeToConvert);
     hour = time.hour;
     minutes = time.minute;
     notifyListeners();
  }

  getTimeDifferenceBetweenTime( String timeDifference){
    DateTime time = DateTime.parse(timeDifference);
    var getDifference = time.difference(DateTime.now()).inHours;
    print(getDifference);
  }


  twoMinTimer() {
    timer = Timer.periodic(
      const Duration(minutes: 1), (timer) {
        minuteCount++;
        if(minuteCount == 60){
          timerHour +1;
          minuteCount = 0;
        }
     notifyListeners();
      },
    );
  }

  Future getDashBoardData(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.dashBoardApi(context,);
      if (model.success??false) {
        crewResponse= model;
        if(model.lastCheckIn!.isNotEmpty) {
          convertTime(model.lastCheckIn![0].checkInTime!);
        }
        checkInItems = [];
        for(int i =0; i<model.myProject!.length ; i++){
        var crewModel = CheckBoxModelCrew();
          crewModel.projectId = model.myProject![i].projectId!.sId!;
          crewModel.projectName = model.myProject![i].projectId!.projectName;
          checkInItems.add(crewModel);
        }
         //key = (model.allCheckIns!.where((checkOutTime) => checkInTime==null).toList());

        var index=model.allCheckIns!.indexWhere((element) => element.checkOutTime==null);
        if(index!=-1){
          checkInDetail=model.allCheckIns![index];
          currentCheckInProjectId=model.allCheckIns![index].sId;
          SharedPreference.prefs!.setInt(SharedPreference.IS_CHECK_IN, 1);
        }else
          {SharedPreference.prefs!.setInt(SharedPreference.IS_CHECK_IN, 0);
        }
        for (int i = 0; i < model.today!.length; i++) {
          if (model.today![i].projectId!.projectName!= '') {
            getInitials(
                string: model.today![i].projectId!.projectName!,
                limitTo: 1);
          } else {
            getInitials(string: "No Project", limitTo: 2);
          }
        }
        checkIn = model.myProject!.isEmpty?"":model.myProject![0].projectId!.projectName!;
        convertTime(model.lastCheckIn!.isEmpty ? DateTime.now().toString():model.lastCheckIn![0].checkInTime!);
        getTimeDifferenceBetweenTime(model.lastCheckIn!.isEmpty ? DateTime.now().toString():model.lastCheckIn![0].checkInTime!);
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
  Future checkInApi( context,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.checkInApi(context,assignProjectId, checkInTime!);
      if (model.success == true) {
          checkInResponse = model;
          SharedPreference.prefs!.setInt(SharedPreference.IS_CHECK_IN, 2);
          twoMinTimer();
          getDashBoardData(context);
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
 bool? isCheckOut;
  Future checkOutApi( context,) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.checkOutApiCrew(context,currentCheckInProjectId!, checkOutTime!);

      if (model.success == true) {
        isCheckOut=true;
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

  Future weeklyDataApi(context) async {
    setState(ViewState.busy);
    try {
      var model = await apiCrew.weeklyChekIn(context, GetTime.formattedDate(initialDay1), GetTime.formattedDate(initialDay2));
      if (model.success == true) {
        isCheckOut=true;
        setState(ViewState.idle);
        //DialogHelper.showMessage(context, model.message!);
      } else {
        setState(ViewState.idle);
       // DialogHelper.showMessage(context, model.message!);
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }
   timeWidget(BuildContext context){
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstants.primaryColor,
              onSurface: ColorConstants.primaryColor,

            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.green,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
  timeToSend( context) async{
    selectedTime= await timeWidget(context);
      hours=(selectedTime!.hour<12?selectedTime!.hour:(selectedTime!.hour-12));
      hourOut=(hours! < 10? "0${hours}": hours).toString();
      min=selectedTime!.minute<10 ? "0${selectedTime!.minute}": selectedTime!.minute.toString();
      time="${selectedTime!.hour < 10? "0${selectedTime!.hour}": selectedTime!.hour}:${min}:00";
      selectedCheckOutTime =  "${hourOut}:${min} "+ GetTime.hoursAM(selectedTime!);
      // getCheckOutTime(selectedCheckOutTime!);
      getCheckOutTimeWithCurrentDate(time!);
      DateTime checkInDate =  DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkInDetail!.checkInTime!);
      DateTime checkOutDate =  DateFormat("yyyy-MM-dd hh:mm:ss").parse(checkOutTime!);
    if(checkOutDate.isAfter(checkInDate)){
      print("DT1 is after DT2");
      Navigator.pop(context);
      checkOutApi(context).then((value) {getDashBoardData(context);});
      getCheckOutSelectedTime();
      notifyListeners();
      print(selectedTime);
    }
    else{
      DialogHelper.showMessage(context, "Checkout time Cannot before checkIn");
    }


  }

 /* showTime( context) async {
    selectedTime = await
    showTimePicker(
      context: context,
      confirmText: "ok",
      initialTime: initialTime,
    );
    hours=(selectedTime!.hour<12?selectedTime!.hour:(selectedTime!.hour-12));
    hourOut=(hours! < 10?
    "0${hours}":
    hours).toString();
    min=selectedTime!.minute<10 ?
    "0${selectedTime!.minute}":
    selectedTime!.minute.toString();
    time="${hourOut}:${min}";
    selectedCheckOutTime =  "${hourOut}:${min} "+ GetTime.hoursAM(selectedTime!);
    getCheckOutTime(selectedCheckOutTime!);
    Navigator.pop(context);
    checkOutApi(context).then((value) {dashBoardApi(context);});
    getCheckOutSelectedTime();
    notifyListeners();
    print(selectedTime);
  }*/

  getCheckOutSelectedTime(){
     selectedCheckOutTime = selectedCheckOutTime == null?
     ("${initialTime.hour<12?initialTime.hour:(initialTime.hour-12)}:${initialTime.minute} "+GetTime.hoursAM(initialTime))
         : ("${hours}:${min} "+ GetTime.hoursAM(selectedTime!));
     notifyListeners();
   }


  getWidget(){
    for(int i=0;i<hoursList.length;i++){
      widgetList.add(Flexible(flex: hoursList[i],child: Container(height:5,color: i%2==0?Colors.green:Colors.grey,),));
    }
  }

  nextWeekDates(){
    initialDay1=initialDay1.add(const Duration(days: 7));
    initialDay2=initialDay2.add(const Duration(days: 7));
    firstDate=GetTime.formattedDate(initialDay1.add(const Duration(days: 7)));
    secondDate=GetTime.formattedDate(initialDay2.add(const Duration(days: 7)));
    notifyListeners();
  }
  previousWeekDates(){
    initialDay1=initialDay1.subtract(const Duration(days: 7));
    initialDay2=initialDay2.subtract(const Duration(days: 7));
    firstDate=GetTime.formattedDate(initialDay1.subtract(const Duration(days: 7)));
    secondDate=GetTime.formattedDate(initialDay2.subtract(const Duration(days: 7)));
      notifyListeners();
  }


  getInitials({required String string,required int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0 ; i < (split.length > 1? limitTo:split.length); i ++) {
      buffer.write(split[i][0]);
    }
    projectNameInitials.add(buffer.toString());
  }

}
