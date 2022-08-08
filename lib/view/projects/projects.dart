import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/projects_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/projects/project_details_page.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return BaseView<ProjectsProvider>(
      onModelReady: (provider) {
        provider.indexCheck(tabController.index);
      },
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.colorWhite,
          body: Column(
            children: <Widget>[
              tabBarView(context, tabController, provider),
              tabController.index == 0
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionConstants.d18.w),
                      child: CommonWidgets.commonButton(
                        context,
                        "create_a_new_project".tr(),
                        color1: ColorConstants.primaryGradient1Color,
                        color2: ColorConstants.primaryGradient2Color,
                        fontSize: DimensionConstants.d16.sp,
                      ),
                    )
                  : Container(),
              tabController.index == 1
                  ? Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: DimensionConstants.d40.w),
                            child: Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: DimensionConstants.d10.h,
                                      width: DimensionConstants.d10.w,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.schedule5,
                                        borderRadius: BorderRadius.circular(
                                            DimensionConstants.d5.r),
                                      ),
                                    ),
                                    SizedBox(
                                      width: DimensionConstants.d5.w,
                                    ),
                                    Text("Momentum Smart Project").regularText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.left,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                                  ],
                                ),
                                SizedBox(
                                  width: DimensionConstants.d15.w,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: DimensionConstants.d10.h,
                                      width: DimensionConstants.d10.w,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.green6FCF97,
                                        borderRadius: BorderRadius.circular(
                                            DimensionConstants.d5.r),
                                      ),
                                    ),
                                    SizedBox(
                                      width: DimensionConstants.d5.w,
                                    ),
                                    Text("Momentum Digital").regularText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.left,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: DimensionConstants.d15.h,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: DimensionConstants.d40.w),
                            child: Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: DimensionConstants.d10.h,
                                      width: DimensionConstants.d10.w,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.schedule5,
                                        borderRadius: BorderRadius.circular(
                                            DimensionConstants.d5.r),
                                      ),
                                    ),
                                    SizedBox(
                                      width: DimensionConstants.d5.w,
                                    ),
                                    Text("Adam’s Lodge").regularText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.left,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                                  ],
                                ),
                                SizedBox(
                                  width: DimensionConstants.d15.w,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: DimensionConstants.d10.h,
                                      width: DimensionConstants.d10.w,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.green6FCF97,
                                        borderRadius: BorderRadius.circular(
                                            DimensionConstants.d5.r),
                                      ),
                                    ),
                                    SizedBox(
                                      width: DimensionConstants.d5.w,
                                    ),
                                    Text("Kennedy House").regularText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.left,
                                        color: Theme.of(context).brightness ==
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
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

Widget tabBarView(
    BuildContext context, TabController controller, ProjectsProvider provider) {
  return Column(
    children: [
      SizedBox(
        child: Container(
          height: DimensionConstants.d64.h,
          width: DimensionConstants.d375.w,
          color: ColorConstants.deepBlue,
          child: Padding(
            padding: EdgeInsets.only(
                left: DimensionConstants.d8.w,
                right: DimensionConstants.d8.w,
                top: DimensionConstants.d20.h,
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
      Container(
        height: DimensionConstants.d520.h,
        // width: DimensionConstants.d313.w,
        child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              allProjects(context),
              schedule(context, provider),
            ]),
      ),
    ],
  );
}

Widget allProjects(BuildContext context) {
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
                    Text("4").semiBoldText(
                        context, DimensionConstants.d20.sp, TextAlign.left,
                        color: Theme.of(context).brightness == Brightness.dark
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
                    Text("556").semiBoldText(
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
      projectDetails(context),
    ],
  );
}

Widget projectDetails(BuildContext context) {
  return Container(
    height: DimensionConstants.d410.h,
    width: DimensionConstants.d343.w,
    color: Theme.of(context).brightness == Brightness.dark
        ? ColorConstants.colorBlack
        : ColorConstants.grayF1F1F1,
    child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: DimensionConstants.d5.h),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstants.projectDetailsPage,
                    arguments: ProjectDetailsPage(archivedOrProject: false));
              },
              child: Container(
                height: DimensionConstants.d126.h,
                // width: DimensionConstants.d343.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorBlack
                        : ColorConstants.colorWhite,
                    border: Theme.of(context).brightness == Brightness.dark
                        ? Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
                          top: DimensionConstants.d8.h,
                          bottom: DimensionConstants.d8.h),
                      child: Row(
                        children: <Widget>[
                          Container(
                              height: DimensionConstants.d32.h,
                              width: DimensionConstants.d32.w,
                              decoration: BoxDecoration(
                                  color: ColorConstants.green6FCF97,
                                  borderRadius: BorderRadius.circular(
                                      DimensionConstants.d16.r)),
                              child: Center(
                                child: Text("MD").semiBoldText(context,
                                    DimensionConstants.d14.sp, TextAlign.center,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ColorConstants.colorWhite
                                        : ColorConstants.colorBlack),
                              )),
                          SizedBox(
                            width: DimensionConstants.d16.w,
                          ),
                          Text("Momentum Digital").semiBoldText(context,
                              DimensionConstants.d14.sp, TextAlign.center,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack),
                          Expanded(child: Container()),
                          ImageView(
                            path: ImageConstants.arrowIcon,
                            width: DimensionConstants.d5.w,
                            height: DimensionConstants.d10.h,
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
                          Text("total_hours".tr()).regularText(context,
                              DimensionConstants.d14.sp, TextAlign.center,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack),
                          Expanded(child: Container()),
                          Text("200").semiBoldText(context,
                              DimensionConstants.d20.sp, TextAlign.center,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

Widget schedule(BuildContext context, ProjectsProvider provider) {
  return Padding(
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : Colors.transparent)
                  : null,
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
                height: Theme.of(context).brightness == Brightness.dark
                    ? DimensionConstants.d413.h
                    : DimensionConstants.d416.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorBlack
                        : ColorConstants.colorWhite,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(DimensionConstants.d8.r),
                        bottomRight: Radius.circular(DimensionConstants.d8.r))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        height: DimensionConstants.d37.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.dates.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: DimensionConstants.d19.w,
                                    right: DimensionConstants.d12.w,
                                    top: DimensionConstants.d9.h),
                                child: Text("${provider.dates[index]}")
                                    .semiBoldText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.center,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                              );
                            })),
                    Container(
                        height: DimensionConstants.d37.h,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.grayF1F1F1,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.days.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: DimensionConstants.d19.w,
                                    right: DimensionConstants.d14.w,
                                    top: DimensionConstants.d9.h),
                                child: Text("${provider.days[index]}")
                                    .semiBoldText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.center,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                              );
                            })),
                    Container(
                        height: DimensionConstants.d45.h,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorWhite,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.name.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: DimensionConstants.d10.w,
                                      right: DimensionConstants.d2.w,
                                      top: DimensionConstants.d9.h),
                                  child: Container(
                                      height: DimensionConstants.d35.h,
                                      width: DimensionConstants.d35.w,
                                      decoration: BoxDecoration(
                                          color: provider.colors[index],
                                          borderRadius: BorderRadius.circular(
                                              DimensionConstants.d20.r)),
                                      child: Center(
                                        child: Text("${provider.name[index]}")
                                            .semiBoldText(
                                                context,
                                                DimensionConstants.d14.sp,
                                                TextAlign.center,
                                                color:
                                                    ColorConstants.colorWhite),
                                      )));
                            })),
                    Container(
                        height: DimensionConstants.d45.h,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorWhite,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.days2.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: DimensionConstants.d10.w,
                                      right: DimensionConstants.d2.w,
                                      top: DimensionConstants.d9.h),
                                  child: Container(
                                      height: DimensionConstants.d35.h,
                                      width: DimensionConstants.d35.w,
                                      decoration: BoxDecoration(
                                          color: provider.colors2[index],
                                          borderRadius: BorderRadius.circular(
                                              DimensionConstants.d20.r)),
                                      child: Center(
                                        child: Text("${provider.days2[index]}")
                                            .semiBoldText(
                                                context,
                                                DimensionConstants.d14.sp,
                                                TextAlign.center,
                                                color:
                                                    ColorConstants.colorWhite),
                                      )));
                            })),
                    Container(
                        height: DimensionConstants.d45.h,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorWhite,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.days3.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: DimensionConstants.d10.w,
                                      right: DimensionConstants.d2.w,
                                      top: DimensionConstants.d9.h),
                                  child: Container(
                                      height: DimensionConstants.d35.h,
                                      width: DimensionConstants.d35.w,
                                      decoration: BoxDecoration(
                                          color: provider.colors3[index],
                                          borderRadius: BorderRadius.circular(
                                              DimensionConstants.d20.r)),
                                      child: Center(
                                        child: Text("${provider.days3[index]}")
                                            .semiBoldText(
                                                context,
                                                DimensionConstants.d14.sp,
                                                TextAlign.center,
                                                color:
                                                    ColorConstants.colorWhite),
                                      )));
                            })),
                    SizedBox(
                      height: DimensionConstants.d28.h,
                    ),
                    SizedBox(
                        height: DimensionConstants.d37.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.dates2.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: DimensionConstants.d19.w,
                                    right: DimensionConstants.d12.w,
                                    top: DimensionConstants.d9.h),
                                child: Text("${provider.dates2[index]}")
                                    .semiBoldText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.center,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                              );
                            })),
                    Container(
                        height: DimensionConstants.d37.h,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.grayF1F1F1,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.days.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: DimensionConstants.d19.w,
                                    right: DimensionConstants.d14.w,
                                    top: DimensionConstants.d9.h),
                                child: Text("${provider.days[index]}")
                                    .semiBoldText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.center,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ColorConstants.colorWhite
                                            : ColorConstants.colorBlack),
                              );
                            })),
                    Container(
                        height: DimensionConstants.d45.h,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorWhite,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.name.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: DimensionConstants.d10.w,
                                      right: DimensionConstants.d2.w,
                                      top: DimensionConstants.d9.h),
                                  child: Container(
                                      height: DimensionConstants.d35.h,
                                      width: DimensionConstants.d35.w,
                                      decoration: BoxDecoration(
                                          color: provider.colors[index],
                                          borderRadius: BorderRadius.circular(
                                              DimensionConstants.d20.r)),
                                      child: Center(
                                        child: Text("${provider.name[index]}")
                                            .semiBoldText(
                                                context,
                                                DimensionConstants.d14.sp,
                                                TextAlign.center,
                                                color:
                                                    ColorConstants.colorWhite),
                                      )));
                            })),
                    Container(
                        height: DimensionConstants.d45.h,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.colorBlack
                            : ColorConstants.colorWhite,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.days3.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: DimensionConstants.d10.w,
                                      right: DimensionConstants.d2.w,
                                      top: DimensionConstants.d9.h),
                                  child: Container(
                                      height: DimensionConstants.d35.h,
                                      width: DimensionConstants.d35.w,
                                      decoration: BoxDecoration(
                                          color: provider.colors3[index],
                                          borderRadius: BorderRadius.circular(
                                              DimensionConstants.d20.r)),
                                      child: Center(
                                        child: Text("${provider.days3[index]}")
                                            .semiBoldText(
                                                context,
                                                DimensionConstants.d14.sp,
                                                TextAlign.center,
                                                color:
                                                    ColorConstants.colorWhite),
                                      )));
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
