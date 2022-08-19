import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/timesheet_from_crew_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../helper/dialog_helper.dart';

class TimeSheetFromCrew extends StatefulWidget {
  const TimeSheetFromCrew({Key? key}) : super(key: key);

  @override
  State<TimeSheetFromCrew> createState() => _TimeSheetFromCrewState();
}

class _TimeSheetFromCrewState extends State<TimeSheetFromCrew>with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<TimeSheetFromCrewProvider>(
        onModelReady: (provider){
          provider.controller = TabController(length: 3, vsync: this);

        },

        builder: (context,provider,_){
          return Scaffold(
            appBar: CommonWidgets.appBarWithTitleAndAction(context,
                title: "timesheets".tr(), actionButtonRequired: false),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                userProfile(context),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                CommonWidgets.crewTabProjectTimeSheet(context, "2", "951"),
                tabBarViewWidget(context, provider.controller!, provider)
              ],
            ),
          );
        });
  }
}

Widget userProfile(BuildContext context) {
  return GestureDetector(
    onTap: (){
      Navigator.pushNamed(context, RouteConstants.crewPageProfileManager);
    },
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d55.w),
      child: Row(
        children: <Widget>[
          ImageView(
            path: ImageConstants.managerImage,
            height: DimensionConstants.d93.h,
            width: DimensionConstants.d93.w,
          ),
          SizedBox(
            width: DimensionConstants.d23.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Benjamin Poole").boldText(
                  context, DimensionConstants.d18.sp, TextAlign.left,
                  color: ColorConstants.deepBlue),
              Row(
                children: <Widget>[
                  Text("Carpenter").semiBoldText(
                      context, DimensionConstants.d14.sp, TextAlign.left,
                      color: ColorConstants.deepBlue),
                  SizedBox(
                    width: DimensionConstants.d3.w,
                  ),
                  const Icon(
                    Icons.circle,
                    size: DimensionConstants.d5,
                  ),
                  SizedBox(
                    width: DimensionConstants.d3.w,
                  ),
                  Text("\$20.00/hr").semiBoldText(
                      context, DimensionConstants.d14.sp, TextAlign.left,
                      color: ColorConstants.deepBlue),
                ],
              ),
              SizedBox(
                height: DimensionConstants.d10.h,
              ),
              Container(
                height: DimensionConstants.d42.h,
                width: DimensionConstants.d134.w,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorConstants.grayD2D2D2,
                        width: DimensionConstants.d1.w),
                    borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
                child: Center(
                  child: Text("view_profile".tr()).semiBoldText(
                      context, DimensionConstants.d14.sp, TextAlign.center,
                      color: ColorConstants.deepBlue),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
Widget tabBarViewWidget(BuildContext context, TabController controller, TimeSheetFromCrewProvider provider) {
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
                      SizedBox(
                        height: DimensionConstants.d120.h,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index){
                          return Slidable(
                            key: const ValueKey(0),
                            endActionPane:  ActionPane(
                              extentRatio: 0.3,
                              motion: const ScrollMotion(),
                              children: [
                                Expanded(
                                  child: Container(
                                    height: DimensionConstants.d58.h,
                                  color: ColorConstants.redColorEB5757,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: DimensionConstants.d25.w),
                                    child: Row(
                                      children:<Widget> [
                                        const ImageView(path: ImageConstants.ignoreIcon,color: ColorConstants.colorWhite,),
                                        SizedBox(width: DimensionConstants.d8.w,),
                                        Text("ignore".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorWhite)
                                      ],
                                    ),
                                  ),
                                  ),
                                )
                              ],
                            ),
                            child:projectHourRow(context,Color(0xFFBB6BD9), "MS", "8:50a", "10:47a", "02:57h", commonStepper()),
                          );

                        }),
                      ),
                      weeklyTabBarDateContainer(context, "Tue, April 13"),
                      SizedBox(
                        height: DimensionConstants.d120.h,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index){
                              return Slidable(

                                key: const ValueKey(0),
                                endActionPane:  ActionPane(
                                  extentRatio: 0.3,
                                  motion: const ScrollMotion(),
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: DimensionConstants.d58.h,
                                        color: ColorConstants.redColorEB5757,
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: DimensionConstants.d25.w),
                                          child: Row(
                                            children:<Widget> [
                                              const ImageView(path: ImageConstants.ignoreIcon,color: ColorConstants.colorWhite,),
                                              SizedBox(width: DimensionConstants.d8.w,),
                                              Text("ignore".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorWhite)
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                child: projectHourRow(context,
                                    Color(0xFFBB6BD9),
                                    "MS",
                                    "8:50a",
                                    "10:47a",
                                    "02:57h",
                                    stepperLineWithTwoCoolIcon(), onTap: () {

                                }),
                              );

                            }),
                      ),

                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      SizedBox(height: DimensionConstants.d16.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensionConstants.d16.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text("total_hours".tr()).semiBoldText(
                                    context,
                                    DimensionConstants.d14.sp,
                                    TextAlign.center),
                                Text("48:28 Hrs").semiBoldText(
                                    context,
                                    DimensionConstants.d14.sp,
                                    TextAlign.center)
                              ],
                            ),
                            SizedBox(height: DimensionConstants.d6.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$20.00/hr").semiBoldText(
                                    context,
                                    DimensionConstants.d14.sp,
                                    TextAlign.center),
                                Text("\$805.00").semiBoldText(
                                    context,
                                    DimensionConstants.d14.sp,
                                    TextAlign.center)
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: DimensionConstants.d16.h,),
                      exportTimeSheetBtn(context),
                      SizedBox(height: DimensionConstants.d20.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: DimensionConstants.d50.h,)
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
Widget projectsHoursRow(BuildContext context, String iconPath, String txt) {
  return Row(
    children: [
      ImageView(path: iconPath),
      SizedBox(width: DimensionConstants.d9.w),
      Text(txt).boldText(context, DimensionConstants.d18.sp, TextAlign.center)
    ],
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
Widget projectHourRow( BuildContext context,Color color, String name, String startingTime, String endTime, String totalTime, Widget stepper, {VoidCallback? onTap}) {
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
            Text(startingTime).regularText(
                context, DimensionConstants.d13.sp, TextAlign.center),
            SizedBox(width: DimensionConstants.d14.w),
            stepper,
            SizedBox(width: DimensionConstants.d10.w),
            Text(endTime).regularText(
                context, DimensionConstants.d13.sp, TextAlign.center),
            SizedBox(width: DimensionConstants.d15.w),
            Text(totalTime).boldText(
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
