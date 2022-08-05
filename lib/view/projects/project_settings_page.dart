import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/project_settings_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/custom_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/image_constants.dart';
import '../../helper/dialog_helper.dart';
import '../../widget/image_view.dart';

class ProjectSettingsPage extends StatelessWidget {
  const ProjectSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProjectSettingsProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "project_settings"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                notificationSwitcher(context, provider),
                managerDetails(context),
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                regularHours(context),
                SizedBox(
                  height: DimensionConstants.d32.h,
                ),
                breakWidget(context),
                SizedBox(
                  height: DimensionConstants.d25.h,
                ),
                roundTimeWidget(context),
                SizedBox(
                  height: DimensionConstants.d36.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d16.w),
                  child: CommonWidgets.commonButton(
                    context,
                    "leave_project".tr(),
                    color1: ColorConstants.redColorEB5757,
                    color2: ColorConstants.redColorEB5757,
                    fontSize: DimensionConstants.d16.sp,
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d51.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget notificationSwitcher(
    BuildContext context, ProjectSettingsProvider provider) {
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
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d17.w),
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
    ),
  );
}

Widget managerDetails(BuildContext context) {
  return Container(
    height: DimensionConstants.d140.h,
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
    child: Column(
      children: <Widget>[
        SizedBox(
          height: DimensionConstants.d15.h,
        ),
        Row(
          children: <Widget>[
            managerDetailsWidget(
              context,
            )
          ],
        )
      ],
    ),
  );
}

Widget managerDetailsWidget(
  BuildContext context,
) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorBlack
          : ColorConstants.colorWhite,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: DimensionConstants.d65.w,
                    child: ImageView(
                      path: ImageConstants.managerImage,
                      height: DimensionConstants.d50.h,
                      width: DimensionConstants.d50.w,
                    ),
                  ),
                  Positioned(
                      top: DimensionConstants.d23.h,
                      left: DimensionConstants.d35.w,
                      child: ImageView(
                        path: ImageConstants.brandIocn,
                        height: DimensionConstants.d27.h,
                        width: DimensionConstants.d29.w,
                      ))
                ],
              ),
              SizedBox(
                width: DimensionConstants.d15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Katharine Wells").boldText(
                      context, DimensionConstants.d16.sp, TextAlign.left),
                  Text("crew_manager_small".tr()).regularText(
                      context, DimensionConstants.d14.sp, TextAlign.left,
                      color: Theme.of(context).brightness == Brightness.dark?ColorConstants.colorWhite:ColorConstants.colorBlack),
                ],
              ),
              SizedBox(
                width: DimensionConstants.d32.w,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          DialogHelper.callDialogBox(
                            context,
                            photoFromCamera: () {},
                            photoFromGallery: () {},
                          ));
                },
                child: Container(
                  height: DimensionConstants.d40.h,
                  width: DimensionConstants.d102.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.deepBlue
                          : ColorConstants.deepBlue,
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d8.r),
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : Colors.transparent,
                          width: DimensionConstants.d1.w)),
                  child: Center(
                    child: Text("contact".tr()).semiBoldText(
                        context, DimensionConstants.d14.sp, TextAlign.center,
                        color: ColorConstants.colorWhite),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: DimensionConstants.d24.h,
          ),
          Container(
            height: DimensionConstants.d34.h,
            width: DimensionConstants.d339.w,
            child: Text("crew_member_text".tr()).semiBoldText(
                context, DimensionConstants.d14.sp, TextAlign.left),
          )
        ],
      ),
    ),
  );
}

Widget regularHours(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('regular_hours'.tr()).boldText(
            context, DimensionConstants.d16.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.deepBlue),
        SizedBox(
          height: DimensionConstants.d7.h,
        ),
        Text('you_will_be_notified_if_you_are_still_on_site_after_these_hours'
                .tr())
            .regularText(context, DimensionConstants.d14.sp, TextAlign.left,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.deepBlue),
        SizedBox(
          height: DimensionConstants.d8.h,
        ),
        Row(
          children: <Widget>[
            Container(
              height: DimensionConstants.d45.h,
              width: DimensionConstants.d142.w,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : Colors.transparent,
                    width: DimensionConstants.d1.h),
              ),
              child: Center(
                child: const Text("8:00 AM  ").regularText(
                  context,
                  DimensionConstants.d14.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.darkGray4F4F4F,
                ),
              ),
            ),
            SizedBox(
              width: DimensionConstants.d13.w,
            ),
            Text("to").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
            SizedBox(
              width: DimensionConstants.d16.w,
            ),
            Container(
              height: DimensionConstants.d45.h,
              width: DimensionConstants.d142.w,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : Colors.transparent,
                    width: DimensionConstants.d1.h),
              ),
              child: Center(
                child: const Text("5:00 AM  ").regularText(
                  context,
                  DimensionConstants.d14.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.darkGray4F4F4F,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: DimensionConstants.d13.h,
        ),
        Text("after_hours_rates_are_1_5x_your_regular_rate".tr()).regularText(
          context,
          DimensionConstants.d14.sp,
          TextAlign.left,
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.redColorEB5757
              : ColorConstants.redColorEB5757,
        ),
      ],
    ),
  );
}

Widget breakWidget(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('breaks'.tr()).boldText(
            context, DimensionConstants.d16.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.deepBlue),
        SizedBox(
          height: DimensionConstants.d7.h,
        ),
        Text('automatically_applied_to_timesheets'.tr()).regularText(
            context, DimensionConstants.d14.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.deepBlue),
        SizedBox(
          height: DimensionConstants.d8.h,
        ),
        Row(
          children: <Widget>[
            Container(
              height: DimensionConstants.d45.h,
              width: DimensionConstants.d142.w,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : Colors.transparent,
                    width: DimensionConstants.d1.h),
              ),
              child: Center(
                child: const Text("30 mins").regularText(
                  context,
                  DimensionConstants.d14.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.darkGray4F4F4F,
                ),
              ),
            ),
            SizedBox(
              width: DimensionConstants.d13.w,
            ),
            Text("to").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
            SizedBox(
              width: DimensionConstants.d16.w,
            ),
            Container(
              height: DimensionConstants.d45.h,
              width: DimensionConstants.d142.w,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : Colors.transparent,
                    width: DimensionConstants.d1.h),
              ),
              child: Center(
                child: const Text("Any Time").regularText(
                  context,
                  DimensionConstants.d14.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.darkGray4F4F4F,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: DimensionConstants.d8.h,
        ),
        Row(
          children: <Widget>[
            Container(
              height: DimensionConstants.d45.h,
              width: DimensionConstants.d142.w,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : Colors.transparent,
                    width: DimensionConstants.d1.h),
              ),
              child: Center(
                child: const Text("15 mins").regularText(
                  context,
                  DimensionConstants.d14.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.darkGray4F4F4F,
                ),
              ),
            ),
            SizedBox(
              width: DimensionConstants.d13.w,
            ),
            Text("to").regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
            SizedBox(
              width: DimensionConstants.d16.w,
            ),
            Container(
              height: DimensionConstants.d45.h,
              width: DimensionConstants.d142.w,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : Colors.transparent,
                    width: DimensionConstants.d1.h),
              ),
              child: Center(
                child: const Text("3:00 PM").regularText(
                  context,
                  DimensionConstants.d14.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.darkGray4F4F4F,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget roundTimeWidget(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("round_time_to_nearest".tr()).boldText(
            context, DimensionConstants.d16.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.deepBlue),
        SizedBox(
          height: DimensionConstants.d3.h,
        ),
        Text("all_time_logs_will_be_rounded_to_the_nearest".tr()).regularText(
            context, DimensionConstants.d14.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.deepBlue),
        SizedBox(
          height: DimensionConstants.d8.h,
        ),
        Container(
          height: DimensionConstants.d45.h,
          width: DimensionConstants.d142.w,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorBlack
                : ColorConstants.grayF2F2F2,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
            border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : Colors.transparent,
                width: DimensionConstants.d1.h),
          ),
          child: Center(
            child: const Text("15 mins").regularText(
              context,
              DimensionConstants.d14.sp,
              TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.darkGray4F4F4F,
            ),
          ),
        ),
      ],
    ),
  );
}
