import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/provider/dashboard_page_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/custom_tab_bar.dart';
import 'package:beehive/widget/custom_tab_bar_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../constants/image_constants.dart';
import '../../locator.dart';
import '../../provider/bottom_bar_Manager_provider.dart';
import '../../provider/bottom_bar_provider.dart';
import '../../widget/image_view.dart';



class DashBoardPageManager extends StatefulWidget {
  const DashBoardPageManager({Key? key}) : super(key: key);

  @override
  _DashBoardPageManagerState createState() => _DashBoardPageManagerState();
}

class _DashBoardPageManagerState extends State<DashBoardPageManager> with TickerProviderStateMixin {

  DashBoardPageManagerProvider provider= locator<DashBoardPageManagerProvider>();

  @override
  Widget build(BuildContext context) {


    return BaseView<DashBoardPageManagerProvider>(
        onModelReady: (provider) {this.provider = provider;provider.dashBoardApi(context,);
       provider.controller = TabController(length: 3, vsync: this);
        },
        builder: (context, provider, _) {
          return provider.state == ViewState.idle?Scaffold(
            body: Column(
              children:<Widget> [
                activeProjectWidget(context,provider),
                tabBarView(provider.controller!, context, provider)
              ],
            )
          ):Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,));
        });
  }
}

Widget activeProjectWidget(BuildContext context, DashBoardPageManagerProvider provider){
  return Container(
    height: DimensionConstants.d151.h,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [ColorConstants.blueGradient1Color,ColorConstants.blueGradient2Color])
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          SizedBox(height: DimensionConstants.d16.h,),
          Text("Hey  ${provider.responseManager!.manager!.name!},\nwhat’s buzzing?").boldText(context, DimensionConstants.d18.sp, TextAlign.left,color: ColorConstants.colorWhite),
          SizedBox(height: DimensionConstants.d10.h,),
          Row(
            children:<Widget> [
              crewAndActiveProject(context,provider.responseManager!.activeProject.toString(),"active_projects"),
              Expanded(child: Container()),
              crewAndActiveProject(context,provider.responseManager!.crewMembers.toString(),"crew_members"),
            ],
          ),

        ],
      ),
    ),
  );
}
Widget crewAndActiveProject(BuildContext context,String number,String tabName){
  return Container(
    height: DimensionConstants.d65.h,
    width: DimensionConstants.d169.w,
    decoration: BoxDecoration(
      color: ColorConstants.deepBlue,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
        Text(number).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center,color: ColorConstants.colorWhite),
        Text(tabName.tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center,color: ColorConstants.colorWhite),
      ],
    ),
  );


}
Widget tabBarView(TabController controller, BuildContext context,DashBoardPageManagerProvider provider) {
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
                if (controller.indexIsChanging) {
                  provider.updateLoadingStatus(true);
                }
              },
              tabs: [
                Container(
                  alignment: Alignment.center,
                  height: DimensionConstants.d50.h,
                  width: DimensionConstants.d114.w,
                  child: controller.index == 0
                      ? Text("today".tr()).boldText(context,
                      DimensionConstants.d16.sp, TextAlign.center,
                      color: ColorConstants.colorWhite)
                      : Text("today".tr()).regularText(context,
                      DimensionConstants.d16.sp, TextAlign.center),
                ),
                Container(
                  alignment: Alignment.center,
                  height: DimensionConstants.d50.h,
                  width: DimensionConstants.d114.w,
                  child: controller.index == 1
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
                  child: controller.index == 2
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
                //  provider.hasProjects ? projectsAndHoursCardList() : zeroProjectZeroHourCard(),
                projectsAndHoursCardListManager(context,provider),
               Container(),
               /* weeklyTabBarContainerManager(context),*/
                Icon(Icons.directions_car, size: 350),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget projectsAndHoursCardListManager(BuildContext context,DashBoardPageManagerProvider provider) {
  return Padding(
    padding: EdgeInsets.only(top: DimensionConstants.d16.h),
    child: Card(
      margin: EdgeInsets.only(bottom: DimensionConstants.d80.h),
      elevation: 2.5,
      color: (Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorBlack
          : ColorConstants.colorWhite),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ColorConstants.grayF1F1F1, width: 1.0),
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: SingleChildScrollView(
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
                  projectsHoursRow(context,ImageConstants.mapIcon, "${provider.responseManager!.activeProject} ${"projects".tr()}"),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(context,ImageConstants.clockIcon, "07.28 ${"hours".tr()}")
                ],
              ),
            ),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRowManager(context,provider,onTap: (){}),

           
           /* const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRowManager(context,ColorConstants.primaryGradient1Color, "MS", "Momentum Digital", "1 Crew", "12:57h", ),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRowManager(context, ColorConstants.deepBlue, "MS", "Momentum Digital", "4 Crew", "12:57h", ),
            const Divider(
                color: ColorConstants.colorGreyDrawer,
                height: 0.0,
                thickness: 1.5),
            projectHourRowManager(context, ColorConstants.deepBlue, "MS", "Momentum Digital", "2 Crew", "12:57h", ),*/



          ],
        ),
      ),
    ),
  );
}



/*Widget weeklyTabBarContainerManager(BuildContext context) {
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
                      backNextBtn(ImageConstants.backIconIos),
                      Text("Apr 13 - Apr 19").boldText(context,
                          DimensionConstants.d16.sp, TextAlign.center,
                          color: ColorConstants.colorWhite),
                      backNextBtn(ImageConstants.nextIconIos)
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
                            projectsHoursRow(context,ImageConstants.mapIcon,
                                "4 ${"projects".tr()}"),
                            Container(
                              height: DimensionConstants.d70.h,
                              width: DimensionConstants.d1.w,
                              color: ColorConstants.colorLightGrey,
                            ),
                            projectsHoursRow(context,ImageConstants.clockIcon,
                                "07:28 ${"hours".tr()}")
                          ],
                        ),
                      ),
                      weeklyTabBarDateContainer(context,"Tue, April 13"),
                      projectHourRowManager(context, Color(0xFFBB6BD9), "MS", "Momentum Digital", "1 Crew", "12:57h",  onTap: () {
                        // Navigator.pushNamed(
                        //     context, RouteConstants.timeSheetsScreen);
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      projectHourRowManager(context, ColorConstants.primaryGradient1Color, "MD", "Momentum Digital", "1 Crew", "02:57h",  onTap: () {
                        // Navigator.pushNamed(
                        //     context, RouteConstants.timeSheetsScreen);
                      }),
                      weeklyTabBarDateContainer(context,"Wed, April 14"),
                      projectHourRowManager(context, Color(0xFFBB6BD9), "MS", "Momentum Digital", "1 Crew", "12:57h",  onTap: () {
                        // Navigator.pushNamed(
                        //     context, RouteConstants.timeSheetsScreen);
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      projectHourRowManager(context, ColorConstants.primaryGradient1Color, "MD", "Momentum Digital", "2 Crew", "12:57h",  onTap: () {
                        // Navigator.pushNamed(
                        //     context, RouteConstants.timeSheetsScreen);
                      }),
                      projectHourRowManager(context,Color(0xFFBB6BD9), "MS", "Momentum Digital", "1 Crew", "12:57h",  onTap: () {
                        // Navigator.pushNamed(
                        //     context, RouteConstants.timeSheetsScreen);
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      projectHourRowManager(context, ColorConstants.primaryGradient1Color, "MD", "Momentum Digital", "1 Crew", "12:57h",  onTap: () {
                        // Navigator.pushNamed(
                        //     context, RouteConstants.timeSheetsScreen);
                      }),
                      const Divider(
                          color: ColorConstants.colorGreyDrawer,
                          height: 0.0,
                          thickness: 1.5),
                      // SizedBox(height: DimensionConstants.d60.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: DimensionConstants.d70.h,),
      ],
    ),
  );
}*/
Widget projectsHoursRow(BuildContext context,String iconPath, String txt) {
  return Row(
    children: [
      ImageView(path: iconPath),
      SizedBox(width: DimensionConstants.d9.w),
      Text(txt).boldText(context, DimensionConstants.d18.sp, TextAlign.center)
    ],
  );
}
Widget projectHourRowManager(BuildContext context, DashBoardPageManagerProvider provider,  {VoidCallback? onTap}) {
  return Container(
    height: DimensionConstants.d240.h,
    width: DimensionConstants.d400.w,
    child: ListView.separated(
      itemCount: provider.responseManager!.crewOnProject!.length,
      itemBuilder: (BuildContext context, int index){
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.blueGradient2Color,
                    ),
                    child: Text(provider.projectNameInitials[index].toString()).boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite),
                  ),
                  SizedBox(width: DimensionConstants.d14.w),
                  Container(
                    width: DimensionConstants.d120.w,
                    child:  Text(provider.responseManager!.crewOnProject![index].projectId!.projectName!).boldText(context, DimensionConstants.d13.sp, TextAlign.center),
                  ),
                  SizedBox(width: DimensionConstants.d24.w,),
                  Text("${provider.responseManager!.crewOnProject![index].crewId!.length} Crew").regularText(context, DimensionConstants.d13.sp, TextAlign.center),
                  SizedBox(width: DimensionConstants.d15.w),
                  Text("12:57h").semiBoldText(context, DimensionConstants.d13.sp, TextAlign.center),
                  SizedBox(width: DimensionConstants.d11.w),
                  ImageView(path: ImageConstants.forwardArrowIcon, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack))
                ],
              ),
            ),
          ),
        );


      }, separatorBuilder: (BuildContext context, int index) { return const Divider(
        color: ColorConstants.colorGreyDrawer,
        height: 0.0,
        thickness: 1.5); },

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
Widget weeklyTabBarDateContainer(BuildContext context,String date) {
  return Container(
    color: ColorConstants.colorLightGreyF2,
    height: DimensionConstants.d32.h,
    alignment: Alignment.center,
    child: Text(date).boldText(
        context, DimensionConstants.d13.sp, TextAlign.center,
        color: ColorConstants.colorBlack),
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