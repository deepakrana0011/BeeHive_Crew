import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/material.dart';

class TimeSheetTabBarProviderCrew extends BaseProvider{

  TabController? controller;
  List<Widget> widgetlist=[];
  List<int> hoursList=[60,30,240,80,60];

  getWidget(){
    for(int i=0;i<hoursList.length;i++){
      widgetlist.add(Flexible(flex: hoursList[i],child: Container(height:5,color: i%2==0?Colors.green:Colors.grey,),));
    }
  }

}

