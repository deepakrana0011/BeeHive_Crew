import 'dart:math';

import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/projects_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/projects_manager/archived_project_details_manager.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../widget/bottom_sheet_project_details.dart';

class ProjectsPageManager extends StatefulWidget {
  static bool? isProjectCreated = false;
  static String? projectId = "";

  const ProjectsPageManager({Key? key}) : super(key: key);

  @override
  State<ProjectsPageManager> createState() => _ProjectsPageManagerState();
}

class _ProjectsPageManagerState extends State<ProjectsPageManager>
    with TickerProviderStateMixin {
  BottomBarManagerProvider? bottomBarProvider;

  @override
  void initState() {
    bottomBarProvider =
        Provider.of<BottomBarManagerProvider>(context, listen: false);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return BaseView<ProjectsManagerProvider>(
      onModelReady: (provider) {
        provider.getAllManagerProject(context);
        tabController.addListener(() {
          if (tabController.indexIsChanging) {
            if (tabController.index == 1) {
              provider.getProjectSchedulesManager(context);
              tabController.index = 1;
            }
          }
        });
        provider.weekTabBar();
        // provider.nextWeekDays(7);
        // provider.previousWeekDays(7);
      },
      builder: (context, provider, _) {
        return /*provider.allProjectsManagerResponse == null?  Center(child: Text("no_data_found".tr()).boldText(
            context, DimensionConstants.d16.sp, TextAlign.left,
            color: ColorConstants.colorBlack),):*/ Scaffold(
          key: _scaffoldkey,
          backgroundColor: Theme
              .of(context)
              .brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.colorWhite,
          body: provider.state == ViewState.idle
              ? Column(
            children: <Widget>[
              Expanded(
                child: provider.allProjectsManagerResponse!.projectData!
                    .isNotEmpty
                    ? tabBarView(
                    _scaffoldkey.currentContext!, tabController, provider,
                    bottomBarProvider)
                    : Center(
                    child: Text("No Project Found").boldText(context,
                        DimensionConstants.d16.sp, TextAlign.left,
                        color: ColorConstants.deepBlue)),
              ),
              tabController.index == 0
                  ? Padding(
                padding: EdgeInsets.only(
                    left: DimensionConstants.d18.w,
                    right: DimensionConstants.d18.w,
                    top: DimensionConstants.d15.h,
                    bottom: DimensionConstants.d10.h),
                child: Column(
                  children: [
                    CommonWidgets.commonButton(
                        context, "create_a_new_project".tr(),
                        color1:
                        ColorConstants.primaryGradient1Color,
                        color2:
                        ColorConstants.primaryGradient2Color,
                        fontSize: DimensionConstants.d16.sp,
                        shadowRequired: true,
                        onBtnTap: () {
                          Navigator.pushNamed(context, RouteConstants.createProjectManager).then((value) {
                            if (ProjectsPageManager.isProjectCreated!) {
                              bottomBarProvider?.updateNavigationValue(
                                  5,
                                  projectId:
                                  ProjectsPageManager.projectId!,
                                  createProject: true);
                              bottomBarProvider?.pageView(1);
                            } else {
                              ProjectsPageManager.isProjectCreated =
                              false;
                            }
                          });

                        }),
                  ],
                ),
              )
                  : Container(),
              tabController.index == 1
                  ? SizedBox(
                height: DimensionConstants.d150.h,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                color: provider.projectColors[index],
                                borderRadius:
                                BorderRadius.circular(
                                    DimensionConstants.d5.r),
                              ),
                            ),
                            SizedBox(
                              width: DimensionConstants.d5.w,
                            ),
                            SizedBox(
                              width: DimensionConstants.d140.w,
                              child: Text(provider.projectNames[index])
                                  .regularText(
                                  context,
                                  DimensionConstants.d14.sp,
                                  TextAlign.left,
                                  color: Theme
                                      .of(context)
                                      .brightness ==
                                      Brightness.dark
                                      ? ColorConstants
                                      .colorWhite
                                      : ColorConstants
                                      .colorBlack,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
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
              )),
        );
      },
    );
  }


  Widget tabBarView(BuildContext context,
      TabController controller,
      ProjectsManagerProvider provider,
      BottomBarManagerProvider? bottomBarProvider) {
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
                              topLeft: Radius.circular(DimensionConstants.d16
                                  .r),
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
                            Text("all_projects".tr()).boldText(context,
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
                              topLeft: Radius.circular(DimensionConstants.d16
                                  .r),
                              topRight:
                              Radius.circular(DimensionConstants.d16.r))),
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
                            Text("schedule".tr()).boldText(context,
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
        Expanded(
          child: SingleChildScrollView(
            child: controller.index == 0
                ? allProjects(provider, context, bottomBarProvider)
                : schedule(context, provider),
          ),
        )
      ],
    );
  }

  Widget allProjects(ProjectsManagerProvider provider, BuildContext context,
      BottomBarManagerProvider? bottomBarProvider) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: DimensionConstants.d20.h,
        ),
        Container(
          width: DimensionConstants.d343.w,
          decoration: BoxDecoration(
            color: ColorConstants.littleDarkGray,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: DimensionConstants.d35.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DimensionConstants.d13.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.allProjectsManagerResponse?.activeProject
                        .toString() ??
                        "0")
                        .semiBoldText(
                        context, DimensionConstants.d20.sp, TextAlign.left,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    Text("projects".tr()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                  ],
                ),
              ),
              SizedBox(
                width: DimensionConstants.d35.w,
              ),
              Container(
                height: DimensionConstants.d72.h,
                width: DimensionConstants.d1.w,
                color: ColorConstants.lightGray,
              ),
              SizedBox(
                width: DimensionConstants.d42.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DimensionConstants.d13.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.allProjectsManagerResponse?.crewmembers
                        .toString() ??
                        "0")
                        .semiBoldText(
                        context, DimensionConstants.d20.sp, TextAlign.left,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    Text("crew".tr()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                  ],
                ),
              ),
              SizedBox(
                width: DimensionConstants.d42.w,
              ),
              Container(
                height: DimensionConstants.d72.h,
                width: DimensionConstants.d1.w,
                color: ColorConstants.lightGray,
              ),
              SizedBox(
                width: DimensionConstants.d20.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DimensionConstants.d13.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.totalHours ?? "0").semiBoldText(
                        context, DimensionConstants.d20.sp, TextAlign.left,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                    SizedBox(
                      height: DimensionConstants.d5.h,
                    ),
                    Text("total_hours".tr()).regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorBlack),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: DimensionConstants.d16.h,
        ),
        projectDetails(context, provider, bottomBarProvider),
      ],
    );
  }

  Widget projectDetails(BuildContext context, ProjectsManagerProvider provider,
      BottomBarManagerProvider? bottomBarProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: DimensionConstants.d343.w,
        color: Theme
            .of(context)
            .brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.colorWhite,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.allProjectsManagerResponse?.projectData?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DimensionConstants.d5.h),
                child: GestureDetector(
                  onTap: () {
                    bottomBarProvider?.pageView(1);
                    bottomBarProvider?.updateNavigationValue(5,
                        projectId: provider
                            .allProjectsManagerResponse?.projectData![index]
                            .id);
                  },
                  child: Material(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(DimensionConstants.d8.r)),
                    child: Container(
                      height: DimensionConstants.d126.h,
                      // width: DimensionConstants.d343.w,
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.colorWhite,
                          border: Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? Border.all(
                              color: Theme
                                  .of(context)
                                  .brightness ==
                                  Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : Colors.transparent,
                              width: DimensionConstants.d1.w)
                              : null,
                          borderRadius:
                          BorderRadius.circular(DimensionConstants.d8.r)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: DimensionConstants.d15.w,
                                right: DimensionConstants.d26.w,
                                top: DimensionConstants.d16.h,
                                bottom: DimensionConstants.d15.h),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: DimensionConstants.d16.w,
                                ),
                                Text(provider.allProjectsManagerResponse
                                    ?.projectData![index].projectName ??
                                    "")
                                    .semiBoldText(
                                    context,
                                    DimensionConstants.d14.sp,
                                    TextAlign.center,
                                    color: Theme
                                        .of(context)
                                        .brightness ==
                                        Brightness.dark
                                        ? ColorConstants.colorWhite
                                        : ColorConstants.colorBlack),
                                Expanded(child: Container()),
                                ImageView(
                                  path: ImageConstants.arrowIcon,
                                  width: DimensionConstants.d5.w,
                                  height: DimensionConstants.d10.h,
                                  color: Theme
                                      .of(context)
                                      .brightness ==
                                      Brightness.dark
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
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: DimensionConstants.d40.w),
                                  child: Column(
                                    children: <Widget>[
                                      Text(provider.getTotalHoursPerProject(provider.allProjectsManagerResponse?.projectData![index]))
                                          .semiBoldText(
                                          context,
                                          DimensionConstants.d20.sp,
                                          TextAlign.center,
                                          color: Theme
                                              .of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? ColorConstants.colorWhite
                                              : ColorConstants.colorBlack),
                                      Text("total_hours".tr()).regularText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.center,
                                          color: Theme
                                              .of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? ColorConstants.colorWhite
                                              : ColorConstants.colorBlack),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: DimensionConstants.d120.w,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(provider.allProjectsManagerResponse
                                        ?.projectData![index].crew
                                        ?.toString() ??
                                        "0")
                                        .semiBoldText(
                                        context,
                                        DimensionConstants.d20.sp,
                                        TextAlign.center,
                                        color: Theme
                                            .of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                                    Text("crew".tr()).regularText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.center,
                                        color: Theme
                                            .of(context)
                                            .brightness ==
                                            Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget schedule(BuildContext context, ProjectsManagerProvider provider) {
    return provider.state == ViewState.busy ?
    const CustomCircularBar()
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
                border: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Border.all(
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : Colors.transparent)
                    : null,
                borderRadius:
                BorderRadius.all(Radius.circular(DimensionConstants.d8.r))),
            child: Column(
              children: [
                SizedBox(height: DimensionConstants.d17.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      DimensionConstants.d16.w,
                      0.0,
                      DimensionConstants.d16.w,
                      0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backNextBtn(ImageConstants.backIconIos, onTap: () {
                        provider.previousWeekDays(6);
                      }),
                      Text("${DateFunctions.capitalize(
                          provider.weekFirstDate ?? "")} - ${DateFunctions
                          .capitalize(provider.weekEndDate ?? "")}")
                          .boldText(context, DimensionConstants.d16.sp,
                          TextAlign.center,
                          color: ColorConstants.colorWhite),
                      provider.endDate !=
                          DateFormat("yyyy-MM-dd").format(DateTime.now())
                          ? backNextBtn(ImageConstants.nextIconIos, onTap: () {
                        provider.nextWeekDays(7);
                      })
                          : Visibility(
                          visible: false,
                          child: backNextBtn(ImageConstants.nextIconIos))
                    ],
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d20.h,
                ),
                Container(
                  height: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? DimensionConstants.d413.h
                      : DimensionConstants.d416.h,
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? ColorConstants.colorBlack
                          : ColorConstants.colorWhite,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(DimensionConstants.d8.r),
                          bottomRight: Radius.circular(
                              DimensionConstants.d8.r))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: DimensionConstants.d37.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.dates.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: provider.dates[index] <= 9 ?
                                  EdgeInsets.only(
                                      left: DimensionConstants.d25.w,
                                      right: DimensionConstants.d14.w,
                                      top: DimensionConstants.d9.h) : EdgeInsets
                                      .only(
                                      left: DimensionConstants.d19.w,
                                      right: DimensionConstants.d12.w,
                                      top: DimensionConstants.d9.h),
                                  child: Text("${provider.dates[index]}")
                                      .semiBoldText(
                                      context,
                                      DimensionConstants.d14.sp,
                                      TextAlign.center,
                                      color: Theme
                                          .of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? ColorConstants.colorWhite
                                          : ColorConstants.colorBlack),
                                );
                              })),
                      Container(
                          height: DimensionConstants.d337.h,
                          color: Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.grayF1F1F1,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.days.length,
                              itemBuilder: (BuildContext context, int index) {
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
                                          color: Theme
                                              .of(context)
                                              .brightness ==
                                              Brightness.dark
                                              ? ColorConstants.colorWhite
                                              : ColorConstants.colorBlack),
                                    ),
                                    Expanded(
                                      child: Container(
                                          width: DimensionConstants.d45.w,
                                          // color: Theme.of(context).brightness == Brightness.dark
                                          //     ? ColorConstants.colorBlack
                                          //     : ColorConstants.colorWhite,
                                          child: checkByWeekSubstring(
                                              context, provider, index)
                                      ),
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

  Widget checkByWeekSubstring(BuildContext context,
      ProjectsManagerProvider provider, int i) {
    for (int x = 0; x < provider.projectNameList.length; x++) {
      if (provider.projectNameList[x].weekId == provider.daysUpperCase[i]) {
        return projectNameSubStringContainer(context, provider, x);
      }
    }
    return Container();
  }

  Widget projectNameSubStringContainer(BuildContext context,
      ProjectsManagerProvider provider, int weekDaysIndex) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: provider.projectNameList[weekDaysIndex].projectName.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              await provider.crewOnThisProject(context,
                  provider.projectNameList[weekDaysIndex].projectName[index].sId
                      .toString()).then((value) {
                        if(value == true){
                          bottomSheetProjectDetails(
                            _scaffoldkey.currentContext!,
                            onTap: () {},
                            timeSheetOrSchedule: true,
                            projectData: provider.projectData!,
                            projectColor: provider.projectNameList[weekDaysIndex]
                                .projectName[index].color
                          );
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
                            .projectName[index].color,
                        borderRadius: BorderRadius.circular(
                            DimensionConstants.d20.r)),
                    child: Center(
                      child: Text(provider.projectNameList[weekDaysIndex]
                          .projectName[index].projectName!
                          .substring(0, 2)
                          .toUpperCase())
                          .semiBoldText(
                          context,
                          DimensionConstants.d14.sp,
                          TextAlign.center,
                          color: ColorConstants
                              .colorWhite),
                    ))),
          );
        });
  }

}
