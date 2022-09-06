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
  String projectId;
  ProjectSettingsPageManager({Key? key, required this.fromProjectOrCreateProject,required this.projectId}) : super(key: key);
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
                      ? hoursWidget(context, provider)
                      : managerSetting(context),
                  SizedBox(
                    height: DimensionConstants.d22.h,
                  ),
                  afterHourRateWidget(context, provider, fromProjectOrCreateProject),
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                  breakWidget(context, provider),
                  SizedBox(
                    height: DimensionConstants.d8.h,
                  ),
                  addBreakButton(context, onBreakButtonTapped: () {
                    provider.breakWidget.length == 2
                        ? ""
                        : provider.addIndexToList();
                  }),
                  SizedBox(
                    height: DimensionConstants.d26.h,
                  ),
                  roundTimeSheet(context,provider),
                  SizedBox(
                    height: DimensionConstants.d30.h,
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
                        provider.projectSettingsApi(context, projectId);
                    // Navigator.pushNamed(
                    //     context, RouteConstants.projectDetailsPageManager,
                    //     arguments: ProjectDetailsPageManager(
                    //       createProject: true,
                    //     ));
                  }),
                  SizedBox(
                    height: DimensionConstants.d40.h,
                  ),
                  fromProjectOrCreateProject != true
                      ? buttonsWidget(context)
                      : Container(),
                  SizedBox(
                    height: fromProjectOrCreateProject != true
                        ? DimensionConstants.d50.h
                        : DimensionConstants.d1.h,
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

Widget afterHourRateWidget(BuildContext context,
    ProjectSettingsManagerProvider provider, bool fromProjectOrCreateProject) {
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
      Container(
        width: DimensionConstants.d343.w,
        height: DimensionConstants.d45.h,
        decoration: BoxDecoration(
            color: ColorConstants.grayF2F2F2,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            child: DropdownButton(
              menuMaxHeight: DimensionConstants.d400.h,
              icon: Padding(
                padding: EdgeInsets.only(
                    right: DimensionConstants.d16.w,
                    top: DimensionConstants.d10.h,
                    bottom: DimensionConstants.d10.h),
                child: ImageView(
                  path: ImageConstants.downArrowIcon,
                  width: DimensionConstants.d16.w,
                  height: DimensionConstants.d16.h,
                ),
              ),
              hint: Padding(
                padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                child: const Text("None").regularText(
                    context, DimensionConstants.d14.sp, TextAlign.center),
              ),
              //  menuMaxHeight: DimensionConstants.d414.h,
              value: provider.dropDownValue,
              items: provider.vehicles.map((vehicleName) {
                return DropdownMenuItem(
                    onTap: () {},
                    value: vehicleName,
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: DimensionConstants.d10.w),
                        child: Text(vehicleName.toString()).regularText(context,
                            DimensionConstants.d14.sp, TextAlign.center)));
              }).toList(),
              onChanged: (String? value) {
                provider.onSelected(value);
              },
            ),
          ),
        ),
      ),
      fromProjectOrCreateProject == false
          ? Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
              child: Transform.scale(
                scale: 1.3,
                child: CheckboxListTile(
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d8.r)),
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d8.r)),
                  title: Transform.translate(
                    offset: const Offset(-20, 0),
                    child:
                        Text("notify_me_if_crew_is_checked_in_after_hours".tr())
                            .regularText(context, DimensionConstants.d11.sp,
                                TextAlign.left),
                  ),
                  value: provider.value,
                  onChanged: (newValue) {
                    provider.updateValue(newValue!);
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
            )
          : Container(),
    ],
  );
}

Widget breakWidget(
    BuildContext context, ProjectSettingsManagerProvider provider) {
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
          Container(
              height: DimensionConstants.d60.h,
              width: DimensionConstants.d400.w,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: DimensionConstants.d5.h),
                      child: Row(
                        children: <Widget>[
                          hoursContainerBreakTimeTo(
                              context,
                              DimensionConstants.d45.h,
                              DimensionConstants.d130.w,
                              provider,
                              index),
                          Expanded(child: Container()),
                          Text("to").regularText(context,
                              DimensionConstants.d14.sp, TextAlign.left,
                              color: ColorConstants.darkGray4F4F4F),
                          Expanded(child: Container()),
                          hoursContainerBreakTimeOnTime(
                              context,
                              DimensionConstants.d45.h,
                              DimensionConstants.d130.w,
                              provider,
                              index),
                          SizedBox(
                            width: DimensionConstants.d15.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.removeImageFromList(index);
                            },
                            child: const ImageView(
                              path: ImageConstants.subtractIcon,
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
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
          const ImageView(
            path: ImageConstants.downArrowIcon,
          ),
        ],
      ),
    ),
  );
}

/*Widget hoursContainerBreakTimeForm(BuildContext context, double height, double width, String filedName, ProjectSettingsManagerProvider provider) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        child: DropdownButton(
          menuMaxHeight: DimensionConstants.d400.h,
          icon: Padding(
            padding: EdgeInsets.only(
                right: DimensionConstants.d16.w,
                top: DimensionConstants.d10.h,
                bottom: DimensionConstants.d10.h),
            child: ImageView(
              path: ImageConstants.downArrowIcon,
              width: DimensionConstants.d16.w,
              height: DimensionConstants.d16.h,
            ),
          ),
          hint: Padding(
            padding: EdgeInsets.only(left: DimensionConstants.d10.w),
            child: const Text("None").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          //  menuMaxHeight: DimensionConstants.d414.h,
          value: provider.dropDownValueFromTime,
          items: provider.fromTimeListPM.map((vehicleName) {
            return DropdownMenuItem(
                onTap: () {},
                value: vehicleName,
                child: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: Text(vehicleName.toString()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center)));
          }).toList(),
          onChanged: (String? value) {
            provider.onSelectedFromValue(value);
          },
        ),
      ),
    ),
  );
}*/

Widget hoursContainerBreakTimeTo(BuildContext context, double height,
    double width, ProjectSettingsManagerProvider provider, int index) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        child: DropdownButton(
          menuMaxHeight: DimensionConstants.d400.h,
          icon: Padding(
            padding: EdgeInsets.only(
                right: DimensionConstants.d16.w,
                top: DimensionConstants.d10.h,
                bottom: DimensionConstants.d10.h),
            child: ImageView(
              path: ImageConstants.downArrowIcon,
              width: DimensionConstants.d16.w,
              height: DimensionConstants.d16.h,
            ),
          ),
          hint: Padding(
            padding: EdgeInsets.only(left: DimensionConstants.d10.w),
            child: const Text("None").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          //  menuMaxHeight: DimensionConstants.d414.h,
          value: provider.dropDownValueFromTimeBreakTime,
          items: provider.fromTimeListBreakTime.map((vehicleName) {
            return DropdownMenuItem(
                onTap: () {
                 provider.breakWidgetBreakTime = vehicleName;
                },
                value: vehicleName,
                child: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: Text(vehicleName.toString()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center)));
          }).toList(),
          onChanged: (String? value) {
            provider.onSelectedFromValueBreakTime(value);
          },
        ),
      ),
    ),
  );
}

Widget hoursContainerBreakTimeOnTime(BuildContext context, double height,
    double width, ProjectSettingsManagerProvider provider, int index) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        child: DropdownButton(
          menuMaxHeight: DimensionConstants.d400.h,
          icon: Padding(
            padding: EdgeInsets.only(
                right: DimensionConstants.d13.w,
                top: DimensionConstants.d10.h,
                bottom: DimensionConstants.d10.h),
            child: ImageView(
              path: ImageConstants.downArrowIcon,
              width: DimensionConstants.d16.w,
              height: DimensionConstants.d16.h,
            ),
          ),
          hint: Padding(
            padding: EdgeInsets.only(left: DimensionConstants.d10.w),
            child: const Text("None").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          //  menuMaxHeight: DimensionConstants.d414.h,
          value: provider.dropDownValueFromTimeBreakOnTime,
          items: provider.fromTimeListAMOnTime.map((vehicleName) {
            return DropdownMenuItem(
                onTap: () {
                 provider.breakWidgetBreakTimeToTime = vehicleName;
                },
                value: vehicleName,
                child: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: Text(vehicleName.toString()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center)));
          }).toList(),
          onChanged: (String? value) {
            provider.onSelectedFromValueBreakOnTime(value);
          },
        ),
      ),
    ),
  );
}

Widget hoursDropDownFrom(BuildContext context, double height, double width,
    String filedName, ProjectSettingsManagerProvider provider) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        child: DropdownButton(
          menuMaxHeight: DimensionConstants.d400.h,
          icon: Padding(
            padding: EdgeInsets.only(
                right: DimensionConstants.d16.w,
                top: DimensionConstants.d10.h,
                bottom: DimensionConstants.d10.h),
            child: ImageView(
              path: ImageConstants.downArrowIcon,
              width: DimensionConstants.d16.w,
              height: DimensionConstants.d16.h,
            ),
          ),
          hint: Padding(
            padding: EdgeInsets.only(left: DimensionConstants.d10.w),
            child: const Text("None").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          //  menuMaxHeight: DimensionConstants.d414.h,
          value: provider.dropDownValueFromTime,
          items:  provider.fromTimeListPM.map((vehicleName) {
            return DropdownMenuItem(
                onTap: () {
                  provider.endingHours = vehicleName;
                },
                value: vehicleName,
                child: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: Text(vehicleName.toString()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center)));
          }).toList(),
          onChanged: (String? value) {
            provider.onSelectedFromValue(value);
          },
        ),
      ),
    ),
  );
}

Widget hoursDropDownTo(BuildContext context, double height, double width,
    String filedName, ProjectSettingsManagerProvider provider) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: DropdownButtonHideUnderline(
      child: ButtonTheme(
        child: DropdownButton(
          menuMaxHeight: DimensionConstants.d400.h,
          icon: Padding(
            padding: EdgeInsets.only(
                right: DimensionConstants.d16.w,
                top: DimensionConstants.d10.h,
                bottom: DimensionConstants.d10.h),
            child: ImageView(
              path: ImageConstants.downArrowIcon,
              width: DimensionConstants.d16.w,
              height: DimensionConstants.d16.h,
            ),
          ),
          hint: Padding(
            padding: EdgeInsets.only(left: DimensionConstants.d10.w),
            child: const Text("None").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          //  menuMaxHeight: DimensionConstants.d414.h,
          value: provider.dropDownValueToTime,
          items: provider.fromTimeListAM.map((vehicleName) {
            return DropdownMenuItem(
                onTap: () {
                provider.startingHour = vehicleName;
                },
                value: vehicleName,
                child: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: Text(vehicleName.toString()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center)));
          }).toList(),
          onChanged: (String? value) {
            provider.onSelectedToValue(value);
          },
        ),
      ),
    ),
  );
}

Widget hoursWidget(
    BuildContext context, ProjectSettingsManagerProvider provider) {
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
          hoursDropDownTo(context, DimensionConstants.d45.h,
              DimensionConstants.d142.w, "5:00 PM", provider),
          Expanded(child: Container()),
          Text("to").regularText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              color: ColorConstants.darkGray4F4F4F),
          Expanded(child: Container()),
          hoursDropDownFrom(context, DimensionConstants.d45.h,
              DimensionConstants.d142.w, "9:00 AM", provider),
        ],
      ),
    ],
  );
}

Widget addBreakButton(BuildContext context,
    {required VoidCallback onBreakButtonTapped}) {
  return GestureDetector(
    onTap: onBreakButtonTapped,
    child: Container(
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
    ),
  );
}

Widget roundTimeSheet(BuildContext context, ProjectSettingsManagerProvider provider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("round_timesheets_to_nearest".tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.deepBlue),
      SizedBox(
        height: DimensionConstants.d10.h,
      ),
      roundTimeSheetList(context,provider),
    ],
  );
}

Widget roundTimeSheetList(BuildContext context,ProjectSettingsManagerProvider provider) {
  return Container(
    height: DimensionConstants.d105.h,
    width: DimensionConstants.d400.w,
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 130,
            childAspectRatio: 10 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: provider.roundTimeSheet.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              provider.selectedIndex = index;
              provider.updateLoadingStatus(true);
            },
            child: Container(
              width: DimensionConstants.d109.w,
              height: DimensionConstants.d45.h,
              decoration: BoxDecoration(
                  color: ColorConstants.grayF2F2F2,
                  border: Border.all(
              color: provider.selectedIndex == index
                  ? (Theme.of(context).brightness ==
                  Brightness.dark
                  ? ColorConstants.primaryColor
                  : ColorConstants.colorBlack)
                : ColorConstants.colorLightGreyF2,
            width: 1),
                  borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
              child: Center(
                child: Text(provider.roundTimeSheet[index]).regularText(
                    context, DimensionConstants.d14.sp, TextAlign.center,
                    color: ColorConstants.deepBlue),
              ),
            ),
          );
        }),
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
