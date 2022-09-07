import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/check_box_model_crew.dart';
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
import '../../locator.dart';
import '../../provider/bottom_bar_provider.dart';
import '../../provider/dashboard_provider.dart';
import '../../widget/custom_tab_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    final bottomBarProvider = Provider.of<BottomBarProvider>(context, listen: false);
    return BaseView<DashboardProvider>(
        onModelReady: (provider) {
          this.provider = provider;
          provider.dashBoardApi(context);
          SharedPreference.prefs!.setInt(SharedPreference.IS_CHECK_IN, 1);
    }, builder: (context, provider, _) {
      return Scaffold(
          key: _scaffoldKey,
          body: provider.state == ViewState.idle? Column(
            children: [
              provider.crewResponse!.myProject!.isEmpty? noProjectNotCheckedInContainer(context, "you_have_no_projects".tr(),false): SharedPreference.prefs!.getInt(SharedPreference.IS_CHECK_IN) == 2 ? projectsCheckOutContainer(SharedPreference.prefs!.getString(SharedPreference.CHECKED_PROJECT)!,provider): noProjectNotCheckedInContainer(context, "you_are_not_checked_in".tr(),true, onTap: () {checkInAlert(context,provider);}),
              provider.crewResponse!.myProject!.isEmpty? whenDoNotHaveProject()  : CustomTabBar(notCheckedIn: provider.notCheckedIn, navigationValue: SharedPreference.prefs!.getInt(SharedPreference.IS_CHECK_IN)!,),
              SizedBox(height: DimensionConstants.d20.h),
            ],
          ):Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,),));

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
  Widget drawerHeadingsRow(BuildContext context, String iconPath, String heading, {bool active = false, Color? color, required VoidCallback onTapButton}) {
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
  Widget noProjectNotCheckedInContainer(BuildContext context, String txt,bool checkInButton, {VoidCallback? onTap}) {
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
                    Text("Hey ""${provider.crewResponse!.user!.name},").boldText(
                    context, DimensionConstants.d18.sp, TextAlign.left,
                    color: ColorConstants.colorWhite),
                    Text("hey_john".tr()).boldText(
                        context, DimensionConstants.d18.sp, TextAlign.left,
                        color: ColorConstants.colorWhite),
                  ],
                )
              ),
            checkInButton == true?  checkInCheckOutBtn(
                "check_in".tr(),
                ColorConstants.colorWhite,
                onBtnTap: () {
                  checkInAlert(context,provider);
                 provider.notifyListeners();
                },
              ):Container()
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
  Widget noProjectCheckedInLocationContainer(BuildContext context, String txt, {bool forwardIcon = false}) {return Container(
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
            Text(txt).boldText(context, DimensionConstants.d16.sp, TextAlign.left,
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
    );}
  Widget checkInCheckOutBtn(String btnText, Color color, {VoidCallback? onBtnTap}) {
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
                      stillCheckedInAlert();
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
  Widget projectsCheckOutContainer(String location,DashboardProvider provider) {
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
                  Text("${"checked_in".tr()} ${provider.timerHour}h ${provider.minuteCount}m").regularText(
                      context, DimensionConstants.d16.sp, TextAlign.left,
                      color: ColorConstants.colorLightGreen),
                ],
              ),
              checkInCheckOutBtn(
                "check_out".tr(),
                ColorConstants.colorLightGreen,
                onBtnTap: () {
                  stillCheckedInAlert();
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
                lastCheckInTotalHoursColumn("${provider.hour <= 9 ? 0 :""}${provider.hour}:${provider.minutes <= 9? 0 : ""}${provider.minutes}", "${provider.getAmAndPm(provider.hour!)}", "last_check_in".tr()),
                lastCheckInTotalHoursColumn("08:23", "HR", "total_hours".tr()),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget lastCheckInTotalHoursColumn(String time, String timeFormat, String txt) {
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
  checkInAlert(BuildContext context , DashboardProvider provider) {
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
          content: Builder(builder: (context) {
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
                      borderRadius: BorderRadius.all(Radius.circular(DimensionConstants.d8.r)
                         ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        isExpanded: true,

                        items: provider.checkInItems.toSet().map(( CheckBoxModelCrew item) => DropdownMenuItem<String>(
                                  value: item.projectName,
                                  onTap: (){
                                    provider.assignProjectId = item.projectId!;
                                    SharedPreference.prefs!.setString(SharedPreference.CHECKED_PROJECT, item.projectName!);
                                  },
                                  child: Column(
                                    children: [
                                     // SizedBox(height: DimensionConstants.d10.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: DimensionConstants.d8.w),
                                        child: Row(
                                          children: [
                                            const ImageView(
                                                path:
                                                    ImageConstants.locationIcon),
                                            SizedBox(
                                                width: DimensionConstants.d8.w),
                                            Text(item.projectName!).regularText(
                                                context,
                                                DimensionConstants.d14.sp,
                                                TextAlign.center)
                                          ],
                                        ),
                                      ),
                                    //  SizedBox(height: DimensionConstants.d10.h),
                                      /*const Divider(
                                          color: ColorConstants.colorGreyDrawer,
                                          thickness: 1.5,
                                          height: 0.0)*/
                                    ],
                                  ),
                                ))
                            .toList(),
                        value: provider.checkIn,
                        onSaved: (String? value) {
                         provider.updateDropDownValueOfCheckBox(value!);
                         provider.updateLoadingStatus(true);
                        },
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
                              const ImageView(path: ImageConstants.downArrowIcon),
                              SizedBox(width: DimensionConstants.d4.w),
                            ],
                          ),
                        ), onChanged: (String? value) {  },
                      ),

                    ),
                  ),
                  SizedBox(height: DimensionConstants.d14.h),
                  CommonWidgets.commonButton(context, "check_in".tr(),
                      height: DimensionConstants.d50.h, onBtnTap: () {
                    Navigator.pop(context);
                    provider.getCheckInTime();
                    provider.checkInApi(context);
                  })
                ],
              ),
            );
          }),
        );
      },
    );
  }
  stillCheckedInAlert() {
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
                      Text("are_you_still_checked_in".tr()).boldText(
                          context, DimensionConstants.d18.sp, TextAlign.center),
                      SizedBox(height: DimensionConstants.d24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ImageView(path: ImageConstants.checkedInIcon),
                          SizedBox(width: DimensionConstants.d8.w),
                          Text("${"checked_in".tr()} 3h 31m").semiBoldText(
                              context,
                              DimensionConstants.d14.sp,
                              TextAlign.left),
                        ],
                      ),
                      SizedBox(height: DimensionConstants.d8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ImageView(path: ImageConstants.locationIcon),
                          SizedBox(width: DimensionConstants.d8.w),
                          Text("Momentum Smart House Project").semiBoldText(
                              context,
                              DimensionConstants.d14.sp,
                              TextAlign.left),
                        ],
                      ),
                      SizedBox(height: DimensionConstants.d44.h),
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
                                  whenDidYouCheckOutAlert();
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
  whenDidYouCheckOutAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.fromLTRB(DimensionConstants.d16.w, 0.0,
                  DimensionConstants.d16.w, DimensionConstants.d75.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
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
                            child:
                                ImageView(path: ImageConstants.smallBackIcon)),
                      ),
                      SizedBox(height: DimensionConstants.d9.h),
                      Text("when_did_you_check_out".tr()).boldText(
                          context, DimensionConstants.d18.sp, TextAlign.center),
                      SizedBox(height: DimensionConstants.d13.h),
                      Container(
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
                            Text("5:50 PM").boldText(context,
                                DimensionConstants.d16.sp, TextAlign.left,
                                color: ColorConstants.colorBlack),
                            SizedBox(width: DimensionConstants.d22.w),
                            const ImageView(
                                path: ImageConstants.downArrowIcon,
                                color: ColorConstants.colorBlack),
                            SizedBox(width: DimensionConstants.d14.w),
                          ],
                        ),
                      ),
                      SizedBox(height: DimensionConstants.d12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ImageView(path: ImageConstants.locationIcon),
                          SizedBox(width: DimensionConstants.d8.w),
                          Text("Momentum Smart House Project").semiBoldText(
                              context,
                              DimensionConstants.d14.sp,
                              TextAlign.left),
                        ],
                      ),
                      SizedBox(height: DimensionConstants.d22.h),
                      CommonWidgets.commonButton(context, "check_out".tr(),
                          height: 50, onBtnTap: () {
                        Navigator.of(context).pop();
                        provider.hasCheckInCheckOut = true;
                        provider.updateLoadingStatus(true);
                      })
                    ],
                  ),
                );
              }));
        });
  }
}
