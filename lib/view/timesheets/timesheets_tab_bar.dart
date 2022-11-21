import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/time_sheet_provider_crew.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/image_constants.dart';
import '../../constants/route_constants.dart';
import '../../helper/date_function.dart';
import '../../helper/dialog_helper.dart';
import '../../helper/validations.dart';
import '../../locator.dart';
import '../../model/crew_timesheet_model.dart';
import '../../model/project_working_hour_detail.dart';
import '../../widget/image_view.dart';
import '../base_view.dart';

class TimeSheetsTabBar extends StatefulWidget {
  const TimeSheetsTabBar({Key? key}) : super(key: key);

  @override
  State<TimeSheetsTabBar> createState() => _TimeSheetsTabBarState();
}

class _TimeSheetsTabBarState extends State<TimeSheetsTabBar>
    with TickerProviderStateMixin {
  TimeSheetTabBarProviderCrew provider = locator<TimeSheetTabBarProviderCrew>();

  @override
  Widget build(BuildContext context) {
    return BaseView<TimeSheetTabBarProviderCrew>(
      onModelReady: (provider) async {
        this.provider = provider;
        provider.controller = TabController(length: 3, vsync: this);
        //provider.getWidget();
        provider.startDate = DateFunctions.getCurrentDateMonthYear();
        provider.endDate = DateFunctions.getCurrentDateMonthYear();
        await provider.getTimesheet(context, showFullLoader: true);
      },
      builder: (context, provider, _) {
        return Scaffold(
          body: provider.state == ViewState.busy
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.primaryGradient2Color,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: DimensionConstants.d24.h),
                    CommonWidgets.totalProjectsTotalHoursRow(
                        context,
                        "${provider.crewTimeSheetModel?.projects}",
                        DateFunctions.minutesToHourString(
                            provider.crewTimeSheetModel!.totalProjectHours ??
                                0)),
                    tabBarView(provider.controller!, context, provider)
                  ],
                ),
        );
      },
    );
  }

  Widget tabBarView(TabController controller, BuildContext context,
      TimeSheetTabBarProviderCrew provider) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: DimensionConstants.d15.h),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: ColorConstants.colorWhite90, width: 1.5),
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
              ),
              elevation: 0.0,
              child: TabBar(
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      ColorConstants.primaryGradient2Color,
                      ColorConstants.primaryGradient1Color
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(DimensionConstants.d8.r),
                  ),
                ),
                padding: EdgeInsets.zero,
                controller: controller,
                onTap: (index) {
                  provider.updateSelectedTabIndex(index);

                  switch (index) {
                    case 0:
                      {
                        provider.startDate =
                            DateFunctions.getCurrentDateMonthYear();
                        provider.endDate =
                            DateFunctions.getCurrentDateMonthYear();
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.getTimesheet(context);
                        break;
                      }
                    case 1:
                      {
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.nextWeekDays(7);
                        provider.getTimesheet(context);
                        break;
                      }
                    case 2:
                      {
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.nextWeekDays(14);
                        provider.getTimesheet(context);
                        break;
                      }
                  }
                },
                tabs: [
                  Container(
                    alignment: Alignment.center,
                    height: DimensionConstants.d50.h,
                    width: DimensionConstants.d114.w,
                    child: controller.index == 0
                        ? Text("today".tr()).boldText(context,
                            DimensionConstants.d16.sp, TextAlign.center,
                            color: ColorConstants.colorWhite)
                        : Text("today".tr()).regularText(context,
                            DimensionConstants.d16.sp, TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: DimensionConstants.d50.h,
                    width: DimensionConstants.d114.w,
                    child: controller.index == 1
                        ? Text("weekly".tr()).boldText(context,
                            DimensionConstants.d16.sp, TextAlign.center,
                            color: ColorConstants.colorWhite)
                        : Text("weekly".tr()).regularText(context,
                            DimensionConstants.d16.sp, TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: DimensionConstants.d50.h,
                    width: DimensionConstants.d114.w,
                    child: controller.index == 2
                        ? Text("bi_weekly".tr()).boldText(context,
                            DimensionConstants.d16.sp, TextAlign.center,
                            color: ColorConstants.colorWhite)
                        : Text("bi_weekly".tr()).regularText(context,
                            DimensionConstants.d16.sp, TextAlign.center),
                  ),
                ],
              ),
            ),
            Expanded(
              child: provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.primaryGradient2Color,
                      ),
                    )
                  : TabBarView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        projectsAndHoursCardList(context, provider),
                        weeklyTabBarContainer(context, provider),
                        weeklyTabBarContainer(context, provider),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget projectsAndHoursCardList(
      BuildContext context, TimeSheetTabBarProviderCrew provider) {
    return Padding(
      padding: EdgeInsets.only(top: DimensionConstants.d16.h),
      child: Card(
        elevation: 2.5,
        color: (Theme.of(context).brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.colorWhite),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorConstants.colorWhite, width: 1.0),
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Column(
          children: [
            Container(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.colorWhite),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  projectsHoursRow(ImageConstants.mapIcon,
                      "${provider.crewTimeSheetModel?.allCheckin?.length} ${"projects".tr()}"),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(
                      ImageConstants.clockIcon,
                      provider.crewTimeSheetModel!.allCheckin!.isEmpty
                          ? "0 Hours"
                          : "${provider.totalHours!.replaceAll("-", " ")} ${"hours".tr()}")
                ],
              ),
            ),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),

            ListView.separated(
              itemCount: provider.crewTimeSheetModel!.allCheckin!.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return projectDetailTile(context,
                    checkInProjectDetail:
                        provider.crewTimeSheetModel!.allCheckin![index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                    color: ColorConstants.colorGreyDrawer,
                    height: 0.0,
                    thickness: 1.5);
              },
            ),

            // stepperCustom(8)
          ],
        ),
      ),
    );
  }

  Widget projectsHoursRow(String iconPath, String txt) {
    return Row(
      children: [
        ImageView(path: iconPath),
        SizedBox(width: DimensionConstants.d9.w),
        Text(txt).boldText(context, DimensionConstants.d18.sp, TextAlign.center)
      ],
    );
  }

  Widget projectDetailTile(BuildContext context,
      {VoidCallback? onTap, AllCheckin? checkInProjectDetail}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: DimensionConstants.d75.w,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: DimensionConstants.d11.h,
              horizontal: DimensionConstants.d16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(DimensionConstants.d5),
                height: DimensionConstants.d40.h,
                width: DimensionConstants.d40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: checkInProjectDetail?.assignProjectId?.color == null
                      ? Colors.black
                      : Color(int.parse(
                          "0x${checkInProjectDetail?.assignProjectId?.color}")),
                ),
                child: Text(Validations.getInitials(
                        string: checkInProjectDetail!
                                .assignProjectId!.projectName ??
                            "",
                        limitTo: 2))
                    .boldText(
                        context, DimensionConstants.d16.sp, TextAlign.center,
                        color: ColorConstants.colorWhite),
              ),
              SizedBox(width: DimensionConstants.d12.w),
              Text(DateFunctions.dateTO12Hour(checkInProjectDetail.checkInTime!)
                      .substring(
                          0,
                          DateFunctions.dateTO12Hour(
                                      checkInProjectDetail.checkInTime!)
                                  .length -
                              1))
                  .regularText(
                      context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d10.w),
              Expanded(child: customStepper(checkInProjectDetail)),
              SizedBox(width: DimensionConstants.d10.w),
              Text(DateFunctions.dateTO12Hour(DateFunctions.checkTimeIsNull(
                          checkInProjectDetail.checkOutTime))
                      .substring(
                          0,
                          DateFunctions.dateTO12Hour(
                                      DateFunctions.checkTimeIsNull(
                                          checkInProjectDetail.checkOutTime))
                                  .length -
                              1))
                  .regularText(
                      context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d10.w),
              Text("${DateFunctions.calculateTotalHourTime(checkInProjectDetail.checkInTime!, DateFunctions.checkTimeIsNull(checkInProjectDetail.checkOutTime)).replaceAll("-", " ")} h")
                  .boldText(
                      context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d7.w),
              ImageView(
                  path: ImageConstants.forwardArrowIcon,
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack))
            ],
          ),
        ),
      ),
    );
  }

  Widget customStepper(AllCheckin checkInProjectDetail) {
    List<Widget> widgetlist = [];
    List<ProjectWorkingHourDetail> projectDetailLIst =
        provider.getTimeForStepper(checkInProjectDetail);
    for (int i = 0; i < projectDetailLIst.length; i++) {
      if (projectDetailLIst[i].type == 1) {
        widgetlist.add(Flexible(
          flex: projectDetailLIst[i].timeInterval!,
          child: Container(
            height: DimensionConstants.d4.h,
            color: ColorConstants.colorGreen,
          ),
        ));
      } else if (projectDetailLIst[i].type == 2) {
        widgetlist.add(Flexible(
          flex: projectDetailLIst[i].timeInterval!,
          child: Container(
            height: DimensionConstants.d4.h,
            color: ColorConstants.colorGray,
          ),
        ));
      } else {
        widgetlist.add(Flexible(
          flex: projectDetailLIst[i].timeInterval!,
          child: Container(
            height: DimensionConstants.d4.h,
            color: ColorConstants.colorLightRed,
          ),
        ));
      }
    }
    return Container(
        width: DimensionConstants.d75.w,
        child: Center(
            child: Flex(
          direction: Axis.horizontal,
          children: widgetlist,
        )));
  }

  Widget weeklyTabBarContainer(
      BuildContext context, TimeSheetTabBarProviderCrew provider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: DimensionConstants.d15.h),
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.deepBlue,
              borderRadius:
                  BorderRadius.all(Radius.circular(DimensionConstants.d8.r)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        DimensionConstants.d16.w,
                        DimensionConstants.d17.h,
                        DimensionConstants.d16.w,
                        DimensionConstants.d15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        backNextBtn(ImageConstants.backIconIos, () {
                          provider.previousWeekDays(
                              provider.selectedTabIndex == 1 ? 7 : 14);
                          provider.getTimesheet(context);
                        }),
                        Text("${DateFunctions.capitalize(provider.weekFirstDate ?? "")} - ${DateFunctions.capitalize(provider.weekEndDate ?? "")}")
                            .boldText(context, DimensionConstants.d16.sp,
                                TextAlign.center,
                                color: ColorConstants.colorWhite),
                        provider.endDate !=
                                DateFormat("yyyy-MM-dd").format(DateTime.now())
                            ? backNextBtn(ImageConstants.nextIconIos, () {
                                provider.nextWeekDays(
                                    provider.selectedTabIndex == 1 ? 7 : 14);
                                provider.getTimesheet(context);
                                ;
                              })
                            : Visibility(
                                visible: false,
                                child: backNextBtn(
                                    ImageConstants.nextIconIos, () {}))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorBlack
                          : ColorConstants.colorWhite),
                      border: Border.all(
                        color: ColorConstants.colorLightGreyF2,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(DimensionConstants.d8.r)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorBlack
                                    : ColorConstants.colorWhite),
                            border: Border.all(
                              color: ColorConstants.colorLightGreyF2,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(DimensionConstants.d8.r)),
                          ),
                          height: DimensionConstants.d70.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              projectsHoursRow(ImageConstants.mapIcon,
                                  "${provider.crewTimeSheetModel!.allCheckin!.length} ${"projects".tr()}"),
                              Container(
                                height: DimensionConstants.d70.h,
                                width: DimensionConstants.d1.w,
                                color: ColorConstants.colorLightGrey,
                              ),
                              projectsHoursRow(
                                  ImageConstants.clockIcon,
                                  provider.crewTimeSheetModel!.allCheckin!
                                          .isEmpty
                                      ? "0 Hours"
                                      : "${provider.totalHours!.replaceAll("-", " ")} ${"hours".tr()}")
                            ],
                          ),
                        ),
                        provider.crewTimeSheetModel!.allCheckin!.isEmpty
                            ? SizedBox(
                                height: DimensionConstants.d300.h,
                                child: Center(
                                  child: const Text(
                                          "You have not checked out Any project yet")
                                      .regularText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.center,
                                          color: ColorConstants.colorBlack),
                                ),
                              )
                            : Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      reverse:true,
                                      itemCount: provider.weeklyData.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              color: ColorConstants
                                                  .colorLightGreyF2,
                                              height: DimensionConstants.d32.h,
                                              alignment: Alignment.center,
                                              child: Text(provider
                                                          .weeklyData[index]
                                                          .date ??
                                                      "")
                                                  .boldText(
                                                      context,
                                                      DimensionConstants.d13.sp,
                                                      TextAlign.center,
                                                      color: ColorConstants
                                                          .colorBlack),
                                            ),
                                            ListView.separated(
                                              shrinkWrap: true,
                                              reverse:true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: provider
                                                  .weeklyData[index]
                                                  .checkInDataList!
                                                  .length,
                                              itemBuilder:
                                                  (context, innerIndex) {
                                                return projectDetailTile(
                                                    context,
                                                    checkInProjectDetail: provider
                                                            .weeklyData[index]
                                                            .checkInDataList![
                                                        innerIndex]);
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Divider(
                                                    color: ColorConstants
                                                        .colorGreyDrawer,
                                                    height: 0.0,
                                                    thickness: 1.5);
                                              },
                                            ),
                                          ],
                                        );
                                      }),
                                  const Divider(
                                      color: ColorConstants.colorGreyDrawer,
                                      height: 0.0,
                                      thickness: 1.5),
                                  SizedBox(height: DimensionConstants.d12.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: DimensionConstants.d16.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("total_hours".tr())
                                                .semiBoldText(
                                                    context,
                                                    DimensionConstants.d14.sp,
                                                    TextAlign.center),
                                            Text("${provider.totalHours!.replaceAll("-", " ")} Hrs")
                                                .semiBoldText(
                                                    context,
                                                    DimensionConstants.d14.sp,
                                                    TextAlign.center)
                                          ],
                                        ),
                                        SizedBox(
                                            height: DimensionConstants.d6.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("x \$${provider.averageRatePerHour!}/hr")
                                                .semiBoldText(
                                                    context,
                                                    DimensionConstants.d14.sp,
                                                    TextAlign.center),
                                            Text("\$${provider.totalEarnings!.replaceAll("-", " ")}")
                                                .semiBoldText(
                                                    context,
                                                    DimensionConstants.d14.sp,
                                                    TextAlign.center)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: DimensionConstants.d16.h),
                                  exportTimeSheetBtn(context),
                                  SizedBox(height: DimensionConstants.d16.h),
                                ],
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget backNextBtn(String path, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: DimensionConstants.d25.w,
        height: DimensionConstants.d26.h,
        decoration: const BoxDecoration(
          color: ColorConstants.colorWhite30,
          shape: BoxShape.circle,
        ),
        child: ImageView(
          path: path,
        ),
      ),
    );
  }

  Widget exportTimeSheetBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => DialogHelper.exportFileDialog(
                  context,
                  photoFromCamera: () {},
                  photoFromGallery: () {},
                ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d312.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.colorGray5, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(DimensionConstants.d8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageView(path: ImageConstants.exportIcon),
            SizedBox(width: DimensionConstants.d8.w),
            Text("export_time_sheet".tr())
                .boldText(context, DimensionConstants.d16.sp, TextAlign.center)
          ],
        ),
      ),
    );
  }
}
