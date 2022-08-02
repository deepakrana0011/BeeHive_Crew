import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/view/introduction/beehive_introduction.dart';
import 'package:beehive/widget/introduction_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IntroductionProvider extends BaseProvider{
  List<Widget> introWidgetsList = [];

  void setUpIntroductionList(){
    introWidgetsList=<Widget>[
      BeeHiveIntroduction(),
      IntroductionWidget(
          image: ImageConstants.introduction1,
          title: "easy_tracking".tr(),
          subText: "easily_tracking_your_crew".tr()),
      IntroductionWidget(
          image: ImageConstants.introduction2,
          title: "instant_timesheets".tr(),
          subText: "effortlessly_create_and_manage".tr()),
      IntroductionWidget(
          image: ImageConstants.introduction3,
          title: "save_time".tr(),
          subText: "automatically_track_and_calculate".tr()),
      IntroductionWidget(
          image: ImageConstants.introduction4,
          title: "intuitive_timesheets".tr(),
          subText: "in_depth_timesheets".tr()),
    ];
  }
}