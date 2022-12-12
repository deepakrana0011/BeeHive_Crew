import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/model/crew_timesheet_model.dart';
import 'package:beehive/provider/time_sheets_screen_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/api_constants.dart';
import '../../helper/date_function.dart';
import '../../model/project_working_hour_detail.dart';
import '../../model/time_sheets_screen_arguments.dart';

class TimeSheetsScreen extends StatelessWidget {
  final TimeSheetsScreenArguments? timeSheetsScreenArguments;

  const TimeSheetsScreen({Key? key, this.timeSheetsScreenArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TimeSheetsScreenProvider>(
        builder: (context, provider, _) => Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text("time_sheets".tr()).semiBoldText(
                    context, DimensionConstants.d22.sp, TextAlign.center),
                centerTitle: true,
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
              body: Column(
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
                            context, timeSheetsScreenArguments?.name ?? '',
                            path: timeSheetsScreenArguments?.profileImage ==
                                    null
                                ? ''
                                : ApiConstantsManager.BASEURL_IMAGE +
                                    timeSheetsScreenArguments!.profileImage!),
                        SizedBox(width: DimensionConstants.d14.w),
                        Container(
                          width: DimensionConstants.d1.w,
                          height: DimensionConstants.d72.h,
                          color: ColorConstants.colorGrayE8,
                        ),
                        SizedBox(width: DimensionConstants.d24.w),
                        crewProfileContainer(
                            context,
                            timeSheetsScreenArguments?.allCheckIn
                                    ?.assignProjectId?.projectName ??
                                '',
                            shortName: timeSheetsScreenArguments
                                ?.allCheckIn?.assignProjectId?.projectName
                                .toString()
                                .substring(0, 2),
                            color: timeSheetsScreenArguments
                                ?.allCheckIn?.assignProjectId?.color),
                      ],
                    ),
                  ),
                  const Divider(
                      color: ColorConstants.colorGreyDrawer,
                      height: 0.0,
                      thickness: 1.5),
                  SizedBox(height: DimensionConstants.d24.h),
                  Text(DateFunctions.dateTimeWithWeek(DateTime.parse(
                              timeSheetsScreenArguments!.allCheckIn!.checkInTime
                                  .toString())
                          .toLocal()))
                      .boldText(
                          context, DimensionConstants.d18.sp, TextAlign.center),
                  SizedBox(height: DimensionConstants.d16.h),
                  hoursContainer(context, provider),
                  SizedBox(height: DimensionConstants.d26.h),
                  Expanded(
                    child: checkInCHeckOutStepper(
                        context,
                        provider,
                        timeSheetsScreenArguments!.allCheckIn!.checkInTime,
                        timeSheetsScreenArguments!.allCheckIn!.checkOutTime),
                  ),
                  SizedBox(height: DimensionConstants.d100.h),
                ],
              ),
            ));
  }

  Widget crewProfileContainer(BuildContext context, String name,
      {String? path, String? shortName, String? color}) {
    return Row(
      children: [
        path != null
            ? ImageView(
                height: DimensionConstants.d40.w,
                width: DimensionConstants.d40.w,
                fit: BoxFit.cover,
                path: path,
                circleCrop: true,
              )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(DimensionConstants.d5),
                height: DimensionConstants.d40.w,
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
              context, DimensionConstants.d14.sp, TextAlign.start,
              maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget hoursContainer(
      BuildContext context, TimeSheetsScreenProvider provider) {
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
              "${DateFunctions.minutesToHourString(provider.getTotalMinutes(timeSheetsScreenArguments?.allCheckIn!.checkInTime!, timeSheetsScreenArguments?.allCheckIn?.checkOutTime) ?? 0)}"
              " Hrs")
          .boldText(context, DimensionConstants.d16.sp, TextAlign.center,
              color: ColorConstants.colorBlack),
    );
  }

  Widget checkInCHeckOutStepper(
      BuildContext context,
      TimeSheetsScreenProvider provider,
      String? checkInTime,
      String? checkOutTime) {
    return Column(
      children: [
        checkInCheckOut(context, "check_in".tr(),
            provider.checkInOutTime(checkInTime), CrossAxisAlignment.end),
        Expanded(
            child: customStepper(
                provider, timeSheetsScreenArguments?.allCheckIn, context)),
        checkInCheckOut(context, "check_out".tr(),
            provider.checkInOutTime(checkOutTime), CrossAxisAlignment.start)
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

  Widget customStepper(TimeSheetsScreenProvider provider,
      AllCheckin? allCheckIn, BuildContext context) {
    List<Widget> widgetList = [];
    List<ProjectWorkingHourDetail> projectDetailLIst =
        provider.getTimeForStepper(allCheckIn!);
    for (int i = 0; i < projectDetailLIst.length; i++) {
      if (projectDetailLIst[i].type == 1) {
        widgetList.add(
          Flexible(
            flex: projectDetailLIst[i].timeInterval!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                    width: DimensionConstants.d8.w,
                    color: ColorConstants.colorGreen,
                  ),
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

                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                    width: DimensionConstants.d8.w,
                    color: ColorConstants.colorGray,
                  ),
                ),

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

                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                    width: DimensionConstants.d8.w,
                    color: ColorConstants.colorLightRed,
                  ),
                ),

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
}
