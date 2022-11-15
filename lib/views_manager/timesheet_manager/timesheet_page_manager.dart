import 'dart:math';

import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/timesheet_manager/timesheet_from_crew.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/image_constants.dart';
import '../../helper/common_widgets.dart';
import '../../helper/validations.dart';
import '../../model/project_timesheet_response.dart';
import '../../provider/bottom_bar_Manager_provider.dart';
import '../../provider/timesheet_manager_provider.dart';
import '../../widget/bottom_sheet_project_details_timesheet.dart';
import '../../widget/image_view.dart';

class TimeSheetPageManager extends StatefulWidget {
  const TimeSheetPageManager({Key? key}) : super(key: key);

  @override
  State<TimeSheetPageManager> createState() => _TimeSheetPageManagerState();
}

class _TimeSheetPageManagerState extends State<TimeSheetPageManager>
    with TickerProviderStateMixin {
  TimeSheetManagerProvider provider = locator<TimeSheetManagerProvider>();

  BottomBarManagerProvider? managerProvider;

  @override
  void initState() {
    managerProvider =
        Provider.of<BottomBarManagerProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return BaseView<TimeSheetManagerProvider>(onModelReady: (provider) async {
      //To Show Crew Screen First
      tabController.index = managerProvider!.showCrewScreen ? 1 : 0;
      managerProvider?.showCrewScreen=false;

      this.provider = provider;
      provider.startDate = DateFunctions.getCurrentDateMonthYear();
      provider.endDate = DateFunctions.getCurrentDateMonthYear();
      await provider.projectTimeSheetManager(context, showFullLoader: true);
      provider.controller = TabController(length: 3, vsync: this);
      provider.getAllCrewOnProject(context);
    }, builder: (context, provider, _) {
      return provider.state == ViewState.idle
          ? Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    tabBarView(
                        context, tabController, provider, provider.controller!),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
              color: ColorConstants.primaryGradient2Color,
            ));
    });
  }

  Widget tabBarView(BuildContext context, TabController controller,
      TimeSheetManagerProvider provider, TabController tabController) {
    return Column(
      children: [
        SizedBox(
          child: Container(
            height: DimensionConstants.d60.h,
            width: DimensionConstants.d375.w,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              ColorConstants.blueGradient1Color,
              ColorConstants.blueGradient2Color
            ])),
            child: Padding(
              padding: EdgeInsets.only(
                  left: DimensionConstants.d8.w,
                  right: DimensionConstants.d8.w,
                  top: DimensionConstants.d10.h,
                  bottom: 0),
              child: TabBar(
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 0.1,
                labelPadding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d3.w),
                indicatorColor: Colors.transparent,
                controller: controller,
                onTap: (index) {
                  if (controller.indexIsChanging) {
                    provider.indexCheck(controller.index);
                  }
                },
                tabs: [
                  Tab(
                    child: Container(
                      width: DimensionConstants.d185.w,
                      height: DimensionConstants.d49.h,
                      decoration: BoxDecoration(
                          color: controller.index == 1
                              ? ColorConstants.colorWhite.withOpacity(0.7)
                              : ColorConstants.colorWhite,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(DimensionConstants.d16.r),
                              topRight:
                                  Radius.circular(DimensionConstants.d16.r))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensionConstants.d10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageView(
                              path: ImageConstants.allProjectIcon,
                              height: DimensionConstants.d24.h,
                              width: DimensionConstants.d24.w,
                            ),
                            SizedBox(
                              width: DimensionConstants.d7.w,
                            ),
                            Text("projects".tr()).boldText(context,
                                DimensionConstants.d16.sp, TextAlign.left,
                                color: ColorConstants.deepBlue)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: DimensionConstants.d185.w,
                      height: DimensionConstants.d49.h,
                      decoration: BoxDecoration(
                          color: controller.index == 0
                              ? ColorConstants.colorWhite.withOpacity(0.7)
                              : ColorConstants.colorWhite,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(DimensionConstants.d16.r),
                              topRight:
                                  Radius.circular(DimensionConstants.d16.r))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensionConstants.d10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ImageView(
                                path: ImageConstants.twoUserIcon,
                                height: DimensionConstants.d24.h,
                                width: DimensionConstants.d24.w,
                                color: ColorConstants.deepBlue),
                            SizedBox(
                              width: DimensionConstants.d7.w,
                            ),
                            Text("crew".tr()).boldText(context,
                                DimensionConstants.d16.sp, TextAlign.left,
                                color: ColorConstants.deepBlue)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: controller.index == 0
              ? DimensionConstants.d570.h
              : DimensionConstants.d580.h,
          // width: DimensionConstants.d313.w,
          child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                projects(context, tabController, provider),
                provider.getAllCrewResponse != null
                    ? crewWidget(context)
                    : noDataFound(context),
              ]),
        ),
      ],
    );
  }

  Widget projects(BuildContext context, TabController controller,
      TimeSheetManagerProvider provider) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: DimensionConstants.d16.h,
        ),
        CommonWidgets.totalProjectsTotalHoursRowTimeSheetManager(
            context,
            provider.totalActiveProjects.toString(),
            DateFunctions.minutesToHourString(
                provider.totalHoursAllActiveProjects ?? 0)),
        tabBarViewWidget(context, controller, provider)
      ],
    );
  }

  Widget tabBarViewWidget(BuildContext context, TabController controller,
      TimeSheetManagerProvider provider) {
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
                controller: provider.controller,
                onTap: (index) {
                  if (controller.indexIsChanging) {
                    provider.updateLoadingStatus(true);
                  }
                  switch (index) {
                    case 0:
                      {
                        provider.startDate =
                            DateFunctions.getCurrentDateMonthYear();
                        provider.endDate =
                            DateFunctions.getCurrentDateMonthYear();
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.projectTimeSheetManager(context);
                        break;
                      }
                    case 1:
                      {
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.nextWeekDays(7);
                        provider.projectTimeSheetManager(context);
                        break;
                      }
                    case 2:
                      {
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.nextWeekDays(14);
                        provider.projectTimeSheetManager(context);
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstants.primaryColor)),
                    )
                  : TabBarView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //  provider.hasProjects ? projectsAndHoursCardList() : zeroProjectZeroHourCard(),
                        //  weeklyTabBarContainerManager(context),
                        provider.projectDataResponse.isNotEmpty
                            ? todayWidget(context)
                            : noDataFound(context),
                        provider.projectDataResponse.isNotEmpty
                            ? weeklyTabBarContainerManager(context, controller)
                            : noDataFound(context),
                        provider.projectDataResponse.isNotEmpty
                            ? weeklyTabBarContainerManager(context,
                                controller) /*biWeeklyTabBarContainerManager(
                                context, controller)*/
                            : noDataFound(context),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget todayWidget(
    BuildContext context,
  ) {
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
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.colorWhite),
                border: Border.all(
                  color: ColorConstants.colorLightGreyF2,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DimensionConstants.d8.r),
                    topRight: Radius.circular(DimensionConstants.d8.r)),
              ),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  projectsHoursRow(context, ImageConstants.mapIcon,
                      "${provider.projectDataResponse.length} ${"projects".tr()}"),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(context, ImageConstants.clockIcon,
                      "${provider.allProjectHour ?? "00:00"} Hours")
                ],
              ),
            ),
            ListView.separated(
              itemCount: provider.projectDataResponse.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    projectHourRowManager(
                        context,
                        Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        provider.projectDataResponse[index].projectName
                            .toString()
                            .substring(0, 2)
                            .toUpperCase(),
                        provider.projectDataResponse[index].projectName
                            .toString(),
                        "${provider.projectDataResponse[index].checkins.length} Crew",
                        "${provider.projectsTotalHours[index]}h",
                        stepperLineWithTwoCoolIcon(), onTap: () {
                      bottomSheetProjectDetailsTimeSheet(
                        context,
                        index,
                        onTap: () {},
                        timeSheetOrSchedule: false,
                        projectColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        projectData: provider.projectDataResponse[index],
                      );
                    }),
                    const Divider(
                        color: ColorConstants.colorGreyDrawer,
                        height: 0.0,
                        thickness: 1.5),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                    color: ColorConstants.colorGreyDrawer,
                    height: 0.0,
                    thickness: 1.5);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget noDataFound(BuildContext context) {
    return Center(
        child: const Text("No Data Found")
            .boldText(context, DimensionConstants.d18.sp, TextAlign.center));
  }

  Widget weeklyTabBarContainerManager(
      BuildContext context, TabController controller) {
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
                        GestureDetector(
                          child: backNextBtn(ImageConstants.backIconIos),
                          onTap: () {
                            provider.previousWeekDays(
                                controller.index == 1 ? 7 : 14);
                            provider.projectTimeSheetManager(context);
                          },
                        ),
                        Text("${DateFunctions.capitalize(provider.weekFirstDate ?? "")} - ${DateFunctions.capitalize(provider.weekEndDate ?? "")}")
                            .boldText(context, DimensionConstants.d16.sp,
                                TextAlign.center,
                                color: ColorConstants.colorWhite),
                        provider.endDate !=
                                DateFormat("yyyy-MM-dd").format(DateTime.now())
                            ? GestureDetector(
                                child: backNextBtn(ImageConstants.nextIconIos),
                                onTap: () {
                                  provider.nextWeekDays(
                                      controller.index == 1 ? 7 : 14);
                                  provider.projectTimeSheetManager(context);
                                },
                              )
                            : Visibility(
                                visible: false,
                                child: backNextBtn(ImageConstants.nextIconIos))
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
                              projectsHoursRow(context, ImageConstants.mapIcon,
                                  "${provider.projectDataResponse.length} ${"projects".tr()}"),
                              Container(
                                height: DimensionConstants.d70.h,
                                width: DimensionConstants.d1.w,
                                color: ColorConstants.colorLightGrey,
                              ),
                              projectsHoursRow(
                                  context,
                                  ImageConstants.clockIcon,
                                  "${provider.allProjectHour ?? "00:00"} ${"hours".tr()}")
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.weeklyData.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  weeklyTabBarDateContainer(context,
                                      provider.weeklyData[index].date ?? ""),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: provider.weeklyData[index]
                                        .projectDataList!.length,
                                    itemBuilder: (context, innerIndex) {
                                      return projectDetailTile(
                                          context, provider, innerIndex,
                                          checkInList: provider
                                              .weeklyData[index]
                                              .projectDataList![innerIndex]
                                              .checkins,
                                          projectName: provider
                                              .weeklyData[index]
                                              .projectDataList![innerIndex]
                                              .projectName,
                                          crewCount: provider
                                              .weeklyData[index]
                                              .projectDataList![innerIndex]
                                              .checkins
                                              .length
                                              .toString());
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                          color: ColorConstants.colorGreyDrawer,
                                          height: 0.0,
                                          thickness: 1.5);
                                    },
                                  ),
                                ],
                              );
                            })
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

/*  Widget biWeeklyTabBarContainerManager(
      BuildContext context, TabController controller) {
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
                        GestureDetector(
                          child: backNextBtn(ImageConstants.backIconIos),
                          onTap: () {
                            provider.previousWeekDays(
                                controller.index == 1 ? 7 : 14);
                            provider.projectTimeSheetManager(context);
                          },
                        ),
                        Text("${DateFunctions.capitalize(provider.weekFirstDate ?? "")} - ${DateFunctions.capitalize(provider.weekEndDate ?? "")}")
                            .boldText(context, DimensionConstants.d16.sp,
                                TextAlign.center,
                                color: ColorConstants.colorWhite),
                        provider.endDate !=
                                DateFormat("yyyy-MM-dd").format(DateTime.now())
                            ? GestureDetector(
                                child: backNextBtn(ImageConstants.nextIconIos),
                                onTap: () {
                                  provider.nextWeekDays(
                                      controller.index == 1 ? 7 : 14);
                                  provider.projectTimeSheetManager(context);
                                },
                              )
                            : Visibility(
                                visible: false,
                                child: backNextBtn(ImageConstants.nextIconIos))
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
                              projectsHoursRow(context, ImageConstants.mapIcon,
                                  "${provider.projectDataResponse.length} ${"projects".tr()}"),
                              Container(
                                height: DimensionConstants.d70.h,
                                width: DimensionConstants.d1.w,
                                color: ColorConstants.colorLightGrey,
                              ),
                              projectsHoursRow(
                                  context,
                                  ImageConstants.clockIcon,
                                  "${provider.allProjectHour!.replaceAll("-", "") ?? "00:00"} ${"hours".tr()}")
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.projectDataResponse.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  weeklyTabBarDateContainer(
                                      context,
                                      provider.dateConvertorWeekly(provider
                                              .projectDataResponse[index]
                                              .date!) ??
                                          ""),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: provider
                                        .projectDataResponse[index]
                                        .checkins
                                        .length,
                                    itemBuilder: (context, innerIndex) {
                                      return projectDetailTile(
                                          context, provider, index,
                                          checkInList: provider
                                              .projectDataResponse[index]
                                              .checkins,
                                          projectName: provider
                                              .projectDataResponse[index]
                                              .projectName,
                                          crewCount: provider
                                              .projectDataResponse[index]
                                              .checkins[innerIndex]
                                              .crew!
                                              .length
                                              .toString());
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                          color: ColorConstants.colorGreyDrawer,
                                          height: 0.0,
                                          thickness: 1.5);
                                    },
                                  ),
                                ],
                              );
                            })
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
  }*/

  Widget backNextBtn(String path) {
    return Container(
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
    );
  }

  Widget projectDetailTile(
      BuildContext context, TimeSheetManagerProvider provider, int listIndex,
      {List<TimeSheetCheckins>? checkInList,
      String? projectName = "",
      String? crewCount}) {
    return GestureDetector(
      onTap: () {
        bottomSheetProjectDetailsTimeSheet(
          context,
          listIndex,
          onTap: () {},
          timeSheetOrSchedule: false,
          projectColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          projectData: provider.projectDataResponse[listIndex],
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: DimensionConstants.d11.h,
              horizontal: DimensionConstants.d16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(DimensionConstants.d5),
                height: DimensionConstants.d40.h,
                width: DimensionConstants.d40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
                child: Text(Validations.getInitials(
                        string: projectName, limitTo: 2))
                    .boldText(
                        context, DimensionConstants.d16.sp, TextAlign.center,
                        color: ColorConstants.colorWhite),
              ),
              SizedBox(width: DimensionConstants.d14.w),
              SizedBox(
                width: DimensionConstants.d120.w,
                child: Text(projectName ?? "").boldText(
                    context, DimensionConstants.d13.sp, TextAlign.start),
              ),
              Expanded(child: Container()),
              Text("$crewCount Crew").regularText(
                  context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d15.w),
              Text("${provider.getOneProjectTotalHours(checkInList).replaceAll("-", "")}h")
                  .semiBoldText(
                      context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d11.w),
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

  Widget weeklyTabBarDateContainer(BuildContext context, String date) {
    return Container(
      color: ColorConstants.colorLightGreyF2,
      height: DimensionConstants.d32.h,
      alignment: Alignment.center,
      child: Text(date).boldText(
          context, DimensionConstants.d13.sp, TextAlign.center,
          color: ColorConstants.colorBlack),
    );
  }

  Widget projectsHoursRow(BuildContext context, String iconPath, String txt) {
    return Row(
      children: [
        ImageView(path: iconPath),
        SizedBox(width: DimensionConstants.d9.w),
        Text(txt).boldText(context, DimensionConstants.d18.sp, TextAlign.center)
      ],
    );
  }

  Widget projectHourRowManager(BuildContext context, Color color, String name,
      String projectName, String totalCrew, String totalTime, Widget stepper,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: DimensionConstants.d11.h,
              horizontal: DimensionConstants.d16.w),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(DimensionConstants.d5),
                  height: DimensionConstants.d40.h,
                  width: DimensionConstants.d40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Text(name).boldText(
                      context, DimensionConstants.d16.sp, TextAlign.center,
                      color: ColorConstants.colorWhite),
                ),
                SizedBox(width: DimensionConstants.d14.w),
                Expanded(
                    child: SizedBox(
                  width: DimensionConstants.d150.h,
                  child: Text(projectName).boldText(
                      context, DimensionConstants.d13.sp, TextAlign.left,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                )),
                SizedBox(width: DimensionConstants.d2.w),
                SizedBox(
                  width: DimensionConstants.d50.w,
                  child: Text(totalCrew).regularText(
                      context, DimensionConstants.d13.sp, TextAlign.center,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                SizedBox(width: DimensionConstants.d15.w),
                Text(totalTime).semiBoldText(
                    context, DimensionConstants.d13.sp, TextAlign.center),
                SizedBox(width: DimensionConstants.d11.w),
                ImageView(
                    path: ImageConstants.forwardArrowIcon,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stepperLineWithOneCoolIcon() {
    return Padding(
      padding: EdgeInsets.only(bottom: DimensionConstants.d13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: DimensionConstants.d4.h,
            width: DimensionConstants.d10.w,
            color: ColorConstants.colorGreen,
          ),
          SizedBox(width: DimensionConstants.d3.w),
          Column(
            children: [
              const ImageView(path: ImageConstants.coolIcon),
              SizedBox(height: DimensionConstants.d2.h),
              Container(
                height: DimensionConstants.d4.h,
                width: DimensionConstants.d10.w,
                color: ColorConstants.colorLightRed,
              )
            ],
          ),
          SizedBox(width: DimensionConstants.d3.w),
          Container(
            height: DimensionConstants.d4.h,
            width: DimensionConstants.d45.w,
            color: ColorConstants.colorGreen,
          )
        ],
      ),
    );
  }

  Widget commonStepper() {
    return Container(
      height: DimensionConstants.d4.h,
      width: DimensionConstants.d75.w,
      decoration: BoxDecoration(
        color: ColorConstants.colorGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(DimensionConstants.d4.r),
        ),
      ),
    );
  }

  Widget stepperLineWithTwoCoolIcon() {
    return Column(
      children: [
        SizedBox(
          width: DimensionConstants.d80.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: DimensionConstants.d4.h,
                width: DimensionConstants.d15.w,
                decoration: BoxDecoration(
                    color: ColorConstants.colorGreen,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DimensionConstants.d4.r),
                        bottomLeft: Radius.circular(DimensionConstants.d4.r))),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const ImageView(
                    path: ImageConstants.coolIcon,
                  ),
                  SizedBox(
                    height: DimensionConstants.d2.h,
                  ),
                  Container(
                    height: DimensionConstants.d4.h,
                    width: DimensionConstants.d5.w,
                    color: ColorConstants.colorLightRed,
                  ),
                ],
              ),
              Container(
                height: DimensionConstants.d4.h,
                width: DimensionConstants.d17.w,
                color: ColorConstants.colorGray,
              ),
              SizedBox(
                width: DimensionConstants.d2.w,
              ),
              Container(
                height: DimensionConstants.d4.h,
                width: DimensionConstants.d8.w,
                color: ColorConstants.colorGreen,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const ImageView(
                    path: ImageConstants.coolIcon,
                  ),
                  SizedBox(
                    height: DimensionConstants.d2.h,
                  ),
                  Container(
                    height: DimensionConstants.d4.h,
                    width: DimensionConstants.d3.w,
                    color: ColorConstants.colorLightRed,
                  ),
                ],
              ),
              Container(
                height: DimensionConstants.d4.h,
                width: DimensionConstants.d8.w,
                decoration: BoxDecoration(
                    color: ColorConstants.colorGreen,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(DimensionConstants.d4.r),
                        bottomRight: Radius.circular(DimensionConstants.d4.r))),
              ),
            ],
          ),
        ),
        SizedBox(
          height: DimensionConstants.d12.h,
        )
      ],
    );
  }

  /*Widget stepperWithGrayAndGreen() {
    return SizedBox(
      width: DimensionConstants.d75.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: DimensionConstants.d4.h,
            width: DimensionConstants.d26.w,
            decoration: BoxDecoration(
                color: ColorConstants.colorGreen,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DimensionConstants.d4.r),
                    bottomLeft: Radius.circular(DimensionConstants.d4.r))),
          ),
          Container(
            height: DimensionConstants.d4.h,
            width: DimensionConstants.d18.w,
            color: ColorConstants.colorGray,
          ),
          Container(
            height: DimensionConstants.d4.h,
            width: DimensionConstants.d26.w,
            decoration: BoxDecoration(
                color: ColorConstants.colorGreen,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DimensionConstants.d4.r),
                    bottomLeft: Radius.circular(DimensionConstants.d4.r))),
          ),
        ],
      ),
    );
  }*/

  Widget crewWidget(BuildContext context) {
    return provider.state == ViewState.busy
        ? const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.primaryColor,
            ),
          )
        : Column(
            children: <Widget>[
              SizedBox(
                height: DimensionConstants.d14.h,
              ),
              CommonWidgets.crewTabProject(
                  context,
                  provider.getAllCrewResponse!.totalCrews.toString() ?? '',
                  provider.getTotalHoursOnProjects(
                          provider.getAllCrewResponse!.data) ??
                      ""),
              SizedBox(
                height: DimensionConstants.d14.h,
              ),
              userProfile(context),
            ],
          );
  }

  Widget userProfile(
    BuildContext context,
  ) {
    return SizedBox(
      height: DimensionConstants.d468.h,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: provider.getAllCrewResponse!.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: DimensionConstants.d16.w,
                vertical: DimensionConstants.d5.h),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstants.timeSheetsFromCrew,
                    arguments: TimeSheetFromCrew(
                      id: provider.getAllCrewResponse!.data![index]!.id!,
                      totalHours:
                          provider.getAllCrewResponse!.data![index].totalHours!,
                    ));
              },
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                child: Container(
                  height: DimensionConstants.d76.h,
                  width: DimensionConstants.d343.w,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstants.d16.w),
                    child: Row(
                      children: <Widget>[
                        provider.getAllCrewResponse!.data![index]!
                                    .profileImage !=
                                null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    DimensionConstants.d25.r),
                                child: ImageView(
                                  path: ApiConstantsManager.BASEURL_IMAGE +
                                      provider.getAllCrewResponse!.data![index]!
                                          .profileImage!,
                                  height: DimensionConstants.d50.h,
                                  width: DimensionConstants.d50.w,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: DimensionConstants.d50.h,
                                width: DimensionConstants.d50.w,
                                decoration: BoxDecoration(
                                    color: ColorConstants.primaryColor,
                                    borderRadius: BorderRadius.circular(
                                        DimensionConstants.d25.r)),
                              ),
                        SizedBox(
                          width: DimensionConstants.d16.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(provider.getAllCrewResponse!.data![index]!
                                          .name ??
                                      "")
                                  .boldText(context, DimensionConstants.d16.sp,
                                      TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      color: ColorConstants.deepBlue),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(provider.getAllCrewResponse!
                                              .data![index]!.speciality ??
                                          "")
                                      .regularText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.left,
                                          color: ColorConstants.deepBlue),
                                  SizedBox(
                                    width: DimensionConstants.d6.w,
                                  ),
                                  Container(
                                    height: DimensionConstants.d3.h,
                                    width: DimensionConstants.d3.w,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.deepBlue,
                                      borderRadius: BorderRadius.circular(
                                          DimensionConstants.d5.r),
                                    ),
                                  ),
                                  SizedBox(
                                    width: DimensionConstants.d6.w,
                                  ),
                                  Text(
                                          "${DateFunctions.minutesToHourString(provider.getAllCrewResponse!.data![index].totalHours!)}"
                                                  " Hours" ??
                                              "")
                                      .regularText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.left,
                                          color: ColorConstants.deepBlue),
                                ],
                              )
                            ],
                          ),
                        ),
                        ImageView(
                          path: ImageConstants.arrowIcon,
                          width: DimensionConstants.d10.w,
                          height: DimensionConstants.d14.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
