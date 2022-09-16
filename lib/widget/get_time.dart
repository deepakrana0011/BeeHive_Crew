

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GetTime{

  static hoursAM(TimeOfDay hours){
    if(hours.hour < 12   ){
      return "AM";
    }else {
      return "PM";
    }
}
static  getAmAndPm(int hours){
  if(hours> 12){
    return "AM";
  }else{
    return "PM";
  }
}
static formattedDate(DateTime date){
  String yyyy=date.year.toString();
  int month=date.month;
  int day=date.day;
  String mm=(month < 10?"0$month":month).toString();
  String dd=(day < 10? "0$day":day).toString();
  return "$yyyy-$mm-$dd";
}
static getDayMonth(DateTime date){
  {
    final DateFormat formatter = DateFormat('MMMd');
    return formatter.format(date);
  }
}

}