// ignore_for_file: use_build_context_synchronously

import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/allProjectCrewResponse.dart';
import 'package:beehive/model/check_box_model_crew.dart';
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
  TabController? controller;

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(onModelReady: (provider) {
      controller = TabController(length: 3, vsync: this);
      this.provider = provider;
      provider.getDashBoardData(context);
    }, builder: (context, provider, _) {
      return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Column(
                children: [
                  provider.crewResponse?.projects == 0
                      ? noProjectNotCheckedInContainer(
                          context, "you_have_no_projects".tr(), false)
                      : provider.crewResponse!.userCheckin != null
                          ? projectsCheckOutContainer(
                              provider.crewResponse!.userCheckin!
                                      .assignProjectId?.address ??
                                  "",
                              provider)
                          : noProjectNotCheckedInContainer(
                              context, "you_are_not_checked_in".tr(), true,
                              onTap: () {
                              showCheckInDialog(context, provider);
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

  Widget drawerHeadingsRow(
      BuildContext context, String iconPath, String heading,
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
                    : (Theme.of(context).brightness == Brightness.dark
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

  Widget noProjectNotCheckedInContainer(
      BuildContext context, String txt, bool checkInButton,
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
            Text(txt).boldText(
                context, DimensionConstants.d16.sp, TextAlign.left,
                color: ColorConstants.colorWhite),
            Expanded(child: Container()),
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

  /// Widget after checkOut
  Widget projectsCheckInContainer(String location) {
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
                  const ImageView(path: ImageConstants.checkoutIcon),
                  SizedBox(width: DimensionConstants.d12.w),
                  Text("checked_out".tr()).regularText(
                      context, DimensionConstants.d16.sp, TextAlign.left,
                      color: ColorConstants.colorWhite),
                ],
              ),
              checkInCheckOutBtn(
                "check_in".tr(),
                ColorConstants.colorWhite,
                onBtnTap: () {
                  provider.isCheckedIn = true;
                  provider.notifyListeners();
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
                GestureDetector(
                    onTap: () {
                      // stillCheckedInAlert(SharedPreference.prefs!.getString(SharedPreference.Crew_NAME)!,provider.minuteCount,location);
                    },
                    child: lastCheckInTotalHoursColumn(
                        "12:50", "PM", "last_check_in".tr())),
                lastCheckInTotalHoursColumn("08:23", "HR", "total_hours".tr()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget projectsCheckOutContainer(
      String location, DashboardProvider provider) {
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
                  Text("${"checked_in".tr()} ${provider.timerHour}h ${provider.minuteCount}m")
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
                      SharedPreference.prefs!
                          .getString(SharedPreference.Crew_NAME)!,
                      provider.minuteCount,
                      provider.timerHour,
                      location);
                  provider.isCheckedIn = false;
                  provider.updateLoadingStatus(true);
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
                lastCheckInTotalHoursColumn(
                    "${provider.hour <= 9 ? 0 : ""}${provider.hour}:${provider.minutes <= 9 ? 0 : ""}${provider.minutes}",
                    "${GetTime.getAmAndPm(provider.hour)}",
                    "last_check_in".tr()),
                lastCheckInTotalHoursColumn("08:23", "HR", "total_hours".tr()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget lastCheckInTotalHoursColumn(
      String time, String timeFormat, String txt) {
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
        Text(txt).regularText(
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
                fontSize: DimensionConstants.d14.sp, onBtnTap: () {
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
                              (Theme.of(context).brightness == Brightness.dark
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
                      provider.checkInApi(_scaffoldKey.currentContext);
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

  stillCheckedInAlert(
      String nameOfUser, int hour, int mint, String projectName) {
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
                          Text("${"checked_in".tr()} ${mint}h ${hour}m")
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
                          Text(projectName).semiBoldText(context,
                              DimensionConstants.d14.sp, TextAlign.left),
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
                                  whenDidYouCheckOutAlert(projectName);
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
          return StatefulBuilder(builder: (context, setState) {
            {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.fromLTRB(DimensionConstants.d16.w,
                      0.0, DimensionConstants.d16.w, DimensionConstants.d75.h),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(DimensionConstants.d8.r),
                  ),
                  elevation: 0,
                  content: Builder(builder: (context) {
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
                              // provider.showTime(context);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: DimensionConstants.d45.h,
                              width: DimensionConstants.d171.w,
                              decoration: BoxDecoration(
                                  color: ColorConstants.colorLightGreyF2,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          DimensionConstants.d8.r))),
                              child: Row(
                                children: [
                                  SizedBox(width: DimensionConstants.d16.w),
                                  const ImageView(
                                      path: ImageConstants.clockIcon,
                                      color: ColorConstants.colorBlack),
                                  SizedBox(width: DimensionConstants.d16.w),
                                  Text(provider.selectedCheckOutTime == null
                                          ? ("${provider.initialTime.hour < 12 ? provider.initialTime.hour : (provider.initialTime.hour - 12)}:${provider.initialTime.minute} " +
                                              GetTime.hoursAM(
                                                  provider.initialTime))
                                          : provider.selectedCheckOutTime!)
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
                              const ImageView(
                                  path: ImageConstants.locationIcon),
                              SizedBox(width: DimensionConstants.d8.w),
                              Text(projectName).semiBoldText(context,
                                  DimensionConstants.d14.sp, TextAlign.left),
                            ],
                          ),
                          SizedBox(height: DimensionConstants.d22.h),
                          CommonWidgets.commonButton(context, "check_out".tr(),
                              height: 50, onBtnTap: () {
                            provider.timeToSend(_scaffoldKey.currentContext);
                            //provider.showTime(_scaffoldKey.currentContext);
                            //SharedPreference.clearCheckIn();

                            //Navigator.of(context).pop();
                            provider.hasCheckInCheckOut = true;
                            provider.updateLoadingStatus(true);
                          })
                        ],
                      ),
                    );
                  }));
            }
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
                  print("selected index ${index}");
                  print("selected index controller ${controller!.index}");
                  provider.updateSelectedTabIndex(index);
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
              child: TabBarView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  provider.crewResponse!.allCheckin!.isNotEmpty
                      ? projectsAndHoursCardList(provider)
                      : zeroProjectZeroHourCard(provider),
                  /*//  provider.hasProjects ? projectsAndHoursCardList() : zeroProjectZeroHourCard(),
                  widget.notCheckedIn == false? projectsAndHoursCardList(provider):
                  widget.navigationValue ==2 ? projectsAndHoursCardList(provider):
                  zeroProjectZeroHourCard(),
                  weeklyTabBarContainer(provider),*/
                  //Icon(Icons.directions_car, size: 350),
                  Icon(Icons.directions_car, size: 350),
                  Icon(Icons.directions_car, size: 350),
                ],
              ),
            ),
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
              color: (Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.colorWhite),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        //   provider.has2Projects = true;
                        provider.updateLoadingStatus(true);
                      },
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
        color: (Theme.of(context).brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.colorWhite),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorConstants.colorWhite, width: 1.0),
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              //  onTap: onTap,
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.blueGradient2Color,
                        ),
                        child:
                            Text(provider.projectNameInitials[index].toString())
                                .boldText(context, DimensionConstants.d16.sp,
                                    TextAlign.center,
                                    color: ColorConstants.colorWhite),
                      ),
                      SizedBox(width: DimensionConstants.d14.w),
                      Container(
                        width: DimensionConstants.d110.w,
                        child: Text("test").boldText(context,
                            DimensionConstants.d13.sp, TextAlign.center),
                      ),
                      SizedBox(
                        width: DimensionConstants.d20.w,
                      ),
                      Text("deepak").regularText(
                          context, DimensionConstants.d13.sp, TextAlign.center),
                      SizedBox(width: DimensionConstants.d15.w),
                      Text("test").semiBoldText(
                          context, DimensionConstants.d13.sp, TextAlign.center),
                      SizedBox(width: DimensionConstants.d11.w),
                      ImageView(
                          path: ImageConstants.forwardArrowIcon,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack))
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5);
          },
        ),

        /*Column(
          children: [
            Container(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.colorWhite),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  projectsHoursRow(
                      ImageConstants.mapIcon, "${provider.crewResponse!.activeProjects} ${"projects".tr()}"),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(
                      ImageConstants.clockIcon, "07.28 ${"hours".tr()}")
                ],
              ),
            ),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRow(Color(0xFFBB6BD9), "MS", "8:50a", "10:47a", "02:57h", commonStepper()),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRow(ColorConstants.primaryGradient1Color, "MS", "8:50a",
                "10:47p", "02:57h", commonStepper()),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRow(ColorConstants.deepBlue, "AL", "8:50a", "10:47p",
                "02:57h", stepperLineWithOneCoolIcon()),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
          ],
        ),*/
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
                          provider.previousWeekDates();
                          provider.weeklyDataApi(context);
                        }),
                        Text("${GetTime.getDayMonth(provider.initialDay2)} -${GetTime.getDayMonth(provider.initialDay1)}")
                            .boldText(context, DimensionConstants.d16.sp,
                                TextAlign.center,
                                color: ColorConstants.colorWhite),
                        backNextBtn(ImageConstants.nextIconIos, () {
                          provider.nextWeekDates();
                          provider.weeklyDataApi(context);
                        })
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
                              projectsHoursRow(ImageConstants.mapIcon,
                                  "${provider.crewResponse!.projects} ${"projects".tr()}"),
                              Container(
                                height: DimensionConstants.d70.h,
                                width: DimensionConstants.d1.w,
                                color: ColorConstants.colorLightGrey,
                              ),
                              projectsHoursRow(ImageConstants.clockIcon,
                                  "07:28 ${"hours".tr()}")
                            ],
                          ),
                        ),
                        weeklyTabBarDateContainer("Tue, April 13"),
                        projectHourRow(
                            Color(0xFFBB6BD9),
                            "MS",
                            "8:50a",
                            "10:47a",
                            "02:57h",
                            stepperLineWithTwoCoolIcon(), onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstants.timeSheetsScreen);
                        }),
                        const Divider(
                            color: ColorConstants.colorGreyDrawer,
                            height: 0.0,
                            thickness: 1.5),
                        projectHourRow(
                            ColorConstants.primaryGradient1Color,
                            "MD",
                            "8:50a",
                            "10:47p",
                            "02:57h",
                            stepperWithGrayAndGreen(), onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstants.timeSheetsScreen);
                        }),
                        weeklyTabBarDateContainer("Wed, April 14"),
                        projectHourRow(Color(0xFFBB6BD9), "MS", "8:50a",
                            "10:47p", "02:57h", commonStepper(), onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstants.timeSheetsScreen);
                        }),
                        const Divider(
                            color: ColorConstants.colorGreyDrawer,
                            height: 0.0,
                            thickness: 1.5),
                        projectHourRow(
                            ColorConstants.primaryGradient1Color,
                            "MD",
                            "8:50a",
                            "10:47p",
                            "02:57h",
                            commonStepper(), onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstants.timeSheetsScreen);
                        }),
                        projectHourRow(
                            Color(0xFFBB6BD9),
                            "MS",
                            "8:50a",
                            "10:47p",
                            "02:57h",
                            stepperLineWithOneCoolIcon(), onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstants.timeSheetsScreen);
                        }),
                        const Divider(
                            color: ColorConstants.colorGreyDrawer,
                            height: 0.0,
                            thickness: 1.5),
                        projectHourRow(
                            ColorConstants.primaryGradient1Color,
                            "MD",
                            "8:50a",
                            "10:47p",
                            "02:57h",
                            commonStepper(), onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstants.timeSheetsScreen);
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
                                  Text("x \$20.00/hr").semiBoldText(
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
                        SizedBox(height: DimensionConstants.d16.h),
                        exportTimeSheetBtn(),
                        SizedBox(height: DimensionConstants.d16.h),
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

  Widget weeklyTabBarDateContainer(String date) {
    return Container(
      color: ColorConstants.colorLightGreyF2,
      height: DimensionConstants.d32.h,
      alignment: Alignment.center,
      child: Text(date).boldText(
          context, DimensionConstants.d13.sp, TextAlign.center,
          color: ColorConstants.colorBlack),
    );
  }

  Widget projectHourRow(Color color, String name, String startingTime,
      String endTime, String totalTime, Widget stepper,
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

  Widget projectHourRowManager(Color color, String name, String startingTime,
      String endTime, String totalTime, Widget stepper,
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
              Text(startingTime).boldText(
                  context, DimensionConstants.d13.sp, TextAlign.center),
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

  Widget exportTimeSheetBtn() {
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
}
