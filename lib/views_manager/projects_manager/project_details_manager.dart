import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/model/project_detail_manager_response.dart';
import 'package:beehive/model/project_working_hour_detail.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/project_details_manager_provider.dart';
import 'package:beehive/provider/project_details_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/projects_manager/add_crew_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/add_note_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/crew_profile_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/project_setting_page_manager.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/route_constants.dart';
import '../../helper/dialog_helper.dart';

class ProjectDetailsPageManager extends StatefulWidget {
  bool? createProject;
  bool archiveProject;
  String projectId;

  ProjectDetailsPageManager(
      {Key? key, this.createProject, required this.projectId, required this.archiveProject})
      : super(key: key);

  @override
  State<ProjectDetailsPageManager> createState() =>
      _ProjectDetailsPageManagerState();
}

class _ProjectDetailsPageManagerState extends State<ProjectDetailsPageManager>
    with TickerProviderStateMixin {
  BottomBarManagerProvider? bottomBarProvider;

  @override
  void initState() {
    bottomBarProvider =
        Provider.of<BottomBarManagerProvider>(context, listen: false);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final dashBoardProvider = Provider.of<BottomBarManagerProvider>(context, listen: false);
    return BaseView<ProjectDetailsManagerProvider>(
      onModelReady: (provider) {
        provider.projectId = widget.projectId;
        provider.tabController = TabController(length: 3, vsync: this);
        provider.startDate = DateFunctions.getCurrentDateMonthYear();
        provider.endDate = DateFunctions.getCurrentDateMonthYear();
        provider.setCustomMapPinUser();
        provider.getProjectDetail(context);
      },
      builder: (context, provider, _) {
        return Scaffold(
          key: _scaffoldkey,
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "project_details",
              actionIcon: ImageConstants.settingsIcon,
              actionButtonRequired: true,
              onTapAction: () {
                Navigator.pushNamed(
                    context, RouteConstants.projectSettingsPageManager,
                    arguments: ProjectSettingsPageManager(
                        fromProjectOrCreateProject: false,
                        projectData: provider.projectDetailResponse!
                            .projectData)).then((value) {
                  provider.getProjectDetail(context);
                });
              },
              popFunction: () {
            if(widget.archiveProject == true){
              dashBoardProvider.onItemTapped(1);
              dashBoardProvider.updateNavigationValue(3);
            } else{
              bottomBarProvider?.onItemTapped(0);
              bottomBarProvider!.notifyListeners();
            }

              }),
          body: Stack(
            children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        widget.archiveProject == true ? SizedBox(
                            height: DimensionConstants.d16.h) : Container(),
                        widget.archiveProject == true ? projectByArchived(
                            context, provider, dashBoardProvider) : Container(),
                        widget.archiveProject == true ? SizedBox(
                            height: DimensionConstants.d16.h
                        ) : Container(),
                        if (widget.createProject ?? false)
                          Column(
                            children: [
                              SizedBox(
                                height: DimensionConstants.d16.h,
                              ),
                              projectCreated(context, provider),
                            ],
                          ),
                        SizedBox(
                          height: DimensionConstants.d16.h,
                        ),
                        mapAndHoursDetails(
                            context, widget.createProject!, provider),
                        SizedBox(
                          height: DimensionConstants.d10.h,
                        ),
                        tabBarView(
                            context, provider.tabController!, provider, false),
                        SizedBox(
                          height: DimensionConstants.d24.h,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Text("notes".tr()).semiBoldText(context,
                                    DimensionConstants.d20.sp, TextAlign.left,
                                    color: Theme
                                        .of(context)
                                        .brightness ==
                                        Brightness.dark
                                        ? ColorConstants.colorWhite
                                        : ColorConstants.colorBlack)),
                            widget.archiveProject == true
                                ? Container()
                                : GestureDetector(
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
                                  border: Theme
                                      .of(context)
                                      .brightness ==
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
                                      Text("add_note".tr()).semiBoldText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.left,
                                          color: Theme
                                              .of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? ColorConstants.colorWhite
                                              : ColorConstants.colorWhite),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        if (provider.projectDetailResponse != null &&
                            provider.projectDetailResponse!.projectData!.notes!
                                .isNotEmpty)
                          Column(
                            children: [
                              SizedBox(
                                height: DimensionConstants.d25.h,
                              ),
                              notesList(
                                  context,
                                  provider
                                      .projectDetailResponse!.projectData!
                                      .notes!, provider),
                            ],
                          ),
                        SizedBox(
                          height: DimensionConstants.d25.h,
                        ),
                        Row(
                          children: <Widget>[
                            Text("crew".tr()).semiBoldText(
                                context, DimensionConstants.d20.sp, TextAlign
                                .left,
                                color: ColorConstants.colorBlack),
                            Expanded(child: Container()),
                            widget.archiveProject == true
                                ? Container()
                                : GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteConstants.addCrewPageManager,
                                    arguments: AddCrewPageManager(
                                        crewList: provider
                                            .projectDetailResponse!.projectData!
                                            .crews!,
                                        projectId: provider.projectId)).then((
                                    value) {
                                  provider.getProjectDetail(context);
                                });
                              },
                              child: Container(
                                height: DimensionConstants.d40.h,
                                width: DimensionConstants.d118,
                                decoration: BoxDecoration(
                                  color: ColorConstants.deepBlue,
                                  border: Theme
                                      .of(context)
                                      .brightness ==
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
                                      Text("add_crew".tr()).semiBoldText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.left,
                                          color: Theme
                                              .of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? ColorConstants.colorWhite
                                              : ColorConstants.colorWhite),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        if (provider.projectDetailResponse != null &&
                            provider.projectDetailResponse!.projectData!.crews!
                                .isNotEmpty)
                          crewList(context, true, provider, bottomBarProvider!),
                        SizedBox(
                          height: DimensionConstants.d18.h,
                        ),
                        /*widget.createProject == false
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: DimensionConstants.d3.w),
                            child: CommonWidgets.commonButton(
                                context, "delete_project".tr(),
                                color1: ColorConstants.redColorEB5757,
                                color2: ColorConstants.redColorEB5757,
                                fontSize: DimensionConstants.d16.sp,
                                onBtnTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogHelper.deleteDialogBoxManager(
                                        context,
                                        cancel: () {},
                                        delete: () {},
                                      ));
                            }, shadowRequired: false),
                          )
                        : Container(),*/
                        SizedBox(
                          height: DimensionConstants.d20.h,
                        ),
                        widget.archiveProject == true
                            ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DimensionConstants.d3.w),
                          child: CommonWidgets.commonButton(
                              context, "delete_project".tr(),
                              color1: ColorConstants.redColorEB5757,
                              color2: ColorConstants.redColorEB5757,
                              fontSize: DimensionConstants.d16.sp,
                              onBtnTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DialogHelper.deleteDialogBoxManager(
                                          context,
                                          cancel: () {
                                            Navigator.of(context).pop();
                                          },
                                          delete: () {
                                            Navigator.of(context).pop();
                                            provider.deleteProjectByManager(context, widget.projectId).then((value){
                                              dashBoardProvider.onItemTapped(1);
                                              dashBoardProvider.updateNavigationValue(3);
                                            });
                                          },
                                        ));
                              },
                              shadowRequired: false),
                        )
                            : Container(),
                        SizedBox(
                          height: DimensionConstants.d20.h,
                        ),
                      ],
                    )),
              ),
              if (provider.state == ViewState.busy) CustomCircularBar()
            ],
          ),
        );
      },
    );
  }


  Widget mapAndHoursDetails(BuildContext context, bool createProject,
      ProjectDetailsManagerProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(provider.projectDetailResponse?.projectData?.projectName ?? "")
            .semiBoldText(context, DimensionConstants.d20.sp, TextAlign.left,
            color: ColorConstants.colorBlack),
        SizedBox(
          height: DimensionConstants.d15.h,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  ImageView(
                    path: ImageConstants.locationIcon,
                    color: ColorConstants.primaryColor,
                    height: DimensionConstants.d24.h,
                    width: DimensionConstants.d24.w,
                  ),
                  SizedBox(
                    width: DimensionConstants.d8.w,
                  ),
                  Expanded(
                      child: Text(provider
                          .projectDetailResponse?.projectData?.address ??
                          "")
                          .regularText(
                          context, DimensionConstants.d16.sp, TextAlign.left,
                          color: ColorConstants.darkGray4F4F4F,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=${provider
                    .projectDetailResponse!.projectData!.latitude},${provider
                    .projectDetailResponse!.projectData!.longitude}';
                await launchUrl(Uri.parse(googleUrl));
              },
              child: Container(
                height: DimensionConstants.d42.h,
                width: DimensionConstants.d94.w,
                decoration: BoxDecoration(
                  border: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Border.all(
                      color: Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                      width: DimensionConstants.d1.w)
                      : Border.all(
                      color: Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.grayD2D2D7,
                      width: DimensionConstants.d1.w),
                  borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                ),
                child: Center(
                  child: Text("directions".tr()).semiBoldText(
                      context, DimensionConstants.d14.sp, TextAlign.center,
                      color: Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack),
                ),
              ),
            )
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
                    provider.projectDetailResponse?.projectData?.latitude ??
                        0.0,
                    provider.projectDetailResponse?.projectData?.latitude ??
                        0.0),
                zoom: 11.0,
              ),
              onMapCreated: (controller) {
                provider.googleMapController = controller;
                provider.animateCamera();
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
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? ColorConstants.colorBlack
                : ColorConstants.littleDarkGray,
            border: Theme
                .of(context)
                .brightness == Brightness.dark
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
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
                Expanded(child: Container()),
                Text(DateFunctions.minutesToHourString(
                    provider.projectDetailResponse?.projectData?.totalHours ??
                        0))
                    .semiBoldText(
                    context, DimensionConstants.d14.sp, TextAlign.left,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
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
      ProjectDetailsManagerProvider provider, bool projectCreate) {
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
                    provider.startDate =
                        DateFunctions.getCurrentDateMonthYear();
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
        SizedBox(
          height: DimensionConstants.d16.h,
        ),
        provider.tabController!.index == 0
            ? todayTab(context, provider)
            : weeklyTabBarContainer(context, provider),
      ],
    );
  }

  Widget todayTab(BuildContext context,
      ProjectDetailsManagerProvider provider) {
    return Container(
      height: DimensionConstants.d70.h,
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.littleDarkGray,
        border: Theme
            .of(context)
            .brightness == Brightness.dark
            ? Border.all(
            color: ColorConstants.colorWhite, width: DimensionConstants.d1.w)
            : null,
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.projectDetailResponse?.projectData?.totalHours
                    ?.toStringAsFixed(0) ??
                    "0")
                    .boldText(
                    context, DimensionConstants.d24.sp, TextAlign.start,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d5.h,
                ),
                Text("total_hours".tr()).regularText(
                    context, DimensionConstants.d14.sp, TextAlign.start,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
              ],
            ),
          ),
          Container(
            height: DimensionConstants.d70.h,
            width: DimensionConstants.d1.w,
            color: ColorConstants.lightGray,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.projectDetailResponse?.projectData?.crews!.length
                    .toString() ??
                    '0')
                    .boldText(
                    context, DimensionConstants.d24.sp, TextAlign.start,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d5.h,
                ),
                Text("crew").regularText(
                    context, DimensionConstants.d14.sp, TextAlign.start,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget checkUserDetail(BuildContext context,
      ProjectDetailsManagerProvider provider,
      CheckInProjectDetailManager checkInDetail) {
    return GestureDetector(
      onTap: () {
        //  Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          height: DimensionConstants.d60.h,
          decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.colorWhite,
              borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: DimensionConstants.d45.w,
                  child: Text(checkInDetail.crew?.name ?? "").boldText(
                      context, DimensionConstants.d13.sp, TextAlign.left,
                      color: ColorConstants.colorBlack),
                ),
                SizedBox(
                  width: DimensionConstants.d13.w,
                ),
                Text(DateFunctions.dateTO12Hour(checkInDetail.checkInTime!)
                    .substring(
                    0,
                    DateFunctions
                        .dateTO12Hour(checkInDetail.checkInTime!)
                        .length -
                        1))
                    .regularText(
                    context, DimensionConstants.d13.sp, TextAlign.left,
                    color: ColorConstants.colorBlack),
                SizedBox(width: DimensionConstants.d11.w),
                customStepper(provider, checkInDetail),
                SizedBox(width: DimensionConstants.d10.w),
                Text(DateFunctions.dateTO12Hour(checkInDetail.checkOutTime!)
                    .substring(
                    0,
                    DateFunctions
                        .dateTO12Hour(
                        checkInDetail.checkOutTime!)
                        .length -
                        1))
                    .regularText(
                    context, DimensionConstants.d13.sp, TextAlign.left,
                    color: ColorConstants.colorBlack),
                SizedBox(
                  width: DimensionConstants.d12.w,
                ),
                Text("${DateFunctions.calculateTotalHourTime(
                    checkInDetail.checkInTime!,
                    checkInDetail.checkOutTime!)} h")
                    .boldText(
                    context, DimensionConstants.d13.sp, TextAlign.left,
                    color: ColorConstants.colorBlack),
                SizedBox(
                  width: DimensionConstants.d13.w,
                ),
                ImageView(
                  path: ImageConstants.arrowIcon,
                  height: DimensionConstants.d10.h,
                  width: DimensionConstants.d8.w,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
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

  Widget notesList(BuildContext context, List<Note> notes,
      ProjectDetailsManagerProvider provider) {
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
              Navigator.pushNamed(context, RouteConstants.showNotePageManager,
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
                              context, DimensionConstants.d14.sp,
                              TextAlign.left,
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      ImageView(
                        path: ImageConstants.arrowIcon,
                        height: DimensionConstants.d10.h,
                        width: DimensionConstants.d8.w,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
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
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
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

  Widget crewList(BuildContext context,
      bool archivedOrNot,
      ProjectDetailsManagerProvider provider,
      BottomBarManagerProvider bottomBarProvider) {
    return ListView.builder(
      itemCount: provider.projectDetailResponse!.projectData!.crews!.length + 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return crewWidget(context, false, bottomBarProvider, provider, index);
      },
    ) /*Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: DimensionConstants.d24.h,
      ),
      managerDetails(context, true, "deepak", archivedOrNot, ""),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, RouteConstants.crewProfilePage);
          },
          child: managerDetails(context, false, "deepak", archivedOrNot, "")),
    ],
  )*/
    ;
  }

  Widget crewWidget(BuildContext context,
      bool archivedOrNot,
      BottomBarManagerProvider bottomBarProvider,
      ProjectDetailsManagerProvider provider,
      int index) {
    var hourlyRate = "";
    // : "${ApiConstantsCrew.BASE_URL_IMAGE}$image",
    var name;
    if (index == 0) {
      name = bottomBarProvider.managerName ?? "";
    } else {
      name =
          provider.projectDetailResponse!.projectData!.crews![index - 1].name;
      hourlyRate = double.parse(
          provider.projectDetailResponse!.projectData!.crews![index - 1]
              .projectRate!).toStringAsFixed(2);
    }

    return GestureDetector(
      onTap: (index == 0 || widget.archiveProject == true) ? () {} : () {
        Navigator.pushNamed(context, RouteConstants.crewPageProfileManager,
            arguments: CrewProfilePageManager(
                projectName: provider.projectDetailResponse!.projectData!
                    .projectName ?? "",
                crewData: provider.projectDetailResponse!.projectData!
                    .crews![index - 1],
                projectId: provider.projectDetailResponse!.projectData!
                    .projectDataId ?? "")).then((value) {
          if (value == true) {
            Navigator.of(context).pop();
          }
        });
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
                index == 0 ? ImageView(
                  path: provider.projectDetailResponse!.manager!.profileImage ==
                      "" ? ImageConstants.emptyImageIcon :
                  "${ApiConstantsCrew.BASE_URL_IMAGE}${provider
                      .projectDetailResponse!.manager!.profileImage}",
                  height: DimensionConstants.d50.h,
                  width: DimensionConstants.d50.w,
                  fit: BoxFit.cover,
                  circleCrop: true,
                ) : ImageView(
                  path: provider.projectDetailResponse!.projectData!
                      .crews![index - 1].profileImage == null ? ImageConstants
                      .emptyImageIcon :
                  "${ApiConstantsCrew.BASE_URL_IMAGE}${provider
                      .projectDetailResponse!.projectData!.crews![index - 1]
                      .profileImage}"
                  ,
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
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
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
                          border:
                          Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? Border.all(
                              color: Theme
                                  .of(context)
                                  .brightness ==
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
                            color: Theme
                                .of(context)
                                .brightness ==
                                Brightness.dark
                                ? ColorConstants.colorWhite
                                : ColorConstants.deepBlue,
                          ),
                          archivedOrNot != true
                              ? Text("  \$${hourlyRate}/h").regularText(
                            context,
                            DimensionConstants.d14.sp,
                            TextAlign.left,
                            color: ColorConstants.deepBlue,
                          )
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
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
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

  Widget weeklyTabBarContainer(BuildContext context,
      ProjectDetailsManagerProvider provider) {
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
                  onTap: () {
                    provider.previousWeekDays(
                        provider.tabController!.index == 1 ? 7 : 14);
                    provider.getProjectDetail(
                      context,
                    );
                  },
                  child: backNextBtn(ImageConstants.backIconIos)),
              SizedBox(
                width: DimensionConstants.d16.w,
              ),
              Text("${DateFunctions.capitalize(
                  provider.weekFirstDate ?? "")} - ${DateFunctions.capitalize(
                  provider.weekEndDate ?? "")}")
                  .boldText(
                  context, DimensionConstants.d16.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
              SizedBox(
                width: DimensionConstants.d16.w,
              ),
              provider.endDate !=
                  DateFormat("yyyy-MM-dd").format(DateTime.now())
                  ? GestureDetector(
                onTap: () {
                  provider.nextWeekDays(
                      provider.tabController!.index == 1 ? 7 : 14);
                  provider.getProjectDetail(
                    context,
                  );
                },
                child: backNextBtn(ImageConstants.nextIconIos),
              )
                  : Visibility(
                  visible: false,
                  child: backNextBtn(ImageConstants.nextIconIos)),
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
                  decoration: BoxDecoration(
                    color: (Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorBlack
                        : ColorConstants.colorWhite),
                    border: Border.all(
                      color: ColorConstants.colorLightGreyF2,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(DimensionConstants.d8.r),
                      topRight: Radius.circular(DimensionConstants.d8.r),
                    ),
                  ),
                  height: DimensionConstants.d70.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: DimensionConstants.d10.w,
                      ),
                      projectsHoursRow(context, ImageConstants.twoUserIcon,
                          "${provider.projectDetailResponse?.projectData?.crews!
                              .length ?? 0} ${"crew".tr()}"),
                      SizedBox(
                        width: DimensionConstants.d15.w,
                      ),
                      Container(
                        height: DimensionConstants.d70.h,
                        width: DimensionConstants.d1.w,
                        color: ColorConstants.colorLightGrey,
                      ),
                      projectsHoursRow(context, ImageConstants.clockIcon,
                          "${DateFunctions.minutesToHourString(
                              provider.projectDetailResponse?.projectData
                                  ?.totalHours ?? 0)} ${"hours".tr()}")
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
                          weeklyTabBarDateContainer(
                              context, provider.weeklyData[index].date ?? ""),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider
                                .weeklyData[index].checkInDataList!.length,
                            itemBuilder: (context, innerIndex) {
                              return checkUserDetail(
                                  context,
                                  provider,
                                  provider.weeklyData[index]
                                      .checkInDataList![innerIndex]!);
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

  Widget projectByArchived(BuildContext context, ProjectDetailsManagerProvider provider, BottomBarManagerProvider dashBoardProvider) {
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
            Text("this_project_is_archived".tr())
                .regularText(
                context, DimensionConstants.d14.sp, TextAlign.left),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        DialogHelper.archiveUnArchiveDialogBox(
                          context,
                          cancel: () {
                            Navigator.of(context).pop();
                          },
                          archive: () {
                            Navigator.of(context).pop();
                            provider.unArchiveProjectByManager(context, widget.projectId).then((value) {
                                dashBoardProvider.onItemTapped(1);
                                dashBoardProvider.updateNavigationValue(3);
                            });
                          }, unarchive: true
                        ));
              },
              child:  Text("unarchive".tr()).boldText(
                  context, DimensionConstants.d16.sp, TextAlign.left,
                  color: ColorConstants.redColorEB5757),
            )
          ],
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

  Widget projectCreated(BuildContext context,
      ProjectDetailsManagerProvider provider) {
    return Container(
      height: DimensionConstants.d42.h,
      width: DimensionConstants.d343.w,
      decoration: BoxDecoration(
        color: ColorConstants.colorGreen.withOpacity(0.2),
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d14.w),
        child: Row(
          children: <Widget>[
            ImageView(
              path: ImageConstants.greenIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
            ),
            SizedBox(
              width: DimensionConstants.d9.w,
            ),
            Text("nice_work_your_project_has_been_created".tr()).regularText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: ColorConstants.green219653),
          ],
        ),
      ),
    );
  }

  Widget projectCreatedBox(BuildContext context,
      ProjectDetailsManagerProvider provider) {
    return Material(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
      child: Container(
        height: DimensionConstants.d229.h,
        width: DimensionConstants.d343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.w),
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: (Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? ColorConstants.colorBlack
                    : ColorConstants.colorWhite),
                borderRadius:
                BorderRadius.all(Radius.circular(DimensionConstants.d8.r)),
              ),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  projectsHoursRowProject(
                      context, ImageConstants.mapIcon, "4 ${"crew".tr()}"),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRowProject(
                      context, ImageConstants.clockIcon, "0:00 ${"hrs".tr()}")
                ],
              ),
            ),
            /*SizedBox(
            height: DimensionConstants.d30.h,
          ),
          Text("you_don_have_a_crew_yet_start_inviting_your_crew_memebers".tr())
              .regularText(context, DimensionConstants.d14.sp, TextAlign.center,
                  color: ColorConstants.deepBlue),
          SizedBox(
            height: DimensionConstants.d24.h,
          ),
          addBreakButton(context),*/
          ],
        ),
      ),
    );
  }

  Widget projectsHoursRowProject(BuildContext context, String iconPath,
      String txt) {
    return Row(
      children: [
        ImageView(path: iconPath),
        SizedBox(width: DimensionConstants.d9.w),
        Text(txt).boldText(context, DimensionConstants.d18.sp, TextAlign.center)
      ],
    );
  }

  Widget addBreakButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteConstants.addCrewPageManager);
      },
      child: Container(
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d130,
        decoration: BoxDecoration(
          color: ColorConstants.deepBlue,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d12.w),
          child: Row(
            children: <Widget>[
              ImageView(
                path: ImageConstants.addNotesIcon,
                height: DimensionConstants.d16.h,
                width: DimensionConstants.d16.w,
              ),
              SizedBox(
                width: DimensionConstants.d7.w,
              ),
              Text("add_crew".tr()).semiBoldText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: ColorConstants.colorWhite),
            ],
          ),
        ),
      ),
    );
  }

  Widget customStepper(ProjectDetailsManagerProvider provider,
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
}