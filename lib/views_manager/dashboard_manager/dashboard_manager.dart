import 'dart:math';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/model/crew_dashboard_response.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/provider/dashboard_page_manager_provider.dart';
import 'package:beehive/provider/drawer_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/custom_tab_bar.dart';
import 'package:beehive/widget/custom_tab_bar_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../constants/image_constants.dart';
import '../../locator.dart';
import '../../provider/bottom_bar_Manager_provider.dart';
import '../../provider/bottom_bar_provider.dart';
import '../../widget/image_view.dart';

class DashBoardPageManager extends StatefulWidget {
  const DashBoardPageManager({Key? key}) : super(key: key);

  @override
  _DashBoardPageManagerState createState() => _DashBoardPageManagerState();
}

class _DashBoardPageManagerState extends State<DashBoardPageManager>
    with TickerProviderStateMixin {
  DrawerManagerProvider? drawerManagerProvider;
  BottomBarManagerProvider? managerProvider;

  @override
  void initState() {
    managerProvider =
        Provider.of<BottomBarManagerProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DashBoardPageManagerProvider>(onModelReady: (provider) {
      provider.startDate = DateFunctions.getCurrentDateMonthYear();
      provider.endDate = DateFunctions.getCurrentDateMonthYear();
      provider.dashBoardApi(context, managerProvider, showFullLoader: true);
      provider.controller = TabController(length: 3, vsync: this);
    }, builder: (context, provider, _) {
      return provider.state == ViewState.idle
          ? Scaffold(
              body: Column(
              children: <Widget>[
                activeProjectWidget(context, provider),
                tabBarView(
                    provider.controller!, context, provider, managerProvider!)
              ],
            ))
          : const Center(
              child: CircularProgressIndicator(
              color: ColorConstants.primaryGradient2Color,
            ));
    });
  }
}

Widget activeProjectWidget(
    BuildContext context, DashBoardPageManagerProvider provider) {
  return Container(
    height: DimensionConstants.d151.h,
    width: double.infinity,
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
      ColorConstants.blueGradient1Color,
      ColorConstants.blueGradient2Color
    ])),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: DimensionConstants.d16.h,
          ),
          Text("Hey  ${provider.managerResponse!.manager?.name!},\nwhat’s buzzing?")
              .boldText(context, DimensionConstants.d18.sp, TextAlign.left,
                  color: ColorConstants.colorWhite),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          Row(
            children: <Widget>[
              crewAndActiveProject(
                  context,
                  provider.managerResponse!.activeProject.toString(),
                  "active_projects"),
              Expanded(child: Container()),
              crewAndActiveProject(
                  context,
                  provider.managerResponse!.crewmembers.toString(),
                  "crew_members"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget crewAndActiveProject(
    BuildContext context, String number, String tabName) {
  return Container(
    height: DimensionConstants.d65.h,
    width: DimensionConstants.d169.w,
    decoration: BoxDecoration(
      color: ColorConstants.deepBlue,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(number).semiBoldText(
            context, DimensionConstants.d22.sp, TextAlign.center,
            color: ColorConstants.colorWhite),
        Text(tabName.tr()).regularText(
            context, DimensionConstants.d14.sp, TextAlign.center,
            color: ColorConstants.colorWhite),
      ],
    ),
  );
}

Widget tabBarView(
    TabController controller,
    BuildContext context,
    DashBoardPageManagerProvider provider,
    BottomBarManagerProvider managerProvider) {
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
                      provider.dashBoardApi(context, managerProvider);
                      break;
                    }
                  case 1:
                    {
                      provider.selectedStartDate = null;
                      provider.selectedEndDate = null;
                      provider.nextWeekDays(7);
                      provider.dashBoardApi(context, managerProvider);
                      break;
                    }
                  case 2:
                    {
                      provider.selectedStartDate = null;
                      provider.selectedEndDate = null;
                      provider.nextWeekDays(14);
                      provider.dashBoardApi(context, managerProvider);
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
                      ? Text("today".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.center,
                          color: ColorConstants.colorWhite)
                      : Text("today".tr()).regularText(
                          context, DimensionConstants.d16.sp, TextAlign.center),
                ),
                Container(
                  alignment: Alignment.center,
                  height: DimensionConstants.d50.h,
                  width: DimensionConstants.d114.w,
                  child: controller.index == 1
                      ? Text("weekly".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.center,
                          color: ColorConstants.colorWhite)
                      : Text("weekly".tr()).regularText(
                          context, DimensionConstants.d16.sp, TextAlign.center),
                ),
                Container(
                  alignment: Alignment.center,
                  height: DimensionConstants.d50.h,
                  width: DimensionConstants.d114.w,
                  child: controller.index == 2
                      ? Text("bi_weekly".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.center,
                          color: ColorConstants.colorWhite)
                      : Text("bi_weekly".tr()).regularText(
                          context, DimensionConstants.d16.sp, TextAlign.center),
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
                      provider.managerResponse!.projectData!.isNotEmpty
                          ? todayDataWidget(context, provider)
                          : noDataFound(context),
                      /*provider.responseManager!.projectData!.isNotEmpty
                          ? */
                      weeklyTabBarContainerManager(
                          context, provider, managerProvider, controller),
                      // : noDataFound(context),
                      /*provider.responseManager!.projectData!.isNotEmpty
                          ?*/
                      weeklyTabBarContainerManager(
                          context, provider, managerProvider, controller),
                      //: noDataFound(context),
                    ],
                  ),
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

Widget todayDataWidget(
    BuildContext context, DashBoardPageManagerProvider provider) {
  return Padding(
    padding: EdgeInsets.only(top: DimensionConstants.d16.h),
    child: Card(
      margin: EdgeInsets.only(bottom: DimensionConstants.d20.h),
      elevation: 2.5,
      color: (Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorBlack
          : ColorConstants.colorWhite),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ColorConstants.grayF1F1F1, width: 1.0),
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: SingleChildScrollView(
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
                  projectsHoursRow(context, ImageConstants.mapIcon,
                      "${provider.managerResponse!.projectData!.length} ${"projects".tr()}"),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(context, ImageConstants.clockIcon,
                      "${provider.allProjectHour} ${"hours".tr()}")
                ],
              ),
            ),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRowManager(context, provider),
          ],
        ),
      ),
    ),
  );
}

Widget weeklyTabBarContainerManager(
    BuildContext context,
    DashBoardPageManagerProvider provider,
    BottomBarManagerProvider barProvider,
    TabController controller) {
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
                          provider
                              .previousWeekDays(controller.index == 1 ? 7 : 14);
                          provider.dashBoardApi(context, barProvider);
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
                                provider.dashBoardApi(context, barProvider);
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
                                "${provider.managerResponse!.projectData!.length} ${"projects".tr()}"),
                            Container(
                              height: DimensionConstants.d70.h,
                              width: DimensionConstants.d1.w,
                              color: ColorConstants.colorLightGrey,
                            ),
                            projectsHoursRow(context, ImageConstants.clockIcon,
                                "${provider.allProjectHour??"00:00"} ${"hours".tr()}")
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.weeklyData.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                weeklyTabBarDateContainer(context,
                                    provider.weeklyData[index].date ?? ""),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.weeklyData[index]
                                      .checkInDataList!.length,
                                  itemBuilder: (context, innerIndex) {
                                    return projectDetailTile(context, provider,
                                        checkInList: provider.weeklyData[index!].checkInDataList,
                                        projectName: provider
                                            .weeklyData[index].projectName,
                                        crewCount: provider.weeklyData[index]
                                            .checkInDataList!.length
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
        SizedBox(
          height: DimensionConstants.d70.h,
        ),
      ],
    ),
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

Widget projectHourRowManager(
    BuildContext context, DashBoardPageManagerProvider provider) {
  return Container(
    height: DimensionConstants.d240.h,
    width: DimensionConstants.d400.w,
    child: ListView.separated(
      itemCount: provider.managerResponse!.projectData!.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.transparent,
          child: projectDetailTile(context, provider,
              checkInList: provider.managerResponse!.projectData![index].checkins,
              projectName: provider.managerResponse!.projectData![index].projectName,
              crewCount: provider.managerResponse!.projectData![index].checkins!.length
                  .toString()),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
            color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5);
      },
    ),
  );
}

Widget projectDetailTile(
    BuildContext context, DashBoardPageManagerProvider provider,
    {List<CheckInProjectDetailManager>? checkInList, String? projectName = "", String? crewCount}) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: DimensionConstants.d11.h,
          horizontal: DimensionConstants.d16.w),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(DimensionConstants.d5),
            height: DimensionConstants.d40.h,
            width: DimensionConstants.d40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
            child:
                Text(Validations.getInitials(string: projectName, limitTo: 2))
                    .boldText(
                        context, DimensionConstants.d16.sp, TextAlign.center,
                        color: ColorConstants.colorWhite),
          ),
          SizedBox(width: DimensionConstants.d14.w),
          Container(
            width: DimensionConstants.d120.w,
            child: Text(projectName ?? "")
                .boldText(context, DimensionConstants.d13.sp, TextAlign.center),
          ),
          SizedBox(
            width: DimensionConstants.d24.w,
          ),
          Text("$crewCount Crew").regularText(
              context, DimensionConstants.d13.sp, TextAlign.center),
          SizedBox(width: DimensionConstants.d15.w),
          Text("${provider.getOneProjectTotalHours(checkInList)}h")
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

Widget stepperWithGrayAndGreen() {
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
}
