import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/app_state_provider.dart';
import 'package:beehive/provider/dashboard_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:beehive/widget/custom_tab_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> with TickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   DashboardProvider provider = locator<DashboardProvider>();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<AppStateNotifier>(context);
    return BaseView<DashboardProvider>(
      onModelReady: (provider){
        this.provider = provider;
      },
        builder: (context, provider, _){
      return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context),
        body: provider.checkedInNoProjects ? Column(
          children: [
           provider.hasProjects ? (provider.has2Projects ? noProjectNotCheckedInContainer(context, "you_are_not_checked_in".tr(), onTap: (){
             checkInAlert();
           }) :
           projectsCheckInCheckoutContainer("Momentum Smart House Project")) : noProjectNotCheckedInContainer(context, "you_are_not_checked_in".tr()),
            CustomTabBar(),
            SizedBox(height: DimensionConstants.d20.h),
          ],
        ) : SingleChildScrollView(
          child: Column(
             children: [
             noProjectNotCheckedInContainer(context, "you_have_no_projects".tr()),
               SizedBox(height: DimensionConstants.d61.h),
               GestureDetector(
                   onTap: (){
                     provider.checkedInNoProjects = true;
                     provider.updateLoadingStatus(true);
                   },
                   child: const ImageView(path: ImageConstants.noProject,)),
               SizedBox(height: DimensionConstants.d17.h),
               Text("you_have_no_projects".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.center),
               SizedBox(
                 width: DimensionConstants.d207.w,
                 child: Text("to_join_a_project".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
               ),
               SizedBox(height: DimensionConstants.d47.h),
               Text("in_the_meantime_update_your_project".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
               SizedBox(height: DimensionConstants.d13.h),
               Padding(
                 padding: EdgeInsets.only(left: DimensionConstants.d20.w , right: DimensionConstants.d25.w),
                 child: CommonWidgets.commonButton(context, "update_my_profile".tr(), height: DimensionConstants.d50.h),
               ),
               SizedBox(height: DimensionConstants.d35.h),
               createYourOwnProjectCard(context),
               SizedBox(height: DimensionConstants.d20.h),
             ],
           ),
        ),
      );
    });
  }

  Widget drawer(BuildContext context) {
    return Drawer(
        width: DimensionConstants.d314.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: DimensionConstants.d300.h,
                color: ColorConstants.deepBlue,
                child: Stack(
                  children: [
                    SizedBox(
                        width: DimensionConstants.d314.w,
                        child: const ImageView(path: ImageConstants.maskIcon)),
                    Positioned(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: DimensionConstants.d56.h),
                          child:
                              const ImageView(path: ImageConstants.drawerProfile),
                        ),
                        // SizedBox(height: DimensionConstants.d19.h),
                       Padding(
                         padding: EdgeInsets.only(left: DimensionConstants.d43.w),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("welcome".tr()).semiBoldText(context, DimensionConstants.d20.sp,
                                 TextAlign.center, color: ColorConstants.colorWhite),
                             // SizedBox(height: DimensionConstants.d3.h),
                             Text("John Smith").boldText(context,
                                 DimensionConstants.d30.sp, TextAlign.center, color: ColorConstants.colorWhite),
                           ],
                         ),
                       )
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(height: DimensionConstants.d41.h),
              drawerHeadingsRow(context, ImageConstants.dashboardIcon, "dashboard".tr(), active: true),
              SizedBox(height: DimensionConstants.d36.h),
              drawerHeadingsRow(context, ImageConstants.timeSheetsIcon, "time_sheets".tr()),
              SizedBox(height: DimensionConstants.d33.h),
              drawerHeadingsRow(context, ImageConstants.calendarIcon, "schedule".tr()),
              SizedBox(height: DimensionConstants.d33.h),
              drawerHeadingsRow(context, ImageConstants.openFolderIcon, "archived_projects".tr(), onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, RouteConstants.archivedProjectsScreen);
              }),
              SizedBox(height: DimensionConstants.d30.h),
              const Divider(color: ColorConstants.colorGreyDrawer, thickness: 1.5, height: 0.0,),
              SizedBox(height: DimensionConstants.d30.h),
              drawerHeadingsRow(context, ImageConstants.settingsIcon, "app_settings".tr(), onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, RouteConstants.appSettings);
              }),
              SizedBox(height: DimensionConstants.d37.h),
              drawerHeadingsRow(context, ImageConstants.profileIcon, "my_account".tr()),
              SizedBox(height: DimensionConstants.d34.h),
              drawerHeadingsRow(context, ImageConstants.logoutIcon, "logout".tr()),
              SizedBox(height: DimensionConstants.d19.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d34.w),
                child: CommonWidgets.commonButton(context, "upgrade_to_crew_manager".tr(), height: DimensionConstants.d50.h, color1: ColorConstants.blueGradient2Color,
                color2: ColorConstants.blueGradient1Color, fontSize: DimensionConstants.d14.sp),
              ),
              SizedBox(height: DimensionConstants.d20.h),
            ],
          ),
        ));
  }

  Widget drawerHeadingsRow(BuildContext context, String iconPath, String heading, {bool active = false, Color? color, VoidCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: DimensionConstants.d38.w),
        child: Row(
          children: [
            ImageView(path: iconPath, color: active ? ColorConstants.primaryColor : (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack)),
            SizedBox(width: DimensionConstants.d16.w),
            !active ? Text(heading).regularText(context, DimensionConstants.d16.sp, TextAlign.left) :
            Text(heading).boldText(context, DimensionConstants.d16.sp, TextAlign.left)
          ],
        ),
      ),
    );
  }

  Widget noProjectNotCheckedInContainer(BuildContext context, String txt, {VoidCallback? onTap}){
    return Container(
      width: double.infinity,
      color: ColorConstants.deepBlue,
      height: DimensionConstants.d147.h,
      padding: EdgeInsets.fromLTRB(DimensionConstants.d20.w, DimensionConstants.d18.w, DimensionConstants.d20.w, DimensionConstants.d23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        provider.checkedInNoProjects ?  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("hey_john".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.left, color: ColorConstants.colorWhite),
              checkInCheckOutBtn("check_in".tr(), ColorConstants.colorWhite, onBtnTap: (){
                provider.isCheckedIn = true;
                provider.notifyListeners();
              },)
            ],
          ) :  Text("hey_john".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.left, color: ColorConstants.colorWhite),
          SizedBox(height: DimensionConstants.d12.h),
          GestureDetector(
              onTap: onTap,
              child: noProjectCheckedInLocationContainer(context, txt))
        ],
      ),
    );
  }

  Widget noProjectCheckedInLocationContainer(BuildContext context, String txt, {bool forwardIcon = false}){
    return Container(
      alignment: Alignment.centerLeft,
      height: DimensionConstants.d48.h,
      decoration: BoxDecoration(
        color: ColorConstants.colorWhite10,
          border: Border.all(
            color: ColorConstants.colorWhite30, width: 1
          ),
          borderRadius: BorderRadius.all(Radius.circular(DimensionConstants.d8.r))
      ),
      child: Row(
        children: [
          SizedBox(width: DimensionConstants.d14.w),
          const ImageView(path: ImageConstants.locationIcon),
          SizedBox(width: DimensionConstants.d11.w),
          Text(txt).boldText(context, DimensionConstants.d16.sp, TextAlign.left, color: ColorConstants.colorWhite),
          SizedBox(width: DimensionConstants.d30.w),
          forwardIcon ? ImageView(path: ImageConstants.forwardArrowIcon, color: ColorConstants.colorWhite, height: DimensionConstants.d10.h, width: DimensionConstants.d5.w,) : Container()
        ],
      ),
    );
  }

  Widget checkInCheckOutBtn(String btnText, Color color, {VoidCallback? onBtnTap}){
    return GestureDetector(
      onTap: onBtnTap,
      child: Container(
        alignment: Alignment.center,
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d91.w,
        decoration: BoxDecoration(
          border:  Border.all(
           color: color
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(DimensionConstants.d8.r),
          ),
        ),
        child:  Text(btnText).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center, color: color),
      ),
    );
  }

  Widget projectsCheckInCheckoutContainer(String location){
    return Container(
      width: double.infinity,
      color: ColorConstants.deepBlue,
      height: DimensionConstants.d194.h,
      padding: EdgeInsets.fromLTRB(DimensionConstants.d20.w, DimensionConstants.d13.w, DimensionConstants.d20.w, DimensionConstants.d17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        provider.isCheckedIn ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const ImageView(path: ImageConstants.checkedInIcon),
                SizedBox(width: DimensionConstants.d12.w),
                Text("${"checked_in".tr()} 3h 31m").regularText(context, DimensionConstants.d16.sp, TextAlign.left, color: ColorConstants.colorLightGreen),
              ],
            ),
            checkInCheckOutBtn("check_out".tr(), ColorConstants.colorLightGreen, onBtnTap: (){
            },)
          ],
        ) :  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const ImageView(path: ImageConstants.checkoutIcon),
                  SizedBox(width: DimensionConstants.d12.w),
                  Text("checked_out".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.left, color: ColorConstants.colorWhite),
                ],
              ),
              checkInCheckOutBtn("check_in".tr(), ColorConstants.colorWhite, onBtnTap: (){
                provider.isCheckedIn = true;
                provider.notifyListeners();
              },)
            ],
          ),
          SizedBox(height: DimensionConstants.d12.h),
          noProjectCheckedInLocationContainer(context, location, forwardIcon: true),
          SizedBox(height: DimensionConstants.d16.h),
          Padding(
            padding: EdgeInsets.fromLTRB(DimensionConstants.d20.w, 0.0, DimensionConstants.d20.w, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap : (){
                      stillCheckedInAlert();
                    },
                    child: lastCheckInTotalHoursColumn("12:50", "PM", "last_check_in".tr())),
                lastCheckInTotalHoursColumn("08:23", "HR", "total_hours".tr()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget lastCheckInTotalHoursColumn(String time, String timeFormat, String txt){
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(time).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.left, color: ColorConstants.colorWhite),
            SizedBox(width: DimensionConstants.d3.w),
            Text(timeFormat).regularText(context, DimensionConstants.d14.sp, TextAlign.left, color: ColorConstants.colorWhite),
          ],
        ),
        SizedBox(height: DimensionConstants.d5.h),
        Text(txt).regularText(context, DimensionConstants.d14.sp, TextAlign.left, color: ColorConstants.colorWhite),
      ],
    );
  }

  Widget createYourOwnProjectCard(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        side: const BorderSide(color: ColorConstants.colorWhite90, width: 1.5),
      ),
      margin: EdgeInsets.only(left: DimensionConstants.d18.w , right: DimensionConstants.d19.w),
      child: Column(
        children: [
          SizedBox(height: DimensionConstants.d20.h),
          Text("create_your_own_projects".tr()).boldText(context, DimensionConstants.d16.sp, TextAlign.center),
          SizedBox(height: DimensionConstants.d6.h),
          SizedBox(
            width: DimensionConstants.d294.w,
            child: Text("crew_managers_create_projects".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
          ),
          SizedBox(height: DimensionConstants.d7.h),
          Padding(
            padding: EdgeInsets.only(left: DimensionConstants.d14.w, right: DimensionConstants.d18.w),
            child: CommonWidgets.commonButton(context, "upgrade_to_crew_manager".tr(), height: DimensionConstants.d50.h, color1: ColorConstants.blueGradient2Color,
                color2: ColorConstants.blueGradient1Color, fontSize: DimensionConstants.d14.sp),
          ),
          SizedBox(height: DimensionConstants.d20.h),
        ],
      ),
    );
  }


  /// Dashboard Alerts ~~~~~~~~~~~~~~~~~~~~~~~~
   checkInAlert(){
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           contentPadding: EdgeInsets.zero,
        //   contentPadding: EdgeInsets.symmetric(vertical: DimensionConstants.d24.h, horizontal: DimensionConstants.d24.w),
           insetPadding: EdgeInsets.fromLTRB(DimensionConstants.d16.w, 0.0, DimensionConstants.d16.w, 0.0),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
           ),
           elevation: 0,
           content : Builder(
               builder: (context)
               {
                 return  Container(
                   padding: EdgeInsets.symmetric(vertical: DimensionConstants.d24.h, horizontal: DimensionConstants.d24.w),
                   height: DimensionConstants.d220.h,
                   width: DimensionConstants.d343.w,
                   child: Column(
                     children: [
                       GestureDetector(
                         onTap: (){
                           Navigator.of(context).pop();
                         },
                         child: Align(
                             alignment: Alignment.centerRight,
                             child: ImageView(path: ImageConstants.closeIcon, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),)),
                       ),
                       Text("check_in".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.center),
                       SizedBox(height: DimensionConstants.d23.h),
                       DropdownButtonHideUnderline(
                         child: DropdownButton2(
                           isExpanded: true,
                           hint: Container(
                             alignment: Alignment.centerLeft,
                             height: DimensionConstants.d45.h,
                             decoration: BoxDecoration(
                                 color: ColorConstants.colorLightGreyF2,
                               borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(DimensionConstants.d8.r),
                                   bottomLeft: Radius.circular(DimensionConstants.d8.r)),
                             ),
                             child: Row(
                               children: [
                                 SizedBox(width: DimensionConstants.d12.w),
                                 const ImageView(path: ImageConstants.locationIcon, color: ColorConstants.colorBlack),
                                 SizedBox(width: DimensionConstants.d8.w),
                                 Text("Momentum Smart House Project").semiBoldText(context, DimensionConstants.d14.sp, TextAlign.left, color: ColorConstants.colorBlack),
                                 SizedBox(width: DimensionConstants.d29.w),
                               ],
                             ),
                           ),
                           items: provider.checkInItems
                               .map((item) =>
                               DropdownMenuItem<String>(
                                 value: item,
                                 child:  Column(
                                   children: [
                                     SizedBox(height: DimensionConstants.d10.h),
                                     Padding(
                                       padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d8.w),
                                       child: Row(
                                         children: [
                                           const ImageView(path: ImageConstants.locationIcon),
                                           SizedBox(width: DimensionConstants.d8.w),
                                           Text(item).regularText(context, DimensionConstants.d14.sp, TextAlign.center)
                                         ],
                                       ),
                                     ),
                                     SizedBox(height: DimensionConstants.d10.h),
                                     const Divider(color: ColorConstants.colorGreyDrawer, thickness: 1.5, height: 0.0)
                                   ],
                                 ),
                               ))
                               .toList(),
                           value: provider.checkIn,
                           onChanged: (value) {
                             setState(() {
                               provider.checkIn = value as String;
                             });
                           },
                           icon: Container(
                             height: DimensionConstants.d42.h,
                             decoration: BoxDecoration(
                                 color: ColorConstants.colorLightGreyF2,
                               borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(DimensionConstants.d8.r),
                                   bottomRight: Radius.circular(DimensionConstants.d8.r)),
                             ),
                                            child: Row(
                               children: [
                                 const ImageView(path: ImageConstants.downArrowIcon),
                                 SizedBox(width: DimensionConstants.d4.w),
                               ],
                             ),
                           ),
                           itemPadding: EdgeInsets.zero,
                           dropdownPadding: null,
                           dropdownDecoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                            border: Border.all(color: ColorConstants.colorLightGreyF2, width: 1.0)
                           ),
                           dropdownMaxHeight: DimensionConstants.d142.h,
                           dropdownWidth: DimensionConstants.d293.w,
                           offset: const Offset(0.0, -10),
                         ),
                       ),
                       SizedBox(height: DimensionConstants.d23.h),
                       CommonWidgets.commonButton(context, "check_in".tr(), height: DimensionConstants.d50.h)
                     ],
                   ),
                 );
               }
           ),

         );
       },
     );
  }

  stillCheckedInAlert(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.fromLTRB(DimensionConstants.d16.w, 0.0, DimensionConstants.d16.w, 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
              ),
              elevation: 0,
              content : Builder(
                  builder: (context)
                  {
                    return Container(
                      padding: EdgeInsets.fromLTRB(DimensionConstants.d20.w, DimensionConstants.d33.h, DimensionConstants.d20.w, DimensionConstants.d24.h),
                      height: DimensionConstants.d276.h,
                      width: DimensionConstants.d343.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("are_you_still_checked_in".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.center),
                          SizedBox(height: DimensionConstants.d24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ImageView(path: ImageConstants.checkedInIcon),
                              SizedBox(width: DimensionConstants.d8.w),
                              Text("${"checked_in".tr()} 3h 31m").semiBoldText(context, DimensionConstants.d14.sp, TextAlign.left),
                            ],
                          ),
                          SizedBox(height: DimensionConstants.d8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ImageView(path: ImageConstants.locationIcon),
                              SizedBox(width: DimensionConstants.d8.w),
                              Text("Momentum Smart House Project").semiBoldText(context, DimensionConstants.d14.sp, TextAlign.left),
                            ],
                          ),
                          SizedBox(height: DimensionConstants.d44.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: DimensionConstants.d143.w,
                                    child: CommonWidgets.commonButton(context, "no_check_out".tr(), height: 50, onBtnTap: (){
                                      Navigator.of(context).pop();
                                      whenDidYouCheckOutAlert();
                                    })),
                                SizedBox(width: DimensionConstants.d9.w),
                                SizedBox(
                                    width: DimensionConstants.d143.w,
                                    child: CommonWidgets.commonButton(context, "i_am_still_here".tr(), color1: ColorConstants.deepBlue, color2: ColorConstants.deepBlue,  height: 50,
                                        onBtnTap: (){
                                          Navigator.of(context).pop();
                                        })),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
        }
    );
  }

  whenDidYouCheckOutAlert(){
    showDialog(
        context: context,
        builder: (BuildContext context)
    {
      return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.fromLTRB(
              DimensionConstants.d16.w, 0.0, DimensionConstants.d16.w, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          elevation: 0,
          content: Builder(
              builder: (context) {
                return Container(
                  padding: EdgeInsets.fromLTRB(
                      DimensionConstants.d24.w, DimensionConstants.d24.h,
                      DimensionConstants.d24.w, DimensionConstants.d24.h),
                  height: DimensionConstants.d276.h,
                  width: DimensionConstants.d343.w,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                          child: ImageView(path: ImageConstants.smallBackIcon)),
                    ),
                    SizedBox(height: DimensionConstants.d9.h),
                    Text("when_did_you_check_out".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.center),
                    SizedBox(height: DimensionConstants.d13.h),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: DimensionConstants.d45.h,
                      width: DimensionConstants.d171.w,
                      decoration: BoxDecoration(
                        color: ColorConstants.colorLightGreyF2,
                          borderRadius: BorderRadius.all(Radius.circular(DimensionConstants.d8.r)) ),
                      child: Row(
                        children: [
                          SizedBox(width: DimensionConstants.d16.w),
                          const ImageView(path: ImageConstants.clockIcon, color: ColorConstants.colorBlack),
                          SizedBox(width: DimensionConstants.d16.w),
                          Text("5:50 PM").boldText(context, DimensionConstants.d16.sp, TextAlign.left, color: ColorConstants.colorBlack),
                          SizedBox(width: DimensionConstants.d27.w),
                          const ImageView(path: ImageConstants.downArrowIcon, color: ColorConstants.colorBlack),
                          SizedBox(width: DimensionConstants.d14.w),
                        ],
                      ),
                    ),
                    SizedBox(height: DimensionConstants.d16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageView(path: ImageConstants.locationIcon),
                        SizedBox(width: DimensionConstants.d8.w),
                        Text("Momentum Smart House Project").semiBoldText(context, DimensionConstants.d14.sp, TextAlign.left),
                      ],
                    ),
                    SizedBox(height: DimensionConstants.d22.h),
                    CommonWidgets.commonButton(context, "check_out".tr(), height: 50, onBtnTap: (){
                      Navigator.of(context).pop();
                    })
                  ],
                ),);
              }
          ));
    }
    );
  }
}
