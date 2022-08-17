import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/project_details_manager_provider.dart';
import 'package:beehive/provider/project_settings_manager_provider.dart';
import 'package:beehive/provider/project_settings_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/projects_manager/project_details_manager.dart';
import 'package:beehive/widget/custom_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/image_constants.dart';
import '../../helper/dialog_helper.dart';
import '../../widget/image_view.dart';

class ProjectSettingsPageManager extends StatelessWidget {
  bool fromProjectOrCreateProject;
  ProjectSettingsPageManager(
      {Key? key, required this.fromProjectOrCreateProject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProjectSettingsManagerProvider>(
      onModelReady: (provider) {
        provider.addModelToList();
      },
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "project_settings"),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: fromProjectOrCreateProject == true
                        ? DimensionConstants.d16.h
                        : DimensionConstants.d5.h,
                  ),
                  fromProjectOrCreateProject == true
                      ? workDaysWidget(context, provider)
                      : notificationSwitcher(context, provider),
                  SizedBox(
                    height: DimensionConstants.d22.h,
                  ),
                  fromProjectOrCreateProject == true
                      ? hoursWidget(context)
                      : managerSetting(context),
                  SizedBox(
                    height: DimensionConstants.d22.h,
                  ),
                  breakWidget(context),
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                  roundTimeWidget(context),
                  SizedBox(
                    height: DimensionConstants.d8.h,
                  ),
                  addBreakButton(context),
                  SizedBox(
                    height: DimensionConstants.d26.h,
                  ),
                  roundTimeSheet(context),
                  SizedBox(
                    height: DimensionConstants.d40.h,
                  ),
                  CommonWidgets.commonButton(
                      context,
                      fromProjectOrCreateProject == true
                          ? "create_project".tr()
                          : "save".tr(),
                      color1: ColorConstants.primaryGradient2Color,
                      color2: ColorConstants.primaryGradient1Color,
                      fontSize: DimensionConstants.d16.sp,
                      shadowRequired: true, onBtnTap: () {
                    Navigator.pushNamed(
                        context, RouteConstants.projectDetailsPageManager,
                        arguments: ProjectDetailsPageManager(
                          createProject: true,
                        ));
                  }),
                  SizedBox(
                    height: DimensionConstants.d26.h,
                  ),
                fromProjectOrCreateProject != true?  buttonsWidget(context):Container(),
                  SizedBox(
                    height:fromProjectOrCreateProject != true? DimensionConstants.d50.h:DimensionConstants.d1.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget workDaysWidget(
    BuildContext context, ProjectSettingsManagerProvider provider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('work_days'.tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      Container(
        height: DimensionConstants.d55.h,
        width: DimensionConstants.d370.w,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.weekDays.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d3.w),
                child: GestureDetector(
                  onTap: () {
                    provider.updateColor(index);
                  },
                  child: Container(
                    height: DimensionConstants.d45.h,
                    width: DimensionConstants.d45.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: provider.weekDays[index].selected != false
                              ? ColorConstants.colorBlack
                              : ColorConstants.grayF2F2F2,
                          width: DimensionConstants.d2.w),
                      color: ColorConstants.grayF2F2F2,
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d8.r),
                    ),
                    child: Center(
                      child: provider.weekDays[index].selected != false
                          ? Text(provider.weekDays[index].day!).boldText(
                              context,
                              DimensionConstants.d14.sp,
                              TextAlign.center,
                              color: ColorConstants.deepBlue)
                          : Text(provider.weekDays[index].day!).regularText(
                              context,
                              DimensionConstants.d14.sp,
                              TextAlign.center,
                              color: ColorConstants.deepBlue),
                    ),
                  ),
                ),
              );
            }),
      )
    ],
  );
}

Widget breakWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('after_hours_rate'.tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d7.h,
      ),
      Text('increase_pay_text'.tr()).regularText(
          context, DimensionConstants.d14.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      hoursContainer(
          context, DimensionConstants.d45.h, DimensionConstants.d343.w, "None"),
    ],
  );
}

Widget roundTimeWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("breaks".tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d3.h,
      ),
      Text("automatically_applied_to_timesheets".tr()).regularText(
          context, DimensionConstants.d14.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              hoursContainer(context, DimensionConstants.d45.h,
                  DimensionConstants.d130.w, "9:00 AM"),
              Expanded(child: Container()),
              Text("to").regularText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: ColorConstants.darkGray4F4F4F),
              Expanded(child: Container()),
              hoursContainer(context, DimensionConstants.d45.h,
                  DimensionConstants.d130.w, "5:00 PM"),
              SizedBox(
                width: DimensionConstants.d15.w,
              ),
              ImageView(
                path: ImageConstants.subtractIcon,
              ),
            ],
          ),
          SizedBox(
            height: DimensionConstants.d8.h,
          ),
          Row(
            children: <Widget>[
              hoursContainer(context, DimensionConstants.d45.h,
                  DimensionConstants.d130.w, "9:00 AM"),
              Expanded(child: Container()),
              Text("to").regularText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: ColorConstants.darkGray4F4F4F),
              Expanded(child: Container()),
              hoursContainer(context, DimensionConstants.d45.h,
                  DimensionConstants.d130.w, "5:00 PM"),
              SizedBox(
                width: DimensionConstants.d15.w,
              ),
              ImageView(
                path: ImageConstants.subtractIcon,
              ),
            ],
          ),
        ],
      )
    ],
  );
}

Widget hoursContainer(
    BuildContext context, double height, double width, String filedName) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Row(
        children: <Widget>[
          Text(filedName).regularText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              color: ColorConstants.deepBlue),
          Expanded(child: Container()),
          ImageView(
            path: ImageConstants.downArrowIcon,
          ),
        ],
      ),
    ),
  );
}

Widget hoursWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("hours".tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      Row(
        children: [
          hoursContainer(context, DimensionConstants.d45.h,
              DimensionConstants.d142.w, "9:00 AM"),
          Expanded(child: Container()),
          Text("to").regularText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              color: ColorConstants.darkGray4F4F4F),
          Expanded(child: Container()),
          hoursContainer(context, DimensionConstants.d45.h,
              DimensionConstants.d142.w, "5:00 PM"),
        ],
      ),
    ],
  );
}

Widget addBreakButton(BuildContext context) {
  return Container(
    height: DimensionConstants.d40.h,
    width: DimensionConstants.d130,
    decoration: BoxDecoration(
      color: ColorConstants.deepBlue,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d12.w),
      child: Row(
        children: <Widget>[
          ImageView(
            path: ImageConstants.addNotesIcon,
            height: DimensionConstants.d16.h,
            width: DimensionConstants.d16.w,
          ),
          SizedBox(
            width: DimensionConstants.d7.w,
          ),
          Text("add_break".tr()).semiBoldText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              color: ColorConstants.colorWhite),
        ],
      ),
    ),
  );
}

Widget roundTimeSheet(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("round_timesheets_to_nearest".tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d10.h,
      ),
      Row(
        children: <Widget>[
          containerText(context, "5 mins", false),
          Expanded(child: Container()),
          containerText(context, "10 mins", false),
          Expanded(child: Container()),
          containerText(context, "15 mins", true),
        ],
      ),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      Row(
        children: <Widget>[
          containerText(context, "30 mins", false),
          Expanded(child: Container()),
          containerText(context, "Hour", false),
          Expanded(child: Container()),
          containerText(context, "Exact", false),
        ],
      ),
    ],
  );
}

Widget containerText(BuildContext context, String time, bool border) {
  return Container(
    width: DimensionConstants.d109.w,
    height: DimensionConstants.d45.h,
    decoration: BoxDecoration(
        color: ColorConstants.grayF2F2F2,
        border: border == true
            ? Border.all(
                color: ColorConstants.colorBlack,
                width: DimensionConstants.d2.w)
            : null,
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
    child: Center(
      child: Text(time).regularText(
          context, DimensionConstants.d14.sp, TextAlign.center,
          color: ColorConstants.deepBlue),
    ),
  );
}

Widget notificationSwitcher(
    BuildContext context, ProjectSettingsManagerProvider provider) {
  return Container(
    height: DimensionConstants.d80.h,
    decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.colorWhite,
        border: Border(
          bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.littleDarkGray,
              width: DimensionConstants.d1.w),
        )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: DimensionConstants.d24.h,
            ),
            Text("notifications".tr()).boldText(
              context,
              DimensionConstants.d16.sp,
              TextAlign.left,
            ),
            SizedBox(
              height: DimensionConstants.d6.h,
            ),
            Text("turn_on_notifications_for_this_project".tr()).regularText(
              context,
              DimensionConstants.d14.sp,
              TextAlign.left,
            ),
          ],
        ),
        Expanded(child: Container()),
        CustomSwitch(
          value: provider.status,
          onChanged: (value) {
            provider.updateSwitcherStatus(value);
          },
        ),
      ],
    ),
  );
}

Widget managerSetting(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("manager_settings".tr()).boldText(
          context, DimensionConstants.d20.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      Text("these_attributes_are_set_by_the_project".tr()).regularText(
          context, DimensionConstants.d14.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d22.h,
      ),
      Text("regular_hours".tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      Row(
        children: <Widget>[
          hoursContainer(context, DimensionConstants.d45.h,
              DimensionConstants.d142.w, "6:00 PM"),
          Expanded(child: Container()),
          Text("to").regularText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              color: ColorConstants.darkGray4F4F4F),
          Expanded(child: Container()),
          hoursContainer(context, DimensionConstants.d45.h,
              DimensionConstants.d142.w, "7:00 AM"),
        ],
      )
    ],
  );
}

Widget buttonsWidget(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d40.w),
    child: Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    DialogHelper.archiveDialogBox(
                      context,
                      cancel: () {},
                      delete: () {},
                    ));
          },
          child: Text("archive_project".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: ColorConstants.colorBlack),
        ),
        Expanded(child: Container()),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    DialogHelper.deleteDialogBoxManager(
                      context,
                      cancel: () {},
                      delete: () {},
                    ));
          },
          child: Text("delete_project".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: ColorConstants.redColorEB5757),
        )
      ],
    ),
  );
}
