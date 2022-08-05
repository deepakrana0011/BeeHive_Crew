import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/app_state_provider.dart';
import 'package:beehive/provider/dashboard_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
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
  void dispose() {
    provider.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(
      onModelReady: (provider){
        this.provider = provider;
        provider.controller = TabController(length: 3, vsync: this);
      },
        builder: (context, provider, _){
      return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              noProjectContainer(context, provider.checkedInNoProjects ? "you_are_not_checked_in".tr() :  "you_have_no_projects".tr()),
             provider.checkedInNoProjects ? tabBarView(provider.controller!) : Column(
                children: [
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
                ],
              ),
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
              drawerHeadingsRow(context, ImageConstants.openFolderIcon, "archived_projects".tr()),
              SizedBox(height: DimensionConstants.d30.h),
              const Divider(color: ColorConstants.colorGreyDrawer, thickness: 1.5, height: 0.0,),
              SizedBox(height: DimensionConstants.d30.h),
              drawerHeadingsRow(context, ImageConstants.settingsIcon, "app_settings".tr()),
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

  Widget drawerHeadingsRow(BuildContext context, String iconPath, String heading, {bool active = false, Color? color}){
    return Padding(
      padding: EdgeInsets.only(left: DimensionConstants.d38.w),
      child: Row(
        children: [
          ImageView(path: iconPath, color: active ? ColorConstants.primaryColor : (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack)),
          SizedBox(width: DimensionConstants.d16.w),
          !active ? Text(heading).regularText(context, DimensionConstants.d16.sp, TextAlign.left) :
          Text(heading).boldText(context, DimensionConstants.d16.sp, TextAlign.left)
        ],
      ),
    );
  }

  Widget noProjectContainer(BuildContext context, String txt){
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
              checkInBtn()
            ],
          ) :  Text("hey_john".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.left, color: ColorConstants.colorWhite),
          SizedBox(height: DimensionConstants.d12.h),
          noProjectCheckedInLocationContainer(context, txt)
        ],
      ),
    );
  }

  Widget noProjectCheckedInLocationContainer(BuildContext context, String txt){
    return Container(
      alignment: Alignment.centerLeft,
      height: DimensionConstants.d49.h,
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
        ],
      ),
    );
  }

  Widget checkInBtn(){
    return Container(
      alignment: Alignment.center,
      height: DimensionConstants.d40.h,
      width: DimensionConstants.d91.w,
      decoration: BoxDecoration(
        border:  Border.all(
         color: ColorConstants.colorWhite
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(DimensionConstants.d8.r),
        ),
      ),
      child:  Text("check_in".tr()).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite),
    );
  }

  Widget createYourOwnProjectCard(BuildContext context){
    return Card(
      color: ColorConstants.colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      margin: EdgeInsets.only(left: DimensionConstants.d18.w , right: DimensionConstants.d19.w),
      child: Column(
        children: [
          SizedBox(height: DimensionConstants.d20.h),
          Text("create_your_own_projects".tr()).boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorBlack),
          SizedBox(height: DimensionConstants.d6.h),
          SizedBox(
            width: DimensionConstants.d294.w,
            child: Text("crew_managers_create_projects".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorBlack),
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

  Widget tabBarView(TabController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        children: [
          SizedBox(height: DimensionConstants.d15.h),
           Card(
             shape: RoundedRectangleBorder(
               side: const BorderSide(color: ColorConstants.colorWhite90, width: 1.5),
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
               ),),
              padding: EdgeInsets.zero,
             controller: controller,
               onTap: (index){
                 if (controller.indexIsChanging) {
                   provider.updateLoadingStatus(true);
                 }
               },
               tabs: [
                 Container(
                   alignment: Alignment.center,
                   height: DimensionConstants.d50.h,
                   width: DimensionConstants.d114.w,
                   child: controller.index == 0 ? Text("today".tr()).boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite)
                       :  Text("today".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center),
                 ),
                 Container(
                   alignment: Alignment.center,
                   height: DimensionConstants.d50.h,
                   width: DimensionConstants.d114.w,
                   child: controller.index == 1 ? Text("weekly".tr()).boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite)
                       :  Text("weekly".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center),
                 ),
                 Container(
                   alignment: Alignment.center,
                   height: DimensionConstants.d50.h,
                   width: DimensionConstants.d114.w,
                   child: controller.index == 2 ? Text("bi_weekly".tr()).boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite)
                       :  Text("bi_weekly".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center),
                 ),
               ],
             ),
           )
        ],
      ),
    );
  }

  Widget zeroProjectZeroHourCard(){
    return Card(
      child: Container(
        height: DimensionConstants.d228.h,

      ),
    );
  }

  Widget projectsHoursRow(){
    return Row(
      children: [

      ],
    );
  }
}
