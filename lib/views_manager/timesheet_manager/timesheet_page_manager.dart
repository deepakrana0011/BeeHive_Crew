import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/view/base_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Constants/color_constants.dart';
import '../../constants/image_constants.dart';
import '../../helper/common_widgets.dart';
import '../../provider/timesheet_manager_provider.dart';
import '../../widget/bottom_sheet_project_details.dart';
import '../../widget/image_view.dart';

class TimeSheetPageManager extends StatefulWidget {
  const TimeSheetPageManager({Key? key}) : super(key: key);

  @override
  State<TimeSheetPageManager> createState() => _TimeSheetPageManagerState();
}

class _TimeSheetPageManagerState extends State<TimeSheetPageManager>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return BaseView<TimeSheetManagerProvider>(onModelReady: (provider) {
      provider.indexCheck(tabController.index);
      provider.controller = TabController(length: 3, vsync: this);
    }, builder: (context, provider, _) {
      return Scaffold(
        body: Column(
          children: <Widget>[
            tabBarView(context, tabController, provider, provider.controller!),
          ],
        ),
      );
    });
  }
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
                            topLeft: Radius.circular(DimensionConstants.d16.r),
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
                            topLeft: Radius.circular(DimensionConstants.d16.r),
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
        height: controller.index==0? DimensionConstants.d560.h:DimensionConstants.d580.h,
        // width: DimensionConstants.d313.w,
        child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              projects(context, tabController, provider),
              crewWidget(context),
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
          context, "4", "564"),
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
              controller: controller,
              onTap: (index) {
                if (controller.indexIsChanging) {
                  provider.updateLoadingStatus(true);
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
            child: TabBarView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                //  provider.hasProjects ? projectsAndHoursCardList() : zeroProjectZeroHourCard(),
                weeklyTabBarContainerManager(context),
                weeklyTabBarContainerManager(context),
                Icon(Icons.directions_car, size: 350),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget weeklyTabBarContainerManager(BuildContext context) {
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
                      backNextBtn(ImageConstants.backIconIos),
                      Text("Apr 13 - Apr 19").boldText(
                          context, DimensionConstants.d16.sp, TextAlign.center,
                          color: ColorConstants.colorWhite),
                      backNextBtn(ImageConstants.nextIconIos)
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
                                "4 ${"projects".tr()}"),
                            Container(
                              height: DimensionConstants.d70.h,
                              width: DimensionConstants.d1.w,
                              color: ColorConstants.colorLightGrey,
                            ),
                            projectsHoursRow(context, ImageConstants.clockIcon,
                                "07:28 ${"hours".tr()}")
                          ],
                        ),
                      ),
                      weeklyTabBarDateContainer(context, "Tue, April 13"),
                      projectHourRowManager(
                          context,
                          Color(0xFFBB6BD9),
                          "MS",
                          "Momentum Digital",
                          "1 Crew",
                          "12:57h",
                          stepperLineWithTwoCoolIcon(), onTap: () {
                        bottomSheetProjectDetails(
                          context,
                          onTap: () {},
                          timeSheetOrSchedule: false,
                        );
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      projectHourRowManager(
                          context,
                          ColorConstants.primaryGradient1Color,
                          "MD",
                          "Momentum Digital",
                          "1 Crew",
                          "02:57h",
                          stepperWithGrayAndGreen(), onTap: () {
                        bottomSheetProjectDetails(
                          context,
                          onTap: () {},
                          timeSheetOrSchedule: false,
                        );
                      }),
                      weeklyTabBarDateContainer(context, "Wed, April 14"),
                      projectHourRowManager(
                          context,
                          Color(0xFFBB6BD9),
                          "MS",
                          "Momentum Digital",
                          "1 Crew",
                          "12:57h",
                          commonStepper(), onTap: () {
                        bottomSheetProjectDetails(
                          context,
                          onTap: () {},
                          timeSheetOrSchedule: false,
                        );
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      projectHourRowManager(
                          context,
                          ColorConstants.primaryGradient1Color,
                          "MD",
                          "Momentum Digital",
                          "2 Crew",
                          "12:57h",
                          commonStepper(), onTap: () {
                        bottomSheetProjectDetails(
                          context,
                          onTap: () {},
                          timeSheetOrSchedule: false,
                        );
                      }),
                      projectHourRowManager(
                          context,
                          Color(0xFFBB6BD9),
                          "MS",
                          "Momentum Digital",
                          "1 Crew",
                          "12:57h",
                          stepperLineWithOneCoolIcon(), onTap: () {
                        bottomSheetProjectDetails(
                          context,
                          onTap: () {},
                          timeSheetOrSchedule: false,
                        );
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      projectHourRowManager(
                          context,
                          ColorConstants.primaryGradient1Color,
                          "MD",
                          "Momentum Digital",
                          "1 Crew",
                          "12:57h",
                          commonStepper(), onTap: () {
                        bottomSheetProjectDetails(
                          context,
                          onTap: () {},
                          timeSheetOrSchedule: false,
                        );
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      SizedBox(height: DimensionConstants.d60.h),
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
    String startingTime, String endTime, String totalTime, Widget stepper,
    {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
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
                color: color,
              ),
              child: Text(name).boldText(
                  context, DimensionConstants.d16.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
            ),
            SizedBox(width: DimensionConstants.d14.w),
            Text(startingTime)
                .boldText(context, DimensionConstants.d13.sp, TextAlign.center),
            SizedBox(width: DimensionConstants.d14.w),
            SizedBox(width: DimensionConstants.d10.w),
            Text(endTime).regularText(
                context, DimensionConstants.d13.sp, TextAlign.center),
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

Widget crewWidget(BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: DimensionConstants.d14.h,
      ),
      CommonWidgets.crewTabProject(context, "20", "564"),
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
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DimensionConstants.d16.w,
              vertical: DimensionConstants.d5.h),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
            child: Container(
              height: DimensionConstants.d76.h,
              width: DimensionConstants.d343.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: Row(
                  children: <Widget>[
                    ImageView(
                      path: ImageConstants.managerImage,
                      height: DimensionConstants.d50.h,
                      width: DimensionConstants.d50.w,
                    ),
                    SizedBox(
                      width: DimensionConstants.d16.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Benjamin Poole").boldText(
                            context, DimensionConstants.d16.sp, TextAlign.left,
                            color: ColorConstants.deepBlue),
                        Text("Carpenter    \$20.00/hr").regularText(
                            context, DimensionConstants.d14.sp, TextAlign.left,
                            color: ColorConstants.deepBlue),
                      ],
                    ),
                    Expanded(child: Container()),
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
        );
      },
    ),
  );
}
