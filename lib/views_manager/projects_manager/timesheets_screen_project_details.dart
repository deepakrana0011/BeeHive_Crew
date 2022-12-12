import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/time_sheet_screen_project_details_provider_manager.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/bottom_sheet_cupertino_time_picker.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/route_constants.dart';
import '../../helper/date_function.dart';
import '../../model/manager_dashboard_response.dart';
import '../../model/project_timesheet_response.dart';
import '../../model/project_working_hour_detail.dart';
import '../../widget/custom_circular_bar.dart';

class TimeSheetsScreenProjectDetails extends StatelessWidget {
  final bool removeInterruption;
  final TimeSheetProjectData projectData;
  final int index;

  const TimeSheetsScreenProjectDetails(
      {Key? key,
      required this.removeInterruption,
      required this.projectData,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TimeSheetScreenProjectDetailsProvider>(
      onModelReady: (provider) {
        provider.projectData = projectData;
        provider.removeInterruption =
            provider.projectData!.checkins[index].interuption!.isEmpty;
      },
      builder: (context, provider, _) {
        return WillPopScope(
          onWillPop: _willPopCallback,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              title: Text("time_sheets".tr()).semiBoldText(
                  context, DimensionConstants.d22.sp, TextAlign.center),
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Theme.of(context).iconTheme.color,
                    size: 28,
                  )),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: DimensionConstants.d5.h),
                    const Divider(
                        color: ColorConstants.colorGreyDrawer,
                        height: 0.0,
                        thickness: 1.5),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionConstants.d36.w),
                      child: Row(
                        children: [
                          crewProfileContainer(
                            context,
                            provider.projectData?.checkins[index].crew![0]
                                    .name ??
                                " ",
                            path: provider.projectData?.checkins[index].crew![0]
                                        .profileImage ==
                                    null
                                ? ''
                                : ApiConstantsManager.BASEURL_IMAGE +
                                    provider.projectData!.checkins[index]
                                        .crew![0].profileImage!,
                          ),
                          SizedBox(width: DimensionConstants.d14.w),
                          Container(
                            width: DimensionConstants.d1.w,
                            height: DimensionConstants.d72.h,
                            color: ColorConstants.colorGrayE8,
                          ),
                          SizedBox(width: DimensionConstants.d24.w),
                          crewProfileContainer(
                              context, provider.projectData!.projectName!,
                              shortName: provider.projectData!.projectName
                                  .toString()
                                  .substring(0, 2),
                              color: provider.projectData!.color),
                        ],
                      ),
                    ),
                    const Divider(
                        color: ColorConstants.colorGreyDrawer,
                        height: 0.0,
                        thickness: 1.5),
                    SizedBox(height: DimensionConstants.d24.h),
                    Text(DateFunctions.dateTimeWithWeek(DateTime.parse(
                                provider.projectData!.date.toString())
                            .toLocal()))
                        .boldText(context, DimensionConstants.d18.sp,
                            TextAlign.center),
                    SizedBox(height: DimensionConstants.d16.h),
                    hoursContainer(context, provider),
                    SizedBox(height: DimensionConstants.d26.h),
                    Expanded(child: checkInCHeckOutStepper(context, provider)),
                    SizedBox(height: DimensionConstants.d26.h),
                    (provider.projectData!.checkins[index].interuption!
                                .isEmpty &&
                            provider.projectData!.checkins[index]
                                .ignoredInteruption!.isEmpty)
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              if (provider.removeInterruption == false) {
                                provider.ignoreAllInteruptions(
                                    context,
                                    provider.projectData!.checkins[index].sId!,
                                    index);
                              } else {
                                provider.revertCheckinInteruptions(
                                    context,
                                    provider.projectData!.checkins[index].sId!,
                                    index);
                              }
                            },
                            child: Container(
                              height: DimensionConstants.d50.h,
                              width: DimensionConstants.d320.w,
                              decoration: BoxDecoration(
                                border: provider.removeInterruption == true
                                    ? Border.all(
                                        color: ColorConstants.gray828282,
                                        width: DimensionConstants.d1.w)
                                    : null,
                                color: provider.removeInterruption == false
                                    ? ColorConstants.redColorEB5757
                                    : ColorConstants.colorWhite,
                                borderRadius: BorderRadius.circular(
                                    DimensionConstants.d8.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  provider.removeInterruption == false
                                      ? ImageView(
                                          path: ImageConstants.ignoreIcon,
                                          color: ColorConstants.colorWhite,
                                          height: DimensionConstants.d23.h,
                                          width: DimensionConstants.d24.w,
                                        )
                                      : Container(),
                                  provider.removeInterruption == false
                                      ? SizedBox(
                                          width: DimensionConstants.d10.w,
                                        )
                                      : const SizedBox(),
                                  Text(provider.removeInterruption == false
                                          ? "ignore_all_interruptions".tr()
                                          : "revert_all_iterruptions".tr())
                                      .boldText(
                                          context,
                                          DimensionConstants.d16.sp,
                                          TextAlign.center,
                                          color: provider.removeInterruption ==
                                                  false
                                              ? ColorConstants.colorWhite
                                              : ColorConstants.redColorEB5757),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(height: DimensionConstants.d63.h),
                  ],
                ),
                provider.state == ViewState.busy
                    ? const CustomCircularBar()
                    : SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget crewProfileContainer(BuildContext context, String name,
      {String? path, String? shortName, String? color}) {
    return Row(
      children: [
        path != null
            ? SizedBox(
                height: DimensionConstants.d40.h,
                width: DimensionConstants.d40.w,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d20.r),
                    child: ImageView(
                      path: path,
                      fit: BoxFit.cover,
                      radius: DimensionConstants.d20.r,
                    )),
              )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(DimensionConstants.d5),
                height: DimensionConstants.d40.h,
                width: DimensionConstants.d40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color == null
                      ? Colors.black
                      : Color(int.parse('0x$color')),
                ),
                child: Text(shortName!.toUpperCase()).boldText(
                    context, DimensionConstants.d16.sp, TextAlign.center,
                    color: ColorConstants.colorWhite),
              ),
        SizedBox(width: DimensionConstants.d13.w),
        SizedBox(
          width: DimensionConstants.d75.w,
          child: Text(name).semiBoldText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget hoursContainer(
    BuildContext context,
    TimeSheetScreenProjectDetailsProvider provider,
  ) {
    return Container(
      alignment: Alignment.center,
      width: DimensionConstants.d120.w,
      height: DimensionConstants.d36.h,
      decoration: BoxDecoration(
        color: ColorConstants.colorLightGreyF2,
        borderRadius: BorderRadius.all(
          Radius.circular(DimensionConstants.d100.r),
        ),
      ),
      child: Text(
              "${DateFunctions.minutesToHourString(provider.getTotalMinutes(provider.projectData!.checkins[index].checkInTime, provider.projectData!.checkins[index].checkOutTime) ?? 0)}"
              " Hrs")
          .boldText(context, DimensionConstants.d16.sp, TextAlign.center,
              color: ColorConstants.colorBlack),
    );
  }

  Widget checkInCHeckOutStepper(
    BuildContext context,
    TimeSheetScreenProjectDetailsProvider provider,
  ) {
    return Column(
      children: [
        checkInButton(
            context,
            "check_in".tr(),
            DateFunctions.dateTO12Hour(
                    provider.projectData!.checkins[index].checkInTime!)
                .substring(
              0,
              DateFunctions.dateTO12Hour(
                          provider.projectData!.checkins[index].checkInTime!)
                      .length -
                  1,
            ),
            CrossAxisAlignment.center,
            provider.projectData!.checkins[index].checkInTime!,
            DateFunctions.checkTimeIsNull(
                provider.projectData!.checkins[index].checkOutTime),
            provider),
        Expanded(
            child: customStepper(
                provider, provider.projectData!.checkins[index], context)),


        (provider.projectData!.checkins[index].checkOutTime == null ||
                provider.projectData!.checkins[index].checkOutTime!
                    .trim()
                    .isEmpty)
            ? const SizedBox()
            : checkOutButton(
                context,
                "check_out".tr(),
                DateFunctions.dateTO12Hour(DateFunctions.checkTimeIsNull(
                        provider.projectData!.checkins[index].checkOutTime))
                    .substring(
                        0,
                        DateFunctions.dateTO12Hour(provider
                                    .projectData!.checkins[index].checkInTime!)
                                .length -
                            1),
                CrossAxisAlignment.center,
                DateFunctions.checkTimeIsNull(
                    provider.projectData!.checkins[index].checkOutTime),
                provider.projectData!.checkins[index].checkInTime!,
                provider),
      ],
    );
  }

  Widget checkInCheckOut(
      BuildContext context, String checkText, String time, alignment) {
    return Row(
      crossAxisAlignment: alignment,
      children: [
        Container(
          alignment: Alignment.bottomRight,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Text(checkText).semiBoldText(
              context, DimensionConstants.d14.sp, TextAlign.center),
        ),
        SizedBox(width: DimensionConstants.d10.w),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: DimensionConstants.d6.h,
            decoration: BoxDecoration(
              color: ColorConstants.colorBlack,
              borderRadius: BorderRadius.all(
                Radius.circular(DimensionConstants.d4.r),
              ),
            ),
            width: DimensionConstants.d15.w,
          ),
        ),
        SizedBox(width: DimensionConstants.d10.w),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Text(time).regularText(
              context, DimensionConstants.d13.sp, TextAlign.center),
        )
      ],
    );
  }

  Widget checkInButton(
    BuildContext context,
    String checkText,
    String time,
    alignment,
    String checkInTime,
    String checkOutTime,
    TimeSheetScreenProjectDetailsProvider provider,
  ) {
    return Row(
      crossAxisAlignment: alignment,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              width: MediaQuery.of(context).size.width / 2.2,
              child: Text(checkText).semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.center),
            ),
            Text(time).regularText(
                context, DimensionConstants.d13.sp, TextAlign.left,
                color: ColorConstants.darkGray4F4F4F)
          ],
        ),
        SizedBox(width: DimensionConstants.d10.w),
        Padding(
          padding: EdgeInsets.only(
              top: DimensionConstants.d25.h, left: DimensionConstants.d2.w),
          child: Container(
            alignment: Alignment.center,
            height: DimensionConstants.d6.h,
            decoration: BoxDecoration(
              color: ColorConstants.colorBlack,
              borderRadius: BorderRadius.all(
                Radius.circular(DimensionConstants.d4.r),
              ),
            ),
            width: DimensionConstants.d10.w,
          ),
        ),
        SizedBox(
          width: DimensionConstants.d10.w,
        ),
        Padding(
          padding: EdgeInsets.only(right: DimensionConstants.d73.w),
          child: GestureDetector(
            onTap: () {
              bottomSheetTimeSheetTimePicker(
                context,
                selectedDate: (DateTime date) {
                  Navigator.of(context).pop();
                  DateTime checkOutDate =
                      DateFunctions.getDateTimeFromString(checkOutTime);
                  if (DateFunctions.getDateTimeFromString(checkInTime)
                      .isAtSameMomentAs(date)) {
                    DialogHelper.showMessage(
                        context, "please_select_different_check_in_time".tr());
                  } else if (date.isAfter(checkOutDate)) {
                    DialogHelper.showMessage(
                        context, "invalid_check_in_time".tr());
                  } else {
                    provider.changeCheckInOutTime(
                        context,
                        provider.projectData!.checkins[index].sId!,
                        index,
                        date,
                        0);
                  }
                },
                timeSheetOrSchedule: true,
                currentTime: DateFunctions.getDateTimeFromString(checkInTime),
              );
            },
            child: Container(
                height: DimensionConstants.d32.h,
                width: DimensionConstants.d93.w,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d4.w),
                    border: Border.all(
                        color: ColorConstants.grayD2D2D2,
                        width: DimensionConstants.d1.w)),
                child: Center(
                  child: Text("change".tr()).boldText(
                      context, DimensionConstants.d13.sp, TextAlign.center),
                )),
          ),
        )
      ],
    );
  }

  Widget checkOutButton(
    BuildContext context,
    String checkText,
    String time,
    alignment,
    String checkOutTime,
    String checkInTime,
    TimeSheetScreenProjectDetailsProvider provider,
  ) {
    return Row(
      crossAxisAlignment: alignment,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              width: MediaQuery.of(context).size.width / 2.2,
              child: Text(checkText).semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.center),
            ),
            Text(time).regularText(
                context, DimensionConstants.d13.sp, TextAlign.left,
                color: ColorConstants.darkGray4F4F4F)
          ],
        ),
        SizedBox(width: DimensionConstants.d10.w),
        Padding(
          padding: EdgeInsets.only(
              bottom: DimensionConstants.d25.h, left: DimensionConstants.d2.w),
          child: Container(
            alignment: Alignment.center,
            height: DimensionConstants.d6.h,
            decoration: BoxDecoration(
              color: ColorConstants.colorBlack,
              borderRadius: BorderRadius.all(
                Radius.circular(DimensionConstants.d4.r),
              ),
            ),
            width: DimensionConstants.d10.w,
          ),
        ),
        SizedBox(
          width: DimensionConstants.d10.w,
        ),
        Padding(
          padding: EdgeInsets.only(right: DimensionConstants.d73.w),
          child: GestureDetector(
            onTap: () {
              bottomSheetTimeSheetTimePicker(
                context,
                currentTime: DateFunctions.getDateTimeFromString(checkOutTime),
                selectedDate: (DateTime date) {
                  Navigator.of(context).pop();
                  print(date);
                  DateTime checkInDate =
                      DateFunctions.getDateTimeFromString(checkInTime);
                  print(checkInDate);
                  if (DateFunctions.getDateTimeFromString(checkOutTime)
                      .isAtSameMomentAs(date)) {
                    DialogHelper.showMessage(
                        context, "please_select_different_check_in_time".tr());
                  } else if (date.isBefore(checkInDate)) {
                    DialogHelper.showMessage(
                        context, "invalid_check_in_time".tr());
                  } else {
                    provider.changeCheckInOutTime(
                        context,
                        provider.projectData!.checkins[index].sId!,
                        index,
                        date,
                        1);
                  }
                },
                timeSheetOrSchedule: true,
              );
            },
            child: Container(
                height: DimensionConstants.d32.h,
                width: DimensionConstants.d93.w,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d4.w),
                    border: Border.all(
                        color: ColorConstants.grayD2D2D2,
                        width: DimensionConstants.d1.w)),
                child: Center(
                  child: Text("change".tr()).boldText(
                      context, DimensionConstants.d13.sp, TextAlign.center),
                )),
          ),
        )
      ],
    );
  }

  Widget stepperLine(double height, Color color) {
    return Container(
      width: DimensionConstants.d6.w,
      height: height,
      color: color,
    );
  }

  Widget customStepper(TimeSheetScreenProjectDetailsProvider provider,
      TimeSheetCheckins checkinsDetails, BuildContext context) {
    List<Widget> widgetList = [];
    List<ProjectWorkingHourDetail> projectDetailLIst =
        provider.getTimeForStepper(checkinsDetails);
    for (int i = 0; i < projectDetailLIst.length; i++) {
      if (projectDetailLIst[i].type == 1) {
        widgetList.add(
          Flexible(
            flex: projectDetailLIst[i].timeInterval!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 120,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                    width: DimensionConstants.d8.w,
                    color: ColorConstants.colorGreen,
                  ),
                ),
                const SizedBox(
                  width: 120,
                ),
              ],
            ),
          ),
        );
      } else if (projectDetailLIst[i].type == 2) {
        widgetList.add(
          Flexible(
            flex: projectDetailLIst[i].timeInterval!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      direction: Axis.vertical,
                      children: [
                        Text('break'.tr()).regularText(context,
                            DimensionConstants.d14.sp, TextAlign.center,
                            color: ColorConstants.darkGray4F4F4F),
                        Text('${DateFunctions.getTime(DateFunctions.getDateTimeFromString(projectDetailLIst[i].startTime!)).toLowerCase()} - ${DateFunctions.getTime(DateFunctions.getDateTimeFromString(projectDetailLIst[i].endTime!)).toLowerCase()}')
                            .regularText(context, DimensionConstants.d14.sp,
                                TextAlign.center,
                                color: ColorConstants.darkGray4F4F4F),
                      ],
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                    width: DimensionConstants.d8.w,
                    color: ColorConstants.colorGray,
                  ),
                ),
                /*  SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              height: DimensionConstants.d32.h,
                              width: DimensionConstants.d93.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      DimensionConstants.d4.w),
                                  border: Border.all(
                                      color: ColorConstants.grayD2D2D2,
                                      width: DimensionConstants.d1.w)),
                              child: Center(
                                child: Text("change".tr()).boldText(context,
                                    DimensionConstants.d14.sp, TextAlign.center,
                                    color: ColorConstants.black333333),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        );
      } else {
        widgetList.add(
          Flexible(
            flex: projectDetailLIst[i].timeInterval!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*SizedBox(
                  width: 120,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Text('15 m ${'interruption'.tr()}').regularText(
                            context, DimensionConstants.d14.sp, TextAlign.end,
                            color: ColorConstants.redColorEB5757),
                        Text('${DateFunctions.getTime(DateFunctions.getDateTimeFromString(projectDetailLIst[i].startTime!)).toLowerCase()} - ${DateFunctions.getTime(DateFunctions.getDateTimeFromString(projectDetailLIst[i].endTime!)).toLowerCase()}')
                            .regularText(context, DimensionConstants.d13.sp,
                                TextAlign.end,
                                color: ColorConstants.darkGray4F4F4F),
                      ],
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                    width: DimensionConstants.d8.w,
                    color: ColorConstants.colorLightRed,
                  ),
                ),
                /* SizedBox(
                  width: 120,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: DimensionConstants.d32.h,
                            width: DimensionConstants.d93.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    DimensionConstants.d4.w),
                                border: Border.all(
                                    color: ColorConstants.grayD2D2D2,
                                    width: DimensionConstants.d1.w)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ImageView(
                                    path: ImageConstants.ignoreIcon,
                                  ),
                                  SizedBox(
                                    width: DimensionConstants.d8.w,
                                  ),
                                  Text("ignore".tr()).boldText(
                                      context,
                                      DimensionConstants.d14.sp,
                                      TextAlign.center,
                                      color: ColorConstants.redColorEB5757)
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        );
      }
    }
    return SizedBox(
        child: Center(
      child: Flex(
        direction: Axis.vertical,
        children: widgetList,
      ),
    ));
  }

  Future<bool> _willPopCallback() async {
    return true;
  }
}
