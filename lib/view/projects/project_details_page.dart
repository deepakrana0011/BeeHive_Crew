import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/project_details_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/route_constants.dart';

class ProjectDetailsPage extends StatefulWidget {
  bool archivedOrProject;
  ProjectDetailsPage({Key? key, required this.archivedOrProject})
      : super(key: key);

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProjectDetailsPageProvider>(
      onModelReady: (provider) {
        provider.tabController = TabController(length: 3, vsync: this);
      },
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "project_details",
              actionIcon: ImageConstants.settingsIcon,
              actionButtonRequired: true, onTapAction: () {
            Navigator.pushNamed(context, RouteConstants.projectSettingsPage);
          }),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: DimensionConstants.d16.h,
                  ),
                  widget.archivedOrProject == true
                      ? projectByArchived(context)
                      : Container(),
                  SizedBox(
                    height: DimensionConstants.d16.h,
                  ),
                  mapAndHoursDetails(context, provider,widget.archivedOrProject),
                  SizedBox(
                    height: DimensionConstants.d10.h,
                  ),
                  tabBarView(context, provider.tabController!, provider,widget.archivedOrProject)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget mapAndHoursDetails(
    BuildContext context, ProjectDetailsPageProvider provider,bool archivedOrNot) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text("Momentum Smart House Project").semiBoldText(
          context, DimensionConstants.d20.sp, TextAlign.left,
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorWhite
              : ColorConstants.colorBlack),
      SizedBox(
        height: DimensionConstants.d15.h,
      ),
      Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: DimensionConstants.d10.h),
            child: ImageView(
              path: ImageConstants.locationIcon,
              color: ColorConstants.primaryColor,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
            ),
          ),
          SizedBox(
            width: DimensionConstants.d8.w,
          ),
          SizedBox(
            height: DimensionConstants.d38.h,
            width: DimensionConstants.d210.w,
            child: const Text("Northfield Road, Toronto, Ontario M1G 2h4 ")
                .regularText(context, DimensionConstants.d16.sp, TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.darkGray4F4F4F),
          ),
          Expanded(child: Container()),
        archivedOrNot != true?  Container(
            height: DimensionConstants.d42.h,
            width: DimensionConstants.d94.w,
            decoration: BoxDecoration(
              border: Theme.of(context).brightness == Brightness.dark
                  ? Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                      width: DimensionConstants.d1.w)
                  : Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.grayD2D2D7,
                      width: DimensionConstants.d1.w),
              borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
            ),
            child: Center(
              child: Text("directions".tr()).semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.center,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack),
            ),
          ):Container()
        ],
      ),
      SizedBox(
        height: DimensionConstants.d13.h,
      ),
      Container(
        height: DimensionConstants.d158.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          child: GoogleMap(
            mapType: MapType.terrain,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            zoomControlsEnabled: false,
            scrollGesturesEnabled: true,
            initialCameraPosition: provider.kLake,
            onMapCreated: (GoogleMapController controller) {
              provider.controller.complete(controller);
            },
          ),
        ),
      ),
      SizedBox(
        height: DimensionConstants.d16.h,
      ),
      Container(
        height: DimensionConstants.d50.h,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.littleDarkGray,
          border: Theme.of(context).brightness == Brightness.dark
              ? Border.all(
                  color: ColorConstants.colorWhite,
                  width: DimensionConstants.d1.w)
              : null,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
          child: Row(
            children: <Widget>[
              Text("total_hours_to_date".tr()).semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack),
              Expanded(child: Container()),
              Text("1200").semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack),
            ],
          ),
        ),
      )
    ],
  );
}

Widget tabBarView(BuildContext context, TabController controller,
    ProjectDetailsPageProvider provider,bool archivedOrNot) {
  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(
          side:
              const BorderSide(color: ColorConstants.colorWhite90, width: 1.5),
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
      SizedBox(
        height: controller.index == 0
            ? DimensionConstants.d780.h
            : DimensionConstants.d1280.h,
        width: DimensionConstants.d343.w,
        child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: <Widget>[
              todayTab(context, true, provider,archivedOrNot),
              todayTab(context, false, provider,archivedOrNot),
              Container(),
            ]),
      )
    ],
  );
}

Widget todayTab(BuildContext context, bool todayOrWeekly,
    ProjectDetailsPageProvider provider,bool archivedOrNot) {
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: DimensionConstants.d15.h,
        ),
        todayOrWeekly == true
            ? stepperLine(context, true, "")
            : weeklyTabBarContainer(context),
        SizedBox(
          height: DimensionConstants.d24.h,
        ),
        Row(
          children: <Widget>[
            Text("notes".tr()).semiBoldText(
                context, DimensionConstants.d20.sp, TextAlign.left,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.colorBlack),
            Expanded(child: Container()),
         archivedOrNot != true?   GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstants.addNotePage);
              },
              child: Container(
                height: DimensionConstants.d40.h,
                width: DimensionConstants.d118,
                decoration: BoxDecoration(
                  color: ColorConstants.deepBlue,
                  border: Theme.of(context).brightness == Brightness.dark
                      ? Border.all(
                          color: ColorConstants.colorWhite,
                          width: DimensionConstants.d1.w)
                      : null,
                  borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d10.w),
                  child: Row(
                    children: <Widget>[
                      ImageView(
                        path: ImageConstants.addNotesIcon,
                        height: DimensionConstants.d16.h,
                        width: DimensionConstants.d16.w,
                      ),
                      SizedBox(
                        width: DimensionConstants.d8.w,
                      ),
                      Text("add_note".tr()).semiBoldText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : ColorConstants.colorWhite),
                    ],
                  ),
                ),
              ),
            ):Container()
          ],
        ),
        SizedBox(
          height: DimensionConstants.d25.h,
        ),
        scaleNotesWidget(context),
        SizedBox(
          height: DimensionConstants.d25.h,
        ),
        crewWidget(context,archivedOrNot),
      ],
    ),
  );
}

Widget stepperLine(BuildContext context, bool todayOrWeek, String date) {
  return GestureDetector(
    onTap: (){
     Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
    },
    child: Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: todayOrWeek == true
              ? BorderRadius.circular(DimensionConstants.d8.r)
              : BorderRadius.zero,
          side: todayOrWeek == true
              ? BorderSide.none
              : BorderSide(
                  width: DimensionConstants.d1.w,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.littleDarkGray)),
      child: Container(
        height: DimensionConstants.d61.h,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.colorWhite,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          border: todayOrWeek == true
              ? Theme.of(context).brightness == Brightness.dark
                  ? Border.all(
                      color: ColorConstants.colorWhite,
                      width: DimensionConstants.d1.w)
                  : null
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
          child: Row(
            children: <Widget>[
              todayOrWeek == true
                  ? Text("8:50a").regularText(
                      context,
                      DimensionConstants.d13.sp,
                      TextAlign.left,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                    )
                  :Row(
                children:<Widget> [
                  Text(date).boldText(
                    context,
                    DimensionConstants.d13.sp,
                    TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack,
                  ),
                  SizedBox(
                    width: DimensionConstants.d9.w,
                  ),Text("8:50a").regularText(
                    context,
                    DimensionConstants.d13.sp,
                    TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack,
                  )

                ],
              ),
            SizedBox(
                width: DimensionConstants.d5.w,
              ),
              Container(
                height: DimensionConstants.d4.h,
                width:todayOrWeek != true? DimensionConstants.d12.w:DimensionConstants.d20.w,
                decoration: BoxDecoration(
                    color: ColorConstants.green6FCF97,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DimensionConstants.d4.r),
                        bottomLeft: Radius.circular(DimensionConstants.d4.r))),
              ),
              SizedBox(
                width: DimensionConstants.d4.w,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: DimensionConstants.d20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const ImageView(
                      path: ImageConstants.coolIcon,
                    ),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    Container(
                      height: DimensionConstants.d4.h,
                      width: todayOrWeek != true? DimensionConstants.d12.w:DimensionConstants.d20.w,
                      color: ColorConstants.redColorEB5757,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: DimensionConstants.d4.w,
              ),
              Container(
                height: DimensionConstants.d4.h,
                width: todayOrWeek != true? DimensionConstants.d12.w:DimensionConstants.d15.w,
                color: ColorConstants.grayD2D2D7,
              ),
              SizedBox(
                width: DimensionConstants.d4.w,
              ),
              Container(
                height: DimensionConstants.d4.h,
                width: todayOrWeek != true? DimensionConstants.d12.w:DimensionConstants.d20.w,
                color: ColorConstants.green6FCF97,
              ),
              SizedBox(
                width: DimensionConstants.d4.w,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: DimensionConstants.d20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const ImageView(
                      path: ImageConstants.coolIcon,
                    ),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    Container(
                      height: DimensionConstants.d4.h,
                      width: todayOrWeek != true? DimensionConstants.d12.w:DimensionConstants.d20.w,
                      color: ColorConstants.redColorEB5757,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: DimensionConstants.d4.w,
              ),
              Container(
                height: DimensionConstants.d4.h,
                width:todayOrWeek != true? DimensionConstants.d8.w:DimensionConstants.d20.w,
                decoration: BoxDecoration(
                    color: ColorConstants.green6FCF97,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(DimensionConstants.d4.r),
                        bottomRight: Radius.circular(DimensionConstants.d4.r))),
              ),
              ImageView(
                path: ImageConstants.stepperIcon,
                height: DimensionConstants.d20.h,
                width: DimensionConstants.d20.w,
              ),
              SizedBox(
                width: DimensionConstants.d5.w,
              ),
              Text("8:50p").regularText(
                context,
                DimensionConstants.d13.sp,
                TextAlign.left,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.colorBlack,
              ),
              SizedBox(
                width: DimensionConstants.d14.w,
              ),
              Text("08:57h").boldText(
                context,
                DimensionConstants.d13.sp,
                TextAlign.left,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.colorBlack,
              ),
              SizedBox(
                width: DimensionConstants.d10.w,
              ),
              ImageView(
                path: ImageConstants.arrowIcon,
                height: DimensionConstants.d10.h,
                width: DimensionConstants.d8.w,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.colorBlack,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget scaleNotesWidget(BuildContext context) {
  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
    child: Container(
      height: DimensionConstants.d186.h,
      decoration: BoxDecoration(
        border: Theme.of(context).brightness == Brightness.dark
            ? Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : Colors.transparent,
                width: DimensionConstants.d1.w)
            : null,
        color: Theme.of(context).brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.colorWhite,
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: ListView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: DimensionConstants.d25.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: Row(
                  children: <Widget>[
                    Text("water_pipe_scale_notes".tr()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack),
                    Expanded(child: Container()),
                    ImageView(
                      path: ImageConstants.arrowIcon,
                      height: DimensionConstants.d10.h,
                      width: DimensionConstants.d8.w,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: DimensionConstants.d20.h,
              ),
              Container(
                height: DimensionConstants.d1.h,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.grayF1F1F1,
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget crewWidget(BuildContext context,bool archivedOrNot) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("crew".tr()).semiBoldText(
        context,
        DimensionConstants.d20.sp,
        TextAlign.left,
        color: Theme.of(context).brightness == Brightness.dark
            ? ColorConstants.colorWhite
            : ColorConstants.deepBlue,
      ),
      SizedBox(
        height: DimensionConstants.d24.h,
      ),
      managerDetails(context, true, "Katharine Wells",archivedOrNot),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.crewProfilePage);
          },
          child: managerDetails(context, false, "Benjamin Poole",archivedOrNot)),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      managerDetails(context, false, "Jason Smith",archivedOrNot)
    ],
  );
}

Widget managerDetails(BuildContext context, bool managerOrNot, String name,bool archivedOrNot) {
  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
    child: Container(
      height: DimensionConstants.d76.h,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.colorWhite,
          border: Theme.of(context).brightness == Brightness.dark
              ? Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorWhite,
                  width: DimensionConstants.d1.w)
              : null,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: managerOrNot == false
                      ? EdgeInsets.only(top: DimensionConstants.d15.h)
                      : EdgeInsets.all(0),
                  child: SizedBox(
                    width: DimensionConstants.d70.w,
                    child: ImageView(
                      path: ImageConstants.managerImage,
                      height: DimensionConstants.d50.h,
                      width: DimensionConstants.d50.w,
                    ),
                  ),
                ),
                managerOrNot == true
                    ? Positioned(
                        top: DimensionConstants.d23.h,
                        left: DimensionConstants.d38.w,
                        child: ImageView(
                          path: ImageConstants.brandIocn,
                          height: DimensionConstants.d27.h,
                          width: DimensionConstants.d29.w,
                        ))
                    : Container(),
              ],
            ),
            SizedBox(
              width: DimensionConstants.d13.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d12.h,
                ),
                Text(name).boldText(
                  context,
                  DimensionConstants.d16.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.deepBlue,
                ),
                SizedBox(
                  height: DimensionConstants.d5.h,
                ),
                managerOrNot == true
                    ? Container(
                        height: DimensionConstants.d21.h,
                        width: DimensionConstants.d120.w,
                        decoration: BoxDecoration(
                          border:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Border.all(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? ColorConstants.colorWhite
                                          : ColorConstants.deepBlue,
                                      width: DimensionConstants.d1.w)
                                  : null,
                          color: ColorConstants.deepBlue,
                          borderRadius:
                              BorderRadius.circular(DimensionConstants.d8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DimensionConstants.d10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const ImageView(
                                path: ImageConstants.crewIcon,
                              ),
                              SizedBox(
                                width: DimensionConstants.d4.w,
                              ),
                              Text("crew_manager".tr()).semiBoldText(context,
                                  DimensionConstants.d10.sp, TextAlign.left,
                                  color: ColorConstants.colorWhite),
                            ],
                          ),
                        ),
                      )
                    : Row(
                  children:<Widget> [
                    Text("carpenter".tr()).regularText(
                      context,
                      DimensionConstants.d14.sp,
                      TextAlign.left,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.deepBlue,
                    ),
                    archivedOrNot == true?const Text("   \$20.00/hr").regularText(
                      context,
                      DimensionConstants.d14.sp,
                      TextAlign.left,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.deepBlue,
                    ):Container()

                  ],
                )
              ],
            ),
            Expanded(child: Container()),
            ImageView(
              path: ImageConstants.arrowIcon,
              height: DimensionConstants.d16.h,
              width: DimensionConstants.d16.w,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack,
            ),
            SizedBox(
              height: DimensionConstants.d39.h,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget weeklyTabBarContainer(BuildContext context) {
  return Container(
    height: DimensionConstants.d544.h,
    decoration: BoxDecoration(
        color: ColorConstants.deepBlue,
        borderRadius:
            BorderRadius.all(Radius.circular(DimensionConstants.d8.r))),
    child: Column(
      children: [
        SizedBox(height: DimensionConstants.d17.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            backNextBtn(ImageConstants.backIconIos),
            SizedBox(
              width: DimensionConstants.d27.w,
            ),
            const Text("Apr13 - Apr19").boldText(
                context, DimensionConstants.d16.sp, TextAlign.center,
                color: ColorConstants.colorWhite),
            SizedBox(
              width: DimensionConstants.d27.w,
            ),
            backNextBtn(ImageConstants.nextIconIos)
          ],
        ),
        SizedBox(
          height: DimensionConstants.d20.h,
        ),
        Container(
          height: DimensionConstants.d481.h,
          decoration: BoxDecoration(
              color: ColorConstants.colorWhite,
              borderRadius:
                  BorderRadius.all(Radius.circular(DimensionConstants.d8.r))),
          child: Column(
            children: <Widget>[
              Container(
                height: DimensionConstants.d54.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(DimensionConstants.d8.r),
                        topLeft: Radius.circular(DimensionConstants.d8.r))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d32.w),
                  child: Row(
                    children: <Widget>[
                      Text("total_hours".tr()).boldText(
                          context, DimensionConstants.d18.sp, TextAlign.left,
                          color: ColorConstants.deepBlue),
                      Expanded(child: Container()),
                      ImageView(
                        path: ImageConstants.clockIconAllProjects,
                        height: DimensionConstants.d24.h,
                        width: DimensionConstants.d24.w,
                      ),
                      SizedBox(
                        width: DimensionConstants.d8.w,
                      ),
                      Text("31:02").boldText(
                          context, DimensionConstants.d18.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.deepBlue
                              : ColorConstants.deepBlue),
                    ],
                  ),
                ),
              ),
              stepperLine(context, false, "Apr 13"),
              stepperLine(context, false, "Apr 14"),
              stepperLine(context, false, "Apr 15"),
              stepperLine(context, false, "Apr 16"),
              stepperLine(context, false, "Apr 17"),
              stepperLine(context, false, "Apr 18"),
              stepperLine(context, false, "Apr 19"),
            ],
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

Widget projectByArchived(BuildContext context) {
  return Container(
    height: DimensionConstants.d42.h,
    width: DimensionConstants.d343.w,
    decoration: BoxDecoration(
      color: ColorConstants.redColorEB5757.withOpacity(0.1),
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d14.w),
      child: Row(
        children: <Widget>[
          ImageView(
            path: ImageConstants.folderIcon,
            height: DimensionConstants.d24.h,
            width: DimensionConstants.d24.w,
          ),
          SizedBox(
            width: DimensionConstants.d9.w,
          ),
          Text("this_project_was_archived_by_the_crew_manager".tr())
              .regularText(context, DimensionConstants.d14.sp, TextAlign.left),
        ],
      ),
    ),
  );
}
