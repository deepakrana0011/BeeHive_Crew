import 'dart:io';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../enum/enum.dart';
import '../helper/date_function.dart';
import '../helper/dialog_helper.dart';
import '../model/get_crew_response_time_sheet.dart';
import '../model/project_working_hour_detail.dart';
import '../services/fetch_data_expection.dart';

class TimeSheetFromCrewProvider extends BaseProvider{
 String? firstDate;
 String? secondDate;
 int? totalHours;
 DateTime? selectedStartDate = DateTime.now();
 DateTime? selectedEndDate = DateTime.now();
 String? weekFirstDate;
 String? weekEndDate;
 GetCrewResponseTimeSheet? crewResponse;
  int selectIndex = 0;
  indexCheck(int value){
    selectIndex=value;
    notifyListeners();
  }

  void doNothing(BuildContext context) {}
  TabController? controller;


  Future<void> getCrewDataTimeSheet(context, String id) async {
    setState(ViewState.busy);
    try{
      var model = await api.getCrewDataTimeSheet(context,id,firstDate!, secondDate!);
      if(model.success == true){
        crewResponse = model;
        for(int i = 0; i < model.projectData!.length ; i++){
          totalHours = model.projectData![i].checkins![0].hoursDiff;
        }
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





 String getTotalHoursOnProjects(List<ProjectDatum>? projectData) {
   var totalMinutes = 0;
   for (var element in projectData!) {
     if(element.checkins![0].hoursDiff != null){
       totalMinutes = totalMinutes + element.checkins![0].hoursDiff!;
     }
   }
   var totalHours = DateFunctions.minutesToHourString(totalMinutes);
   return totalHours;
 }

 void previousWeekDays(int numberOfDays) {
   selectedEndDate = selectedStartDate!.subtract(const Duration(days: 1));
   var newDate = selectedEndDate!.subtract(Duration(days: numberOfDays));
   selectedStartDate = newDate;
   firstDate = DateFormat("yyyy-MM-dd").format(selectedStartDate!);
   secondDate = DateFormat("yyyy-MM-dd").format(selectedEndDate!);
   weekFirstDate = DateFunctions.getMonthDay(selectedStartDate!);
   weekEndDate = DateFunctions.getMonthDay(selectedEndDate!);
   customNotify();
 }

 void nextWeekDays(int numberOfDays) {
   if (selectedEndDate == null) {
     selectedStartDate = DateTime.now().subtract(Duration(days: numberOfDays));
     selectedEndDate = DateTime.now();
   } else {
     selectedStartDate = selectedEndDate!.add(const Duration(days: 1));
     var newDate = selectedEndDate!.add(Duration(days: numberOfDays));
     if (newDate.isAfter(DateTime.now())) {
       selectedEndDate = DateTime.now();
     } else {
       selectedEndDate = newDate;
     }
   }
   firstDate = DateFormat("yyyy-MM-dd").format(selectedStartDate!);
   secondDate = DateFormat("yyyy-MM-dd").format(selectedEndDate!);

   weekFirstDate = DateFunctions.getMonthDay(selectedStartDate!);
   weekEndDate = DateFunctions.getMonthDay(selectedEndDate!);
   customNotify();
 }

 List<ProjectWorkingHourDetail> getTimeForStepper(Checkin detail) {
   List<Interuption> timeString = [];
   List<ProjectWorkingHourDetail> projectWorkingHourList = [];
   for (int i = 0; i < detail.checkinBreak!.length; i++) {
     if (detail.checkinBreak![i].startTime?.toLowerCase() != "Any Time".toLowerCase()) {
       var breakStartTimeString = detail.checkInTime!.substring(0, 10) + " " + detail.checkinBreak![i].startTime!.replaceAll("PM", "").replaceAll("AM", "");
       var breakEndTimeString = detail.checkInTime!.substring(0, 10) + " " + DateFunctions.stringToDateAddMintues(detail.checkinBreak![i].startTime!, int.parse(detail.checkinBreak![i].interval!.substring(0, 2)));
       var breakStartTimeDate = DateFunctions.getDateTimeFromString(breakStartTimeString);
       var checkInDate = DateFunctions.getDateTimeFromString(detail.checkInTime!);
       var checkOutDate = DateFunctions.getDateTimeFromString(detail.checkOutTime!);
       if (breakStartTimeDate.isAfter(checkInDate) && breakStartTimeDate.isBefore(checkOutDate)) {
         var interruption = Interuption();
         interruption.startTime = breakStartTimeString;
         interruption.endTime = breakEndTimeString;
         interruption.selfMadeInterruption = true;
         timeString.add(interruption);
       }
     }
   }
   if (detail.interuption!.length > 0) {timeString.addAll(detail.interuption!);}

   timeString.sort((a, b) {
     var aValue = DateFunctions.getDateTimeFromString(a.startTime!);
     var bValue = DateFunctions.getDateTimeFromString(b.startTime!);
     return aValue.compareTo(bValue);
   });

   print("data sorted ${timeString}");

   if (timeString.length > 0) {
     var checkInDate =
     DateFunctions.getDateTimeFromString(detail.checkInTime!);
     var checkInDateString = detail.checkInTime!;
     for (var value in timeString) {
       var breakStartTime =
       DateFunctions.getDateTimeFromString(value.startTime!);
       var breakEndTime = DateFunctions.getDateTimeFromString(value.endTime!);
       var workingMinutesDifference =
           breakStartTime.difference(checkInDate).inMinutes;
       projectWorkingHourList.add(ProjectWorkingHourDetail(
           startTime: checkInDateString,
           endTime: value.startTime!,
           timeInterval: workingMinutesDifference.abs(),
           type: 1));

       var breakMinutesDifference =
           breakEndTime.difference(breakStartTime).inMinutes;
       if (value.selfMadeInterruption!) {
         projectWorkingHourList.add(ProjectWorkingHourDetail(
             startTime: value.startTime!,
             endTime: value.endTime!,
             timeInterval: breakMinutesDifference.abs(),
             type: 2));
       } else {
         projectWorkingHourList.add(ProjectWorkingHourDetail(
             startTime: value.startTime!,
             endTime: value.endTime!,
             timeInterval: breakMinutesDifference.abs(),
             type: 3));
       }
       checkInDate = breakEndTime;
       checkInDateString = value.endTime!;
     }

     var checkOutDate =
     DateFunctions.getDateTimeFromString(detail.checkOutTime!);
     var checkOutDateString = detail.checkOutTime!;
     var workingMinutesDifference =
         checkInDate.difference(checkOutDate).inMinutes;
     projectWorkingHourList.add(ProjectWorkingHourDetail(
         startTime: checkInDateString,
         endTime: checkOutDateString,
         timeInterval: workingMinutesDifference,
         type: 1));
   } else {
     var checkInString = detail.checkInTime!;
     var checkOutString = detail.checkOutTime!;
     projectWorkingHourList.add(ProjectWorkingHourDetail(
         startTime: checkInString,
         endTime: checkOutString,
         timeInterval: 1,
         type: 1));
   }
   return projectWorkingHourList;
 }

 getTotalHoursRate(){
    var getPerMinutesRate = 20/60;
    var price = getPerMinutesRate * totalHours!;
    return price;
 }
 dateConvertorWeekly(String date){
   var getDate = DateTime.parse(date);
   return  DateFormat("EEE MMM, dd").format(getDate);
 }








}