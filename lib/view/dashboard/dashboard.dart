// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/model/allProjectCrewResponse.dart';
import 'package:beehive/model/check_box_model_crew.dart';
import 'package:beehive/model/crew_dashboard_response.dart';
import 'package:beehive/model/project_working_hour_detail.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../constants/image_constants.dart';
import '../../constants/route_constants.dart';
import '../../helper/common_widgets.dart';
import '../../helper/dialog_helper.dart';
import '../../locator.dart';
import '../../provider/bottom_bar_provider.dart';
import '../../provider/dashboard_provider.dart';
import '../../widget/custom_tab_bar.dart';
import '../../widget/get_time.dart';
import '../../widget/image_view.dart';
import '../base_view.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardProvider provider = locator<DashboardProvider>();

  BottomBarProvider? bottomBarProvider;
  TabController? controller;
  Timer? timer;

  @override
  void initState() {
    bottomBarProvider = Provider.of<BottomBarProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(onModelReady: (provider) async {
      controller = TabController(length: 3, vsync: this);
      this.provider = provider;
      provider.startDate = DateFunctions.getCurrentDateMonthYear();
      provider.endDate = DateFunctions.getCurrentDateMonthYear();
      await getDashBoardData(context);
      provider.startTimer(timer);
    }, builder: (context, provider, _) {
      return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              if (provider.crewResponse != null)
                Column(
                  children: [
                    provider.crewResponse?.projects == 0
                        ? noProjectNotCheckedInContainer(
                        context, "you_have_no_projects".tr(), false)
                        : provider.crewResponse?.userCheckin != null
                        ? projectsCheckOutContainer(
                        provider.crewResponse!.userCheckin!
                            .assignProjectId?.address ??
                            "",
                        provider)
                        : noProjectNotCheckedInContainer(
                        context, "you_are_not_checked_in".tr(), true,
                        onTap: () {
                          //showCheckInDialog(context, provider);
                        }),
                    provider.crewResponse?.projects == 0
                        ? whenDoNotHaveProject()
                        : tabBarView(provider),
                    SizedBox(height: DimensionConstants.d20.h),
                  ],
                ),
              if (provider.state == ViewState.busy) (const CustomCircularBar())
            ],
          ));
    });
  }

  Widget whenDoNotHaveProject() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: DimensionConstants.d20.h,
          ),
          GestureDetector(
              onTap: () {
                provider.checkedInNoProjects = true;
                provider.updateLoadingStatus(true);
              },
              child: const ImageView(
                path: ImageConstants.noProject,
              )),
          SizedBox(height: DimensionConstants.d17.h),
          Text("you_have_no_projects_dot".tr())
              .boldText(context, DimensionConstants.d18.sp, TextAlign.center),
          SizedBox(
            width: DimensionConstants.d207.w,
            child: Text("to_join_a_project".tr()).regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          SizedBox(height: DimensionConstants.d47.h),
          Text("in_the_meantime_update_your_project".tr()).regularText(
              context, DimensionConstants.d14.sp, TextAlign.center),
          SizedBox(height: DimensionConstants.d10.h),
          Padding(
            padding: EdgeInsets.only(
                left: DimensionConstants.d20.w,
                right: DimensionConstants.d25.w),
            child: CommonWidgets.commonButton(context, "update_my_profile".tr(),
                height: DimensionConstants.d50.h, onBtnTap: () {
                  Navigator.pushNamed(context, RouteConstants.editProfilePage);
                }, shadowRequired: false),
          ),
          SizedBox(height: DimensionConstants.d20.h),
          createYourOwnProjectCard(context),
          SizedBox(height: DimensionConstants.d15.h),
        ],
      ),
    );
  }

  Widget drawerHeadingsRow(BuildContext context, String iconPath,
      String heading,
      {bool active = false, Color? color, required VoidCallback onTapButton}) {
    return GestureDetector(
      onTap: onTapButton,
      child: Padding(
        padding: EdgeInsets.only(left: DimensionConstants.d38.w),
        child: Row(
          children: [
            ImageView(
                path: iconPath,
                color: active
                    ? ColorConstants.primaryColor
                    : (Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.colorBlack)),
            SizedBox(width: DimensionConstants.d16.w),
            !active
                ? Text(heading).regularText(
                context, DimensionConstants.d16.sp, TextAlign.left)
                : Text(heading).boldText(
                context, DimensionConstants.d16.sp, TextAlign.left)
          ],
        ),
      ),
    );
  }

  Widget noProjectNotCheckedInContainer(BuildContext context, String txt,
      bool checkInButton,
      {VoidCallback? onTap}) {
    return Container(
      width: double.infinity,
      color: ColorConstants.deepBlue,
      height: DimensionConstants.d147.h,
      padding: EdgeInsets.fromLTRB(
          DimensionConstants.d20.w,
          DimensionConstants.d18.w,
          DimensionConstants.d20.w,
          DimensionConstants.d23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // provider.updateNoProject();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey " "${provider.crewResponse?.crew?.name ?? ""},")
                          .boldText(context, DimensionConstants.d18.sp,
                          TextAlign.left,
                          color: ColorConstants.colorWhite),
                      Text("buzzing".tr()).boldText(
                          context, DimensionConstants.d18.sp, TextAlign.left,
                          color: ColorConstants.colorWhite),
                    ],
                  )),
              if (checkInButton)
                checkInCheckOutBtn(
                  "check_in".tr(),
                  ColorConstants.colorWhite,
                  onBtnTap: () async {
                    await provider.getAllProjectsWithoutCheckout(context);
                    showCheckInDialog(context, provider);
                  },
                )
            ],
          ),
          SizedBox(height: DimensionConstants.d12.h),
          GestureDetector(
              onTap: onTap,
              child: noProjectCheckedInLocationContainer(context, txt))
        ],
      ),
    );
  }

  Widget noProjectCheckedInLocationContainer(BuildContext context, String txt,
      {bool forwardIcon = false}) {
    return Container(
      alignment: Alignment.centerLeft,
      height: DimensionConstants.d48.h,
      decoration: BoxDecoration(
          color: ColorConstants.colorWhite10,
          border: Border.all(color: ColorConstants.colorWhite30, width: 1),
          borderRadius:
          BorderRadius.all(Radius.circular(DimensionConstants.d8.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d14.w),
        child: Row(
          children: [
            const ImageView(path: ImageConstants.locationIcon),
            SizedBox(width: DimensionConstants.d11.w),
            Expanded(
                child: Text(txt).boldText(
                    context, DimensionConstants.d16.sp, TextAlign.left,
                    color: ColorConstants.colorWhite,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
            forwardIcon
                ? ImageView(
              path: ImageConstants.forwardArrowIcon,
              color: ColorConstants.colorWhite,
              height: DimensionConstants.d10.h,
              width: DimensionConstants.d5.w,
            )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget checkInCheckOutBtn(String btnText, Color color,
      {VoidCallback? onBtnTap}) {
    return GestureDetector(
      onTap: onBtnTap,
      child: Container(
        alignment: Alignment.center,
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d91.w,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.all(
            Radius.circular(DimensionConstants.d8.r),
          ),
        ),
        child: Text(btnText).semiBoldText(
            context, DimensionConstants.d14.sp, TextAlign.center,
            color: color),
      ),
    );
  }

  Widget projectsCheckOutContainer(String location,
      DashboardProvider provider) {
    return Container(
      width: double.infinity,
      color: ColorConstants.deepBlue,
      height: DimensionConstants.d194.h,
      padding: EdgeInsets.fromLTRB(
          DimensionConstants.d20.w,
          DimensionConstants.d13.w,
          DimensionConstants.d20.w,
          DimensionConstants.d17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const ImageView(path: ImageConstants.checkedInIcon),
                  SizedBox(width: DimensionConstants.d12.w),
                  Text("${"checked_in".tr()} ${provider.timeFromLastCheckedIn
                      .substring(0, 2)}h ${provider.timeFromLastCheckedIn
                      .substring(3, 5)}m")
                      .regularText(
                      context, DimensionConstants.d16.sp, TextAlign.left,
                      color: ColorConstants.colorLightGreen),
                ],
              ),
              checkInCheckOutBtn(
                "check_out".tr(),
                ColorConstants.colorLightGreen,
                onBtnTap: () {
                  stillCheckedInAlert(
                      provider.crewResponse?.crew?.name ?? "", location);
                },
              )
            ],
          ),
          SizedBox(height: DimensionConstants.d10.h),
          noProjectCheckedInLocationContainer(context, location,
              forwardIcon: true),
          SizedBox(height: DimensionConstants.d16.h),
          Padding(
            padding: EdgeInsets.fromLTRB(
                DimensionConstants.d20.w, 0.0, DimensionConstants.d20.w, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                lastCheckInTotalHoursColumn(provider, 1),
                lastCheckInTotalHoursColumn(provider, 2),
              ],
            ),
          )
        ],
      ),
    );
  }

  // here type 1 means last check in widget and type 2 means total hours widget
  Widget lastCheckInTotalHoursColumn(DashboardProvider provider, int type) {
    var time = "";
    var timeFormat = "";
    var text = "";
    if (type == 1) {
      text = "last_check_in".tr();
      if (provider.crewResponse!.userCheckin!.interuption!.length > 0) {
        time = DateFunctions.amPmTime(provider
            .crewResponse!
            .userCheckin!
            .interuption![
        provider.crewResponse!.userCheckin!.interuption!.length - 1]
            .endTime!);
      } else {
        time = DateFunctions.amPmTime(
            provider.crewResponse!.userCheckin!.checkInTime!);
      }
      timeFormat = time.substring(6, time.length).toUpperCase();
      time = time.substring(0, 6);
    } else {
      text = "total_hours".tr();
      timeFormat = "HR";
      time = provider.totalSpendTime;
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(time).semiBoldText(
                context, DimensionConstants.d22.sp, TextAlign.left,
                color: ColorConstants.colorWhite),
            SizedBox(width: DimensionConstants.d3.w),
            Text(timeFormat).regularText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: ColorConstants.colorWhite),
          ],
        ),
        SizedBox(height: DimensionConstants.d5.h),
        Text(text).regularText(
            context, DimensionConstants.d14.sp, TextAlign.left,
            color: ColorConstants.colorWhite),
      ],
    );
  }

  Widget createYourOwnProjectCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        side: const BorderSide(color: ColorConstants.colorWhite90, width: 1.5),
      ),
      margin: EdgeInsets.only(
          left: DimensionConstants.d18.w, right: DimensionConstants.d19.w),
      child: Column(
        children: [
          SizedBox(height: DimensionConstants.d20.h),
          Text("create_your_own_projects".tr())
              .boldText(context, DimensionConstants.d16.sp, TextAlign.center),
          SizedBox(height: DimensionConstants.d6.h),
          SizedBox(
            width: DimensionConstants.d294.w,
            child: Text("crew_managers_create_projects".tr()).regularText(
                context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          SizedBox(height: DimensionConstants.d7.h),
          Padding(
            padding: EdgeInsets.only(
                left: DimensionConstants.d14.w,
                right: DimensionConstants.d18.w),
            child: CommonWidgets.commonButton(
                context, "upgrade_to_crew_manager".tr(),
                height: DimensionConstants.d50.h,
                color1: ColorConstants.blueGradient2Color,
                color2: ColorConstants.blueGradient1Color,
                fontSize: DimensionConstants.d14.sp,
                onBtnTap: () {
                  Navigator.pushNamed(context, RouteConstants.upgradePage);
                }),
          ),
          SizedBox(height: DimensionConstants.d20.h),
        ],
      ),
    );
  }

  /// Dashboard Alerts ~~~~~~~~~~~~~~~~~~~~~~~~
  showCheckInDialog(BuildContext context, DashboardProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          //   contentPadding: EdgeInsets.symmetric(vertical: DimensionConstants.d24.h, horizontal: DimensionConstants.d24.w),
          insetPadding: EdgeInsets.fromLTRB(DimensionConstants.d16.w, 0.0,
              DimensionConstants.d16.w, DimensionConstants.d130.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          elevation: 0,
          content: Builder(builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: DimensionConstants.d24.h,
                  horizontal: DimensionConstants.d24.w),
              height: DimensionConstants.d220.h,
              width: DimensionConstants.d343.w,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: ImageView(
                          path: ImageConstants.closeIcon,
                          color:
                          (Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : ColorConstants.colorBlack),
                        )),
                  ),
                  Text("check_in".tr()).boldText(
                      context, DimensionConstants.d18.sp, TextAlign.center),
                  SizedBox(height: DimensionConstants.d23.h),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.colorLightGreyF2,
                      borderRadius: BorderRadius.all(
                          Radius.circular(DimensionConstants.d8.r)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        hint: Text("Select the project").regularText(context,
                            DimensionConstants.d14.sp, TextAlign.center),
                        items: provider.allProjectCrewResponse!.activeProjects!
                            .toSet()
                            .map((ProjectDetail item) =>
                            DropdownMenuItem<String>(
                              value: item.projectName,
                              onTap: () {
                                provider.assignProjectId = item.id!;
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        DimensionConstants.d8.w),
                                    child: Row(
                                      children: [
                                        const ImageView(
                                            path: ImageConstants
                                                .locationIcon),
                                        SizedBox(
                                            width: DimensionConstants.d8.w),
                                        Text(item.projectName!).regularText(
                                            context,
                                            DimensionConstants.d14.sp,
                                            TextAlign.center)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                            .toList(),
                        icon: Container(
                          height: DimensionConstants.d42.h,
                          decoration: BoxDecoration(
                            color: ColorConstants.colorLightGreyF2,
                            borderRadius: BorderRadius.only(
                                topRight:
                                Radius.circular(DimensionConstants.d8.r),
                                bottomRight:
                                Radius.circular(DimensionConstants.d8.r)),
                          ),
                          child: Row(
                            children: [
                              const ImageView(
                                  path: ImageConstants.downArrowIcon),
                              SizedBox(width: DimensionConstants.d4.w),
                            ],
                          ),
                        ),
                        onChanged: (String? value) {},
                      ),
                    ),
                  ),
                  SizedBox(height: DimensionConstants.d14.h),
                  CommonWidgets.commonButton(context, "check_in".tr(),
                      height: DimensionConstants.d50.h, onBtnTap: () {
                        if (provider.assignProjectId.isEmpty) {
                          DialogHelper.showMessage(
                              context, "Please Select Project");
                        } else {
                          Navigator.of(context).pop();
                          provider.checkInApi(
                              _scaffoldKey.currentContext, bottomBarProvider!);
                        }
                      })
                ],
              ),
            );
          }),
        );
      },
    );
  }

  stillCheckedInAlert(String nameOfUser, String address) {
    var checkInTime = DateFunctions.dateFormatyyyyMMddHHmm(DateTime.now());
    SharedPreference.prefs!
        .setString(SharedPreference.popUpShowTime, checkInTime);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.fromLTRB(
                  DimensionConstants.d16.w, 0.0, DimensionConstants.d16.w, 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
              ),
              elevation: 0,
              content: Builder(builder: (context) {
                return Container(
                  padding: EdgeInsets.fromLTRB(
                      DimensionConstants.d20.w,
                      DimensionConstants.d33.h,
                      DimensionConstants.d20.w,
                      DimensionConstants.d24.h),
                  height: DimensionConstants.d276.h,
                  width: DimensionConstants.d343.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Hey $nameOfUser").boldText(
                          context, DimensionConstants.d18.sp, TextAlign.center),
                      const Text("are you still checked-in?").boldText(
                          context, DimensionConstants.d18.sp, TextAlign.center),
                      SizedBox(height: DimensionConstants.d24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ImageView(path: ImageConstants.checkedInIcon),
                          SizedBox(width: DimensionConstants.d8.w),
                          Text("${"checked_in".tr()} ${provider
                              .timeFromLastCheckedIn.substring(
                              0, 2)}h ${provider.timeFromLastCheckedIn
                              .substring(3, 5)}m")
                              .semiBoldText(context, DimensionConstants.d14.sp,
                              TextAlign.left),
                        ],
                      ),
                      SizedBox(height: DimensionConstants.d8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ImageView(path: ImageConstants.locationIcon),
                          SizedBox(width: DimensionConstants.d8.w),
                          Expanded(
                              child: Text(address).semiBoldText(context,
                                  DimensionConstants.d14.sp, TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      SizedBox(height: DimensionConstants.d39.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensionConstants.d4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: DimensionConstants.d143.w,
                                child: CommonWidgets.commonButton(
                                    context, "no_check_out".tr(), height: 50,
                                    onBtnTap: () {
                                      Navigator.of(context).pop();
                                      whenDidYouCheckOutAlert(address);
                                    })),
                            SizedBox(width: DimensionConstants.d9.w),
                            SizedBox(
                                width: DimensionConstants.d143.w,
                                child: CommonWidgets.commonButton(
                                    context, "i_am_still_here".tr(),
                                    color1: ColorConstants.deepBlue,
                                    color2: ColorConstants.deepBlue,
                                    height: 50, onBtnTap: () {
                                  Navigator.of(context).pop();
                                })),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }));
        });
  }

  /// widget for checkOut
  whenDidYouCheckOutAlert(String projectName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (buildContext, setState) {
            provider.selectedCheckOutTime =
                DateFunctions.twentyFourHourTO12Hour(
                    provider.initialTime.format(context));
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.fromLTRB(DimensionConstants.d16.w, 0.0,
                    DimensionConstants.d16.w, DimensionConstants.d75.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                ),
                elevation: 0,
                content: Builder(builder: (buildContext) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                        DimensionConstants.d24.w,
                        DimensionConstants.d24.h,
                        DimensionConstants.d24.w,
                        DimensionConstants.d24.h),
                    height: DimensionConstants.d276.h,
                    width: DimensionConstants.d343.w,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: ImageView(
                                  path: ImageConstants.smallBackIcon)),
                        ),
                        SizedBox(height: DimensionConstants.d9.h),
                        Text("when_did_you_check_out".tr()).boldText(context,
                            DimensionConstants.d18.sp, TextAlign.center),
                        SizedBox(height: DimensionConstants.d13.h),
                        GestureDetector(
                          onTap: () {
                            provider
                                .showTimePickerWidget(buildContext)
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: DimensionConstants.d45.h,
                            width: DimensionConstants.d171.w,
                            decoration: BoxDecoration(
                                color: ColorConstants.colorLightGreyF2,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(DimensionConstants.d8.r))),
                            child: Row(
                              children: [
                                SizedBox(width: DimensionConstants.d16.w),
                                const ImageView(
                                    path: ImageConstants.clockIcon,
                                    color: ColorConstants.colorBlack),
                                SizedBox(width: DimensionConstants.d16.w),
                                Text(provider.selectedCheckOutTime
                                    ?.toUpperCase() ??
                                    "")
                                    .boldText(
                                    context,
                                    DimensionConstants.d16.sp,
                                    TextAlign.left,
                                    color: ColorConstants.colorBlack),
                                Expanded(
                                    child: SizedBox(
                                        width: DimensionConstants.d2.w)),
                                const ImageView(
                                    path: ImageConstants.downArrowIcon,
                                    color: ColorConstants.colorBlack),
                                SizedBox(width: DimensionConstants.d14.w),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: DimensionConstants.d12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ImageView(path: ImageConstants.locationIcon),
                            SizedBox(width: DimensionConstants.d8.w),
                            Expanded(
                                child: Text(projectName).semiBoldText(context,
                                    DimensionConstants.d14.sp, TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                        SizedBox(height: DimensionConstants.d22.h),
                        CommonWidgets.commonButton(context, "check_out".tr(),
                            height: 50, onBtnTap: () {
                              Navigator.of(context).pop();
                              provider.checkOutApi(context, bottomBarProvider!);
                            })
                      ],
                    ),
                  );
                }));
          });
        });
  }

  Widget tabBarView(DashboardProvider provider) {
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
                  provider.updateSelectedTabIndex(index);
                  switch (index) {
                    case 0:
                      {
                        provider.startDate =
                            DateFunctions.getCurrentDateMonthYear();
                        provider.endDate =
                            DateFunctions.getCurrentDateMonthYear();
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        getDashBoardData(context);
                        break;
                      }
                    case 1:
                      {
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.nextWeekDays(7);
                        getDashBoardData(context);
                        break;
                      }
                    case 2:
                      {
                        provider.selectedStartDate = null;
                        provider.selectedEndDate = null;
                        provider.nextWeekDays(14);
                        getDashBoardData(context);
                        break;
                      }
                  }
                },
                tabs: [
                  Container(
                    alignment: Alignment.center,
                    height: DimensionConstants.d50.h,
                    width: DimensionConstants.d114.w,
                    child: controller!.index == 0
                        ? Text("today".tr()).boldText(context,
                        DimensionConstants.d16.sp, TextAlign.center,
                        color: ColorConstants.colorWhite)
                        : Text("today".tr()).regularText(context,
                        DimensionConstants.d16.sp, TextAlign.center,
                        color: ColorConstants.colorBlack),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: DimensionConstants.d50.h,
                    width: DimensionConstants.d114.w,
                    child: provider.selectedTabIndex == 1
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
                    child: provider.selectedTabIndex == 2
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
              child: provider.selectedTabIndex == 0
                  ? provider.crewResponse!.allCheckin!.isNotEmpty
                  ? projectsAndHoursCardList(provider)
                  : zeroProjectZeroHourCard(provider)
                  : weeklyTabBarContainer(provider),
            )
          ],
        ),
      ),
    );
  }

  Widget zeroProjectZeroHourCard(DashboardProvider provider) {
    return Container(
      margin: EdgeInsets.only(top: DimensionConstants.d16.h),
      child: Card(
        color: ColorConstants.colorLightGrey,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: ColorConstants.colorLightGrey, width: 1.0),
          borderRadius: BorderRadius.circular(DimensionConstants.d12.r),
        ),
        child: Column(
          children: [
            Container(
              color: (Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.colorWhite),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: projectsHoursRow(
                          ImageConstants.mapIcon, "0 ${"projects".tr()}")),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(
                      ImageConstants.clockIcon, "0 ${"hours".tr()}")
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: DimensionConstants.d30.h),
                  GestureDetector(
                      onTap: () {
                        //   provider.hasProjects = true;
                        provider.updateLoadingStatus(true);
                      },
                      child: const ImageView(
                        path: ImageConstants.noProject,
                      )),
                  SizedBox(height: DimensionConstants.d17.h),
                  Text(provider.crewResponse!.userCheckin == null
                      ? "You_have_not_checked_in_today".tr()
                      : "You have not checkout any project yet")
                      .regularText(
                      context, DimensionConstants.d14.sp, TextAlign.center,
                      color: ColorConstants.colorBlack)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget projectsHoursRow(String iconPath, String txt) {
    return Row(
      children: [
        ImageView(path: iconPath),
        SizedBox(width: DimensionConstants.d9.w),
        Text(txt).boldText(context, DimensionConstants.d18.sp, TextAlign.center)
      ],
    );
  }

  Widget projectsAndHoursCardList(DashboardProvider provider) {
    return Padding(
      padding: EdgeInsets.only(top: DimensionConstants.d16.h),
      child: Card(
        elevation: 2.5,
        color: (Theme
            .of(context)
            .brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.colorWhite),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorConstants.colorWhite, width: 1.0),
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Expanded(
          child: Column(
            children: [
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
                      topRight: Radius.circular(DimensionConstants.d8.r)),
                ),
                height: DimensionConstants.d70.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    projectsHoursRow(ImageConstants.mapIcon,
                        "${provider.crewResponse!.allCheckin!
                            .length} ${"projects".tr()}"),
                    Container(
                      height: DimensionConstants.d70.h,
                      width: DimensionConstants.d1.w,
                      color: ColorConstants.colorLightGrey,
                    ),
                    projectsHoursRow(
                        ImageConstants.clockIcon,
                        provider.crewResponse!.allCheckin!.isEmpty
                            ? "0 Hours"
                            : "${provider.totalHours} ${"hours".tr()}")
                  ],
                ),
              ),
              ListView.separated(
                itemCount: provider.crewResponse!.allCheckin!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return projectDetailTile(context,
                      checkInProjectDetail:
                      provider.crewResponse!.allCheckin![index]);
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
      ),
    );
  }

  Widget weeklyTabBarContainer(DashboardProvider provider) {
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
                        backNextBtn(ImageConstants.backIconIos, () {
                          provider.previousWeekDays(
                              provider.selectedTabIndex == 1 ? 7 : 14);
                          getDashBoardData(context);
                        }),
                        Text("${DateFunctions.capitalize(
                            provider.weekFirstDate ?? "")} - ${DateFunctions
                            .capitalize(provider.weekEndDate ?? "")}")
                            .boldText(context, DimensionConstants.d16.sp,
                            TextAlign.center,
                            color: ColorConstants.colorWhite),
                        provider.endDate !=
                            DateFormat("yyyy-MM-dd").format(DateTime.now())
                            ? backNextBtn(ImageConstants.nextIconIos, () {
                          provider.nextWeekDays(
                              provider.selectedTabIndex == 1 ? 7 : 14);
                          provider.getDashBoardData(
                              context, bottomBarProvider);
                        })
                            : Visibility(
                            visible: false,
                            child: backNextBtn(
                                ImageConstants.nextIconIos, () {}))
                      ],
                    ),
                  ),
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
                      borderRadius: BorderRadius.all(
                          Radius.circular(DimensionConstants.d8.r)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                            (Theme
                                .of(context)
                                .brightness == Brightness.dark
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
                              projectsHoursRow(ImageConstants.mapIcon,
                                  "${provider.crewResponse!.allCheckin!
                                      .length} ${"projects".tr()}"),
                              Container(
                                height: DimensionConstants.d70.h,
                                width: DimensionConstants.d1.w,
                                color: ColorConstants.colorLightGrey,
                              ),
                              projectsHoursRow(
                                  ImageConstants.clockIcon,
                                  provider.crewResponse!.allCheckin!.isEmpty
                                      ? "0 Hours"
                                      : "${provider.totalHours} ${"hours"
                                      .tr()}")
                            ],
                          ),
                        ),
                        provider.crewResponse!.allCheckin!.isEmpty
                            ? SizedBox(
                          height: DimensionConstants.d300.h,
                          child: Center(
                            child: const Text(
                                "You have not checked out Any project yet")
                                .regularText(
                                context,
                                DimensionConstants.d14.sp,
                                TextAlign.center,
                                color: ColorConstants.colorBlack),
                          ),
                        )
                            : Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: provider.weeklyData.length,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        color: ColorConstants
                                            .colorLightGreyF2,
                                        height: DimensionConstants.d32.h,
                                        alignment: Alignment.center,
                                        child: Text(provider
                                            .weeklyData[index]
                                            .date ??
                                            "")
                                            .boldText(
                                            context,
                                            DimensionConstants.d13.sp,
                                            TextAlign.center,
                                            color: ColorConstants
                                                .colorBlack),
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemCount: provider
                                            .weeklyData[index]
                                            .checkInDataList!
                                            .length,
                                        itemBuilder:
                                            (context, innerIndex) {
                                          return projectDetailTile(
                                              context,
                                              checkInProjectDetail: provider
                                                  .weeklyData[index]
                                                  .checkInDataList![
                                              innerIndex]);
                                        },
                                        separatorBuilder:
                                            (context, index) {
                                          return const Divider(
                                              color: ColorConstants
                                                  .colorGreyDrawer,
                                              height: 0.0,
                                              thickness: 1.5);
                                        },
                                      ),
                                    ],
                                  );
                                }),
                            const Divider(
                                color: ColorConstants.colorGreyDrawer,
                                height: 0.0,
                                thickness: 1.5),
                            SizedBox(height: DimensionConstants.d12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DimensionConstants.d16.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("total_hours".tr())
                                          .semiBoldText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.center),
                                      Text("${provider.totalHours} Hrs").semiBoldText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.center)
                                    ],
                                  ),
                                  SizedBox(
                                      height: DimensionConstants.d6.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("x \$${provider.averageRatePerHour}/hr").semiBoldText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.center),
                                      Text("\$${provider.totalEarnings}").semiBoldText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.center)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: DimensionConstants.d16.h),
                            exportTimeSheetBtn(),
                            SizedBox(height: DimensionConstants.d16.h),
                          ],
                        )
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

  Widget backNextBtn(String path, onTap) {
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

  Widget exportTimeSheetBtn() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                DialogHelper.exportFileDialog(
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

  Widget customStepper(CheckInProjectDetailCrew checkInProjectDetail) {
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

  Widget projectDetailTile(BuildContext context,
      {VoidCallback? onTap, CheckInProjectDetailCrew? checkInProjectDetail}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: DimensionConstants.d75.w,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: DimensionConstants.d11.h,
              horizontal: DimensionConstants.d16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(DimensionConstants.d5),
                height: DimensionConstants.d40.h,
                width: DimensionConstants.d40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: checkInProjectDetail!.color,
                ),
                child: Text(Validations.getInitials(
                    string:
                    checkInProjectDetail.assignProjectId!.projectName ??
                        "",
                    limitTo: 2))
                    .boldText(
                    context, DimensionConstants.d16.sp, TextAlign.center,
                    color: ColorConstants.colorWhite),
              ),
              SizedBox(width: DimensionConstants.d12.w),
              Text(DateFunctions.dateTO12Hour(checkInProjectDetail.checkInTime!)
                  .substring(
                  0,
                  DateFunctions
                      .dateTO12Hour(
                      checkInProjectDetail.checkInTime!)
                      .length -
                      1))
                  .regularText(
                  context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d11.w),
              customStepper(checkInProjectDetail),
              SizedBox(width: DimensionConstants.d10.w),
              Text(DateFunctions.dateTO12Hour(
                  checkInProjectDetail.checkOutTime!)
                  .substring(
                  0,
                  DateFunctions
                      .dateTO12Hour(
                      checkInProjectDetail.checkOutTime!)
                      .length -
                      1))
                  .regularText(
                  context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d12.w),
              Text("${DateFunctions.calculateTotalHourTime(
                  checkInProjectDetail.checkInTime!,
                  checkInProjectDetail.checkOutTime!)} h")
                  .boldText(
                  context, DimensionConstants.d13.sp, TextAlign.center),
              SizedBox(width: DimensionConstants.d8.w),
              ImageView(
                  path: ImageConstants.forwardArrowIcon,
                  color: (Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getDashBoardData(BuildContext context) async {
    await provider.getDashBoardData(context, bottomBarProvider);
    if (provider.crewResponse!.userCheckin != null) {
      var value = provider.oneHourSpendForCheckin();
      if (value) {
        Future.delayed(const Duration(seconds: 1), () {
          var value=provider.timeFromLastCheckedIn;
          print("value is${value}");
          stillCheckedInAlert(provider.crewResponse?.crew?.name ?? "",
              provider.crewResponse!.userCheckin!.assignProjectId?.address ?? "");
        });
      }
    }
  }
}
