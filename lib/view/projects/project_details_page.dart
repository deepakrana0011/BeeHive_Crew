import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/model/project_working_hour_detail.dart';
import 'package:beehive/provider/project_details_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/projects/project_settings_page.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/route_constants.dart';
import '../../model/project_detail_crew_response.dart';

class ProjectDetailsPage extends StatefulWidget {
  bool archivedOrProject;
  String? projectId;
  String? totalHoursToDate;

  ProjectDetailsPage(
      {Key? key,
      required this.archivedOrProject,
      this.projectId,
      this.totalHoursToDate})
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
        provider.projectId = widget.projectId;
        provider.tabController = TabController(length: 3, vsync: this);
        provider.startDate = DateFunctions.getCurrentDateMonthYear();
        provider.endDate = DateFunctions.getCurrentDateMonthYear();
        provider.setCustomMapPinUser();
        provider.getProjectDetail(context);
      },
      builder: (context, provider, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: CommonWidgets.appBarWithTitleAndAction(context,
                  title: "project_details",
                  actionIcon: ImageConstants.settingsIcon,
                  actionButtonRequired: widget.archivedOrProject == true
                      ? false
                      : true, onTapAction: () {
                Navigator.pushNamed(context, RouteConstants.projectSettingsPage,
                        arguments: ProjectSettingsPage(
                            projectData: provider
                                .projectDetailCrewResponse!.projectData!))
                    .then((value) {
                  if (value == true) {
                    Navigator.of(context).pop(true);
                  }
                });
              }, popFunction: () {
                CommonWidgets.hideKeyboard(context);
                Navigator.pop(context);
              }),
              body: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
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
                      mapAndHoursDetails(
                          context,
                          provider,
                          widget.archivedOrProject,
                          widget.totalHoursToDate ?? ""),
                      SizedBox(
                        height: DimensionConstants.d10.h,
                      ),
                      tabBarView(context, provider.tabController!, provider,
                          widget.archivedOrProject),
                      SizedBox(
                        height: DimensionConstants.d24.h,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Text("notes".tr()).semiBoldText(context,
                                  DimensionConstants.d20.sp, TextAlign.left,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorConstants.colorWhite
                                      : ColorConstants.colorBlack)),
                          /*GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConstants.addNotePageManager,
                                  arguments: AddNotePageManager(
                                    isPrivate: false,
                                    projectId: provider.projectDetailResponse!
                                        .projectData!.projectDataId!,
                                  )).then((value) {
                                provider.getProjectDetail(context);
                              });
                            },
                            child: Container(
                              height: DimensionConstants.d40.h,
                              width: DimensionConstants.d118,
                              decoration: BoxDecoration(
                                color: ColorConstants.deepBlue,
                                border: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Border.all(
                                    color: ColorConstants.colorWhite,
                                    width: DimensionConstants.d1.w)
                                    : null,
                                borderRadius: BorderRadius.circular(
                                    DimensionConstants.d8.r),
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
                                    Text("add_note".tr()).semiBoldText(context,
                                        DimensionConstants.d14.sp, TextAlign.left,
                                        color: Theme.of(context).brightness ==
                                            Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorWhite),
                                  ],
                                ),
                              ),
                            ),
                          )*/
                        ],
                      ),
                      if (provider.projectDetailCrewResponse != null &&
                          provider.projectDetailCrewResponse!.projectData!
                              .notes!.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(
                              height: DimensionConstants.d25.h,
                            ),
                            notesList(
                                context,
                                provider.projectDetailCrewResponse!.projectData!
                                    .notes!),
                          ],
                        ),
                      SizedBox(
                        height: DimensionConstants.d25.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text("crew".tr()).semiBoldText(context,
                              DimensionConstants.d20.sp, TextAlign.left,
                              color: ColorConstants.colorBlack),
                          Expanded(child: Container()),
                          /*GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConstants.addCrewPageManager,
                                  arguments: AddCrewPageManager(crewList: provider.projectDetailResponse!.projectData!.crews!,projectId: provider.projectId));
                            },
                            child: Container(
                              height: DimensionConstants.d40.h,
                              width: DimensionConstants.d118,
                              decoration: BoxDecoration(
                                color: ColorConstants.deepBlue,
                                border: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Border.all(
                                    color: ColorConstants.colorWhite,
                                    width: DimensionConstants.d1.w)
                                    : null,
                                borderRadius: BorderRadius.circular(
                                    DimensionConstants.d8.r),
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
                                    Text("add_crew".tr()).semiBoldText(context,
                                        DimensionConstants.d14.sp, TextAlign.left,
                                        color: Theme.of(context).brightness ==
                                            Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorWhite),
                                  ],
                                ),
                              ),
                            ),
                          )*/
                        ],
                      ),
                      if (provider.projectDetailCrewResponse != null &&
                          provider.projectDetailCrewResponse!.projectData!
                              .crews!.isNotEmpty)
                        crewList(context, true, provider),
                      SizedBox(
                        height: DimensionConstants.d18.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (provider.state == ViewState.busy) CustomCircularBar()
          ],
        );
      },
    );
  }
}

Widget mapAndHoursDetails(
    BuildContext context,
    ProjectDetailsPageProvider provider,
    bool archivedOrNot,
    String totalHoursToDate) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(provider.projectDetailCrewResponse?.projectData?.projectName ?? "")
          .semiBoldText(context, DimensionConstants.d20.sp, TextAlign.left,
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
            child: Text(
                    provider.projectDetailCrewResponse?.projectData?.address ??
                        "")
                .regularText(context, DimensionConstants.d16.sp, TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.darkGray4F4F4F),
          ),
          Expanded(child: Container()),
          archivedOrNot != true
              ? GestureDetector(
                  onTap: () async {
                    String googleUrl =
                        'https://www.google.com/maps/search/?api=1&query=${provider.projectDetailCrewResponse!.projectData!.latitude},${provider.projectDetailCrewResponse!.projectData!.longitude}';
                    await launchUrl(Uri.parse(googleUrl));
                  },
                  child: Container(
                    height: DimensionConstants.d42.h,
                    width: DimensionConstants.d94.w,
                    decoration: BoxDecoration(
                      border: Theme.of(context).brightness == Brightness.dark
                          ? Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack,
                              width: DimensionConstants.d1.w)
                          : Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.grayD2D2D7,
                              width: DimensionConstants.d1.w),
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d8.r),
                    ),
                    child: Center(
                      child: Text("directions".tr()).semiBoldText(
                          context, DimensionConstants.d14.sp, TextAlign.center,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : ColorConstants.colorBlack),
                    ),
                  ),
                )
              : Container()
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
            markers: Set<Marker>.of(provider.markers),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  provider.projectDetailCrewResponse?.projectData?.latitude ??
                      0.0,
                  provider.projectDetailCrewResponse?.projectData?.latitude ??
                      0.0),
              zoom: 11.0,
            ),
            onMapCreated: (controller) {
              provider.googleMapController = controller;
              provider.customNotify();
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
              Text(provider.getToTalHours()/*totalHoursToDate != ""
                      ? totalHoursToDate
                      : (provider.projectDetailCrewResponse == null
                          ? ""
                          : (provider.projectDetailCrewResponse?.projectData
                                      ?.checkins?.isEmpty ==
                                  true
                              ? ""
                              : "${DateFunctions.calculateTotalHourTime(provider.projectDetailCrewResponse!.projectData!.checkins![0].checkInTime!, provider.projectDetailCrewResponse!.projectData!.checkins![0].checkOutTime!)} h"))*/)
                  .semiBoldText(
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
    ProjectDetailsPageProvider provider, bool archivedOrNot) {
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
            provider.customNotify();
            switch (index) {
              case 0:
                {
                  provider.startDate = DateFunctions.getCurrentDateMonthYear();
                  provider.endDate = DateFunctions.getCurrentDateMonthYear();
                  provider.selectedStartDate = null;
                  provider.selectedEndDate = null;
                  provider.getProjectDetail(context);
                  break;
                }
              case 1:
                {
                  provider.selectedStartDate = null;
                  provider.selectedEndDate = null;
                  provider.nextWeekDays(7);
                  provider.getProjectDetail(context);
                  break;
                }
              case 2:
                {
                  provider.selectedStartDate = null;
                  provider.selectedEndDate = null;
                  provider.nextWeekDays(14);
                  provider.getProjectDetail(context);
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
      provider.tabController!.index == 0
          ? todayTab(context, provider)
          : weeklyTabBarContainer(context, provider)
    ],
  );
}

Widget todayTab(BuildContext context, ProjectDetailsPageProvider provider) {
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (provider.projectDetailCrewResponse != null &&
            provider
                .projectDetailCrewResponse!.projectData!.checkins!.isNotEmpty)
          crewDetail(context, provider,
              provider.projectDetailCrewResponse!.projectData!.checkins![0],
              isToday: true)
        //stepperLine(context,),
      ],
    ),
  );
}

Widget crewDetail(BuildContext context, ProjectDetailsPageProvider provider,
    CheckInProjectDetailManager checkInDetail,
    {bool isToday = false}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        child: SizedBox(
          height: DimensionConstants.d61.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!isToday)
                  Row(
                    children: [
                      Text(DateFunctions.capitalize(DateFunctions.getMonthDay(
                              DateFunctions.getDateTimeFromString(
                                  checkInDetail.checkInTime!))))
                          .boldText(
                        context,
                        DimensionConstants.d13.sp,
                        TextAlign.left,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack,
                      ),
                      SizedBox(
                        width: DimensionConstants.d9.w,
                      ),
                    ],
                  ),
                Text(DateFunctions.dateTO12Hour(checkInDetail.checkInTime!)
                        .substring(
                            0,
                            DateFunctions.dateTO12Hour(
                                        checkInDetail.checkInTime!)
                                    .length -
                                1))
                    .regularText(
                  context,
                  DimensionConstants.d13.sp,
                  TextAlign.left,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
                ),
                SizedBox(
                  width: DimensionConstants.d9.w,
                ),
                customStepper(provider, checkInDetail),
                SizedBox(
                  width: DimensionConstants.d9.w,
                ),
                Text(DateFunctions.dateTO12Hour(
                            (checkInDetail.checkOutTime == null ||
                                    checkInDetail.checkOutTime!.trim().isEmpty)
                                ? DateFunctions.dateFormatyyyyMMddHHmm(
                                    DateTime.now())
                                : checkInDetail.checkOutTime!)
                        .substring(
                            0,
                            DateFunctions.dateTO12Hour((checkInDetail
                                                    .checkOutTime ==
                                                null ||
                                            checkInDetail.checkOutTime!
                                                .trim()
                                                .isEmpty)
                                        ? DateFunctions.dateFormatyyyyMMddHHmm(
                                            DateTime.now())
                                        : checkInDetail.checkOutTime!)
                                    .length -
                                1))
                    .regularText(
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
                Text("${DateFunctions.calculateTotalHourTime(checkInDetail.checkInTime!, (checkInDetail.checkOutTime == null || checkInDetail.checkOutTime!.trim().isEmpty) ? DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now()) : checkInDetail.checkOutTime!)} h")
                    .boldText(
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
    ),
  );
}

/*Widget stepperLine(BuildContext context) {
  return GestureDetector(
    onTap: () {
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
                  : Row(
                children: <Widget>[
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
                  ),
                  Text("8:50a").regularText(
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
                width: todayOrWeek != true
                    ? DimensionConstants.d12.w
                    : DimensionConstants.d20.w,
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
                      width: todayOrWeek != true
                          ? DimensionConstants.d12.w
                          : DimensionConstants.d20.w,
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
                width: todayOrWeek != true
                    ? DimensionConstants.d12.w
                    : DimensionConstants.d15.w,
                color: ColorConstants.grayD2D2D7,
              ),
              SizedBox(
                width: DimensionConstants.d4.w,
              ),
              Container(
                height: DimensionConstants.d4.h,
                width: todayOrWeek != true
                    ? DimensionConstants.d12.w
                    : DimensionConstants.d20.w,
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
                      width: todayOrWeek != true
                          ? DimensionConstants.d12.w
                          : DimensionConstants.d20.w,
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
                width: todayOrWeek != true
                    ? DimensionConstants.d8.w
                    : DimensionConstants.d20.w,
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
}*/

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

Widget managerDetails(
    BuildContext context, bool managerOrNot, String name, bool archivedOrNot) {
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
                        children: <Widget>[
                          Text("carpenter".tr()).regularText(
                            context,
                            DimensionConstants.d14.sp,
                            TextAlign.left,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.deepBlue,
                          ),
                          archivedOrNot == true
                              ? const Text("   \$20.00/hr").regularText(
                                  context,
                                  DimensionConstants.d14.sp,
                                  TextAlign.left,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorConstants.colorWhite
                                      : ColorConstants.deepBlue,
                                )
                              : Container()
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

Widget weeklyTabBarContainer(
    BuildContext context, ProjectDetailsPageProvider provider) {
  return Container(
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
            GestureDetector(
              child: backNextBtn(ImageConstants.backIconIos),
              onTap: () {
                provider.previousWeekDays(
                    provider.tabController!.index == 1 ? 7 : 14);
                provider.getProjectDetail(
                  context,
                );
              },
            ),
            SizedBox(
              width: DimensionConstants.d27.w,
            ),
            Text("${DateFunctions.capitalize(provider.weekFirstDate ?? "")} - ${DateFunctions.capitalize(provider.weekEndDate ?? "")}")
                .boldText(context, DimensionConstants.d16.sp, TextAlign.center,
                    color: ColorConstants.colorWhite),
            SizedBox(
              width: DimensionConstants.d27.w,
            ),
            provider.endDate != DateFormat("yyyy-MM-dd").format(DateTime.now())
                ? GestureDetector(
                    child: backNextBtn(ImageConstants.nextIconIos),
                    onTap: () {
                      provider.nextWeekDays(
                          provider.tabController!.index == 1 ? 7 : 14);
                      provider.getProjectDetail(
                        context,
                      );
                    },
                  )
                : Visibility(
                    visible: false,
                    child: backNextBtn(ImageConstants.nextIconIos))
          ],
        ),
        SizedBox(
          height: DimensionConstants.d20.h,
        ),
        Container(
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
                      Text(provider.getToTalHours()).boldText(
                          context, DimensionConstants.d18.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.deepBlue
                              : ColorConstants.deepBlue),
                    ],
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider
                    .projectDetailCrewResponse!.projectData!.checkins!.length,
                itemBuilder: (context, innerIndex) {
                  return crewDetail(
                      context,
                      provider,
                      provider.projectDetailCrewResponse!.projectData!
                          .checkins![innerIndex]);
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                      color: ColorConstants.colorGreyDrawer,
                      height: 0.0,
                      thickness: 1.5);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget backNextBtn(String path, {onTap}) {
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

Widget notesList(BuildContext context, List<Note> notes) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
    child: ListView.builder(
      itemCount: notes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.showNotePageCrew,
                arguments: notes[index]);
          },
          child: Column(
            children: <Widget>[
              SizedBox(
                height: DimensionConstants.d25.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(notes[index].title ?? "").regularText(
                            context, DimensionConstants.d14.sp, TextAlign.left,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.colorBlack,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
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
          ),
        );
      },
    ),
  );
}

Widget crewList(BuildContext context, bool archivedOrNot,
    ProjectDetailsPageProvider provider) {
  return ListView.builder(
    itemCount:
        provider.projectDetailCrewResponse!.projectData!.crews!.length + 1,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return crewWidget(context, false, provider, index);
    },
  );
}

Widget crewWidget(BuildContext context, bool archivedOrNot,
    ProjectDetailsPageProvider provider, int index) {
  // : "${ApiConstantsCrew.BASE_URL_IMAGE}$image",
  var name;
  if (index == 0) {
    name = provider.projectDetailCrewResponse!.projectData!.manager!
        .name; // bottomBarProvider.managerName ?? "";
  } else {
    name =
        provider.projectDetailCrewResponse!.projectData!.crews![index - 1].name;
  }

  return GestureDetector(
    onTap: index == 0
        ? () {}
        : () {
            Navigator.pushNamed(context, RouteConstants.crewProfilePage,
                arguments: provider
                    .projectDetailCrewResponse!.projectData!.crews![index - 1]);
          },
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
      child: Container(
        height: DimensionConstants.d76.h,
        decoration: BoxDecoration(
            color: ColorConstants.colorWhite,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
          child: Row(
            children: <Widget>[
              index == 0
                  ? ImageView(
                      path: provider.projectDetailCrewResponse!.projectData!
                                  .manager!.profileImage ==
                              null
                          ? ImageConstants.emptyImageIcon
                          : "${ApiConstantsCrew.BASE_URL_IMAGE}${provider.projectDetailCrewResponse!.projectData!.manager!.profileImage}",
                      height: DimensionConstants.d50.h,
                      width: DimensionConstants.d50.w,
                      fit: BoxFit.cover,
                      circleCrop: true,
                    )
                  : ImageView(
                      path: provider.projectDetailCrewResponse!.projectData!
                                  .crews![index - 1].profileImage ==
                              null
                          ? ImageConstants.emptyImageIcon
                          : "${ApiConstantsCrew.BASE_URL_IMAGE}${provider.projectDetailCrewResponse!.projectData!.crews![index - 1].profileImage}",
                      height: DimensionConstants.d50.h,
                      width: DimensionConstants.d50.w,
                      fit: BoxFit.cover,
                      circleCrop: true,
                    ),
              SizedBox(
                width: DimensionConstants.d13.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: DimensionConstants.d12.h,
                    ),
                    Text(name).boldText(
                      context,
                      DimensionConstants.d16.sp,
                      TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.deepBlue,
                    ),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    index == 0
                        ? Container(
                            height: DimensionConstants.d21.h,
                            width: DimensionConstants.d120.w,
                            decoration: BoxDecoration(
                              border: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Border.all(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? ColorConstants.colorWhite
                                          : ColorConstants.deepBlue,
                                      width: DimensionConstants.d1.w)
                                  : null,
                              color: ColorConstants.deepBlue,
                              borderRadius: BorderRadius.circular(
                                  DimensionConstants.d8.r),
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
                                  Text("crew_manager".tr()).semiBoldText(
                                      context,
                                      DimensionConstants.d10.sp,
                                      TextAlign.left,
                                      color: ColorConstants.colorWhite),
                                ],
                              ),
                            ),
                          )
                        : Row(
                            children: <Widget>[
                              SizedBox(
                                width: DimensionConstants.d100.w,
                                child: Text(provider
                                            .projectDetailCrewResponse!
                                            .projectData!
                                            .crews![index - 1]
                                            .position ??
                                        "")
                                    .regularText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.left,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.deepBlue,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                              ),
                              archivedOrNot != true
                                  ? SizedBox(
                                      width: DimensionConstants.d75.w,
                                      child: Text(
                                              "\$${provider.projectDetailCrewResponse!.projectData!.projectRate![index - 1].price.toString()}/hr")
                                          .regularText(
                                              context,
                                              DimensionConstants.d14.sp,
                                              TextAlign.left,
                                              color: ColorConstants.deepBlue,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis))
                                  : Text("invite_pending".tr()).regularText(
                                      context,
                                      DimensionConstants.d14.sp,
                                      TextAlign.left,
                                      color: ColorConstants.redColorEB5757),
                            ],
                          )
                  ],
                ),
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

Widget customStepper(ProjectDetailsPageProvider provider,
    CheckInProjectDetailManager checkInProjectDetail) {
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
