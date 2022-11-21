import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/model/all_checkout_projects_crew.dart';
import 'package:beehive/provider/project_crew_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/projects/project_details_page.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../provider/bottom_bar_provider.dart';

class ProjectsCrew extends StatefulWidget {
  const ProjectsCrew({Key? key}) : super(key: key);

  @override
  State<ProjectsCrew> createState() => _ProjectsCrewState();
}

class _ProjectsCrewState extends State<ProjectsCrew>
    with TickerProviderStateMixin {
  bool openScheduleScreen = false;

  void _observer() {
    openScheduleScreen = Provider.of<BottomBarProvider>(context, listen: true)
        .showScheduleScreen;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _observer();
    TabController tabController = TabController(length: 2, vsync: this);
    if (openScheduleScreen) {
      tabController.index = 1;
      Provider.of<BottomBarProvider>(context, listen: false)
          .showScheduleScreen = false;
    }

    return BaseView<ProjectsCrewProvider>(
      onModelReady: (provider) {
        provider.getAllCheckoutProjectsCrew(context);
        tabController.addListener(() {
          if (tabController.indexIsChanging) {
            if (tabController.index == 1) {
              provider.getProjectSchedulesManager(context);
              tabController.index = 1;
            }
          }
        });
        provider.weekTabBar();
      },
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.colorWhite,
          body: provider.state == ViewState.idle
              ? Column(
                  children: <Widget>[
                    tabBarView(context, tabController, provider),
                    Expanded(
                      child: SingleChildScrollView(
                          child: tabController.index == 0
                              ? allProjects(context, provider)
                              : schedule(context, provider)),
                    ),
                    tabController.index == 1
                        ? SizedBox(
                            height: DimensionConstants.d150.h,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: provider.projectNames.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: DimensionConstants.d30.w,
                                        bottom: DimensionConstants.d10.h),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: DimensionConstants.d10.h,
                                          width: DimensionConstants.d10.w,
                                          decoration: BoxDecoration(
                                            color: provider.projectColors[index]
                                                    .isEmpty
                                                ? Colors.black
                                                : Color(int.parse(
                                                    "0x${provider.projectColors[index]}")),
                                            borderRadius: BorderRadius.circular(
                                                DimensionConstants.d5.r),
                                          ),
                                        ),
                                        SizedBox(
                                          width: DimensionConstants.d5.w,
                                        ),
                                        SizedBox(
                                          width: DimensionConstants.d140.w,
                                          child:
                                              Text(provider.projectNames[index])
                                                  .regularText(
                                                      context,
                                                      DimensionConstants.d14.sp,
                                                      TextAlign.left,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? ColorConstants
                                                              .colorWhite
                                                          : ColorConstants
                                                              .colorBlack,
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Container(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.primaryGradient2Color,
                  ),
                ),
        );
      },
    );
  }
}

Widget tabBarView(BuildContext context, TabController controller,
    ProjectsCrewProvider provider) {
  return Column(
    children: [
      Container(
        height: DimensionConstants.d52.h,
        width: DimensionConstants.d375.w,
        color: ColorConstants.deepBlue,
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
              provider.customNotify();
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
                          topRight: Radius.circular(DimensionConstants.d16.r))),
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
                        Text("all_projects".tr()).boldText(
                            context, DimensionConstants.d16.sp, TextAlign.left,
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
                          topRight: Radius.circular(DimensionConstants.d16.r))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstants.d10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ImageView(
                            path: ImageConstants.calendarIcon,
                            height: DimensionConstants.d24.h,
                            width: DimensionConstants.d24.w,
                            color: ColorConstants.deepBlue),
                        SizedBox(
                          width: DimensionConstants.d7.w,
                        ),
                        Text("schedule".tr()).boldText(
                            context, DimensionConstants.d16.sp, TextAlign.left,
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
    ],
  );
}

Widget allProjects(BuildContext context, ProjectsCrewProvider provider) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: DimensionConstants.d20.h,
      ),
      Container(
        height: DimensionConstants.d72.h,
        width: DimensionConstants.d343.w,
        decoration: BoxDecoration(
          color: ColorConstants.littleDarkGray,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d40.w),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: DimensionConstants.d13.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.allCheckoutProjectCrewResponse?.activeProject
                                .toString() ??
                            '')
                        .semiBoldText(
                            context, DimensionConstants.d20.sp, TextAlign.left,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorBlack
                                    : ColorConstants.colorBlack),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    Text("project_projects".tr()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                  ],
                ),
              ),
              SizedBox(
                width: DimensionConstants.d40.w,
              ),
              Container(
                height: DimensionConstants.d72.h,
                width: DimensionConstants.d1.w,
                color: ColorConstants.lightGray,
              ),
              SizedBox(
                width: DimensionConstants.d55.w,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: DimensionConstants.d13.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.totalHours ?? "0").semiBoldText(
                        context, DimensionConstants.d20.sp, TextAlign.left,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    Text("total_hours".tr()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: DimensionConstants.d16.h,
      ),
      projectList(context, provider),
    ],
  );
}

Widget projectList(BuildContext context, ProjectsCrewProvider provider) {
  return Container(
    height: DimensionConstants.d410.h,
    width: DimensionConstants.d343.w,
    color: Theme.of(context).brightness == Brightness.dark
        ? ColorConstants.colorBlack
        : ColorConstants.colorWhite,
    child: ListView.builder(
        //   physics: NeverScrollableScrollPhysics(),
        itemCount: provider.allCheckoutProjectCrewResponse?.projectData?.length,
        itemBuilder: (BuildContext context, int index) {
          return projectDetailWidget(
              context,
              provider.allCheckoutProjectCrewResponse!.projectData![index],
              provider);
        }),
  );
}

Widget projectDetailWidget(BuildContext context, ProjectDetail projectDetail,
    ProjectsCrewProvider provider) {
  var value = DateFunctions.minutesToHourString(projectDetail.totalHours!);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: DimensionConstants.d5.h),
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteConstants.projectDetailsPage,
            arguments: ProjectDetailsPage(
              archivedOrProject: false,
              projectId: projectDetail.id,
              totalHoursToDate: value,
            ));
      },
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: Container(
          height: DimensionConstants.d126.h,
          // width: DimensionConstants.d343.w,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.colorWhite,
              border: Theme.of(context).brightness == Brightness.dark
                  ? Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : Colors.transparent,
                      width: DimensionConstants.d1.w)
                  : null,
              borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: DimensionConstants.d15.w,
                    right: DimensionConstants.d26.w,
                    top: DimensionConstants.d8.h,
                    bottom: DimensionConstants.d8.h),
                child: Row(
                  children: <Widget>[
                    Container(
                        height: DimensionConstants.d32.h,
                        width: DimensionConstants.d32.w,
                        decoration: BoxDecoration(
                            color: projectDetail.color == null
                                ? Colors.black
                                : Color(int.parse("0x${projectDetail.color}")),
                            borderRadius: BorderRadius.circular(
                                DimensionConstants.d16.r)),
                        child: Center(
                          child: Text(Validations.getInitials(
                                  string: projectDetail.projectName ?? "",
                                  limitTo: 2))
                              .semiBoldText(context, DimensionConstants.d14.sp,
                                  TextAlign.center,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorConstants.colorWhite
                                      : ColorConstants.colorWhite),
                        )),
                    SizedBox(
                      width: DimensionConstants.d16.w,
                    ),
                    Text(projectDetail.projectName ?? "").semiBoldText(
                        context, DimensionConstants.d14.sp, TextAlign.center,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack),
                    Expanded(child: Container()),
                    ImageView(
                      path: ImageConstants.arrowIcon,
                      width: DimensionConstants.d5.w,
                      height: DimensionConstants.d10.h,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorBlack,
                    ),
                  ],
                ),
              ),
              Container(
                height: DimensionConstants.d1.h,
                width: DimensionConstants.d343.w,
                color: ColorConstants.lightGray,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: DimensionConstants.d15.w,
                    right: DimensionConstants.d26.w,
                    top: DimensionConstants.d20.h,
                    bottom: DimensionConstants.d8.h),
                child: Row(
                  children: <Widget>[
                    ImageView(
                      path: ImageConstants.clockIconAllProjects,
                      height: DimensionConstants.d34.h,
                      width: DimensionConstants.d34.w,
                    ),
                    SizedBox(
                      width: DimensionConstants.d16.w,
                    ),
                    Text("total_hours".tr()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorWhite
                            : ColorConstants.colorBlack),
                    Expanded(child: Container()),
                    Text(provider.getTotalHoursPerProject(projectDetail) ?? '')
                        .semiBoldText(context, DimensionConstants.d20.sp,
                            TextAlign.center,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.colorBlack),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget schedule(BuildContext context, ProjectsCrewProvider provider) {
  return provider.state == ViewState.busy
      ? const CustomCircularBar()
      : Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
          child: Column(
            children: [
              SizedBox(
                height: DimensionConstants.d17.h,
              ),
              Container(
                height: DimensionConstants.d479.h,
                decoration: BoxDecoration(
                    color: ColorConstants.deepBlue,
                    border: Theme.of(context).brightness == Brightness.dark
                        ? Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : Colors.transparent)
                        : null,
                    borderRadius: BorderRadius.all(
                        Radius.circular(DimensionConstants.d8.r))),
                child: Column(
                  children: [
                    SizedBox(height: DimensionConstants.d17.h),
                    Padding(
                      padding: EdgeInsets.fromLTRB(DimensionConstants.d16.w,
                          0.0, DimensionConstants.d16.w, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          backNextBtn(ImageConstants.backIconIos, onTap: () {
                            provider.previousWeekDays(6);
                          }),
                          Text("${DateFunctions.capitalize(provider.weekFirstDate ?? "")} - ${DateFunctions.capitalize(provider.weekEndDate ?? "")}")
                              .boldText(context, DimensionConstants.d16.sp,
                                  TextAlign.center,
                                  color: ColorConstants.colorWhite),
                          provider.endDate !=
                                  DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now())
                              ? backNextBtn(ImageConstants.nextIconIos,
                                  onTap: () {
                                  provider.nextWeekDays(7);
                                })
                              : Visibility(
                                  visible: false,
                                  child:
                                      backNextBtn(ImageConstants.nextIconIos))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DimensionConstants.d20.h,
                    ),
                    Container(
                      height: Theme.of(context).brightness == Brightness.dark
                          ? DimensionConstants.d413.h
                          : DimensionConstants.d416.h,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.colorWhite,
                          borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(DimensionConstants.d8.r),
                              bottomRight:
                                  Radius.circular(DimensionConstants.d8.r))),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height: DimensionConstants.d37.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.dates.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: provider.dates[index] <= 9
                                          ? EdgeInsets.only(
                                              left: DimensionConstants.d25.w,
                                              right: DimensionConstants.d14.w,
                                              top: DimensionConstants.d9.h)
                                          : EdgeInsets.only(
                                              left: DimensionConstants.d19.w,
                                              right: DimensionConstants.d12.w,
                                              top: DimensionConstants.d9.h),
                                      child: Text("${provider.dates[index]}")
                                          .semiBoldText(
                                              context,
                                              DimensionConstants.d14.sp,
                                              TextAlign.center,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? ColorConstants.colorWhite
                                                  : ColorConstants.colorBlack),
                                    );
                                  })),
                          Container(
                              height: DimensionConstants.d337.h,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorBlack
                                  : ColorConstants.grayF1F1F1,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.days.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: DimensionConstants.d19.w,
                                              right: DimensionConstants.d14.w,
                                              top: DimensionConstants.d9.h,
                                              bottom: DimensionConstants.d9.h),
                                          child: Text(provider.days[index])
                                              .semiBoldText(
                                                  context,
                                                  DimensionConstants.d14.sp,
                                                  TextAlign.center,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? ColorConstants
                                                          .colorWhite
                                                      : ColorConstants
                                                          .colorBlack),
                                        ),
                                        Expanded(
                                          child: Container(
                                              width: DimensionConstants.d45.w,
                                              // color: Theme.of(context).brightness == Brightness.dark
                                              //     ? ColorConstants.colorBlack
                                              //     : ColorConstants.colorWhite,
                                              child: checkByWeekSubstring(
                                                  context, provider, index)),
                                        ),
                                      ],
                                    );
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}

Widget checkByWeekSubstring(
    BuildContext context, ProjectsCrewProvider provider, int i) {
  for (int x = 0; x < provider.projectNameList.length; x++) {
    if (provider.projectNameList[x].weekId == provider.daysUpperCase[i]) {
      return projectNameSubStringContainer(context, provider, x);
    }
  }
  return Container();
}

Widget projectNameSubStringContainer(
    BuildContext context, ProjectsCrewProvider provider, int weekDaysIndex) {
  // var value=DateFunctions.minutesToHourString(
  //     projectDetail.totalHours!);
  return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: provider.projectNameList[weekDaysIndex].projectName.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.projectDetailsPage,
                    arguments: ProjectDetailsPage(
                        archivedOrProject: false,
                        projectId: provider.projectNameList[weekDaysIndex]
                            .projectName[index].sId))
                .then((value) {
              if (value == true) {
                provider.getProjectSchedulesManager(context);
              }
            });
          },
          child: Padding(
              padding: EdgeInsets.only(
                  left: DimensionConstants.d10.w,
                  right: DimensionConstants.d2.w,
                  top: DimensionConstants.d9.h),
              child: Container(
                  height: DimensionConstants.d35.h,
                  width: DimensionConstants.d35.w,
                  decoration: BoxDecoration(
                      color: provider.projectNameList[weekDaysIndex]
                                  .projectName[index].color ==
                              null
                          ? Colors.black
                          : Color(int.parse(
                              "0x${provider.projectNameList[weekDaysIndex].projectName[index].color}")),
                      borderRadius:
                          BorderRadius.circular(DimensionConstants.d20.r)),
                  child: Center(
                    child: Text(provider.projectNameList[weekDaysIndex]
                            .projectName[index].projectName!
                            .substring(0, 2)
                            .toUpperCase())
                        .semiBoldText(context, DimensionConstants.d14.sp,
                            TextAlign.center,
                            color: ColorConstants.colorWhite),
                  ))),
        );
      });
}
