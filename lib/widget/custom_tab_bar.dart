import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with TickerProviderStateMixin{
  TabController? controller;
  BaseProvider provider = locator<BaseProvider>();

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BaseProvider>(
        onModelReady: (provider){
          this.provider = provider;
          controller = TabController(length: 3, vsync: this);
        },
        builder: (context, provider, _){
          return tabBarView(controller!);
        },
    );
  }
  Widget tabBarView(TabController controller) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                //  provider.hasProjects ? projectsAndHoursCardList() : zeroProjectZeroHourCard(),
                  projectsAndHoursCardList(),
                  weeklyTabBarContainer(),
                  Icon(Icons.directions_car, size: 350),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget zeroProjectZeroHourCard(){
    return Container(
      margin: EdgeInsets.only(top: DimensionConstants.d16.h),
      child: Card(
        color: ColorConstants.colorLightGrey,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorConstants.colorLightGrey, width: 1.0),
          borderRadius: BorderRadius.circular(DimensionConstants.d12.r),
        ),
        child: Column(
          children: [
            Container(
              color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorBlack : ColorConstants.colorWhite),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap : (){
                     //   provider.has2Projects = true;
                        provider.updateLoadingStatus(true);
                      },
                      child: projectsHoursRow(ImageConstants.mapIcon, "0 ${"projects".tr()}")),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(ImageConstants.clockIcon, "0 ${"hours".tr()}")
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: DimensionConstants.d30.h),
                  GestureDetector(
                      onTap: (){
                     //   provider.hasProjects = true;
                        provider.updateLoadingStatus(true);
                      },
                      child: const ImageView(path: ImageConstants.noProject,)),
                  SizedBox(height: DimensionConstants.d17.h),
                  Text("You_have_not_checked_in_today".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorBlack)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget projectsHoursRow(String iconPath, String txt){
    return Row(
      children: [
        ImageView(path: iconPath),
        SizedBox(width: DimensionConstants.d9.w),
        Text(txt).boldText(context, DimensionConstants.d18.sp, TextAlign.center)
      ],
    );
  }

  /// Today Tab bar Ui~~~~~~~~~~~~~~~~~~~~~
  Widget projectsAndHoursCardList(){
    return Padding(
      padding: EdgeInsets.only(top: DimensionConstants.d16.h),
      child: Card(
        elevation: 2.5,
        color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorBlack : ColorConstants.colorWhite),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorConstants.colorWhite, width: 1.0),
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Column(
          children: [
            Container(
              color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorBlack : ColorConstants.colorWhite),
              height: DimensionConstants.d70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  projectsHoursRow(ImageConstants.mapIcon, "4 ${"projects".tr()}"),
                  Container(
                    height: DimensionConstants.d70.h,
                    width: DimensionConstants.d1.w,
                    color: ColorConstants.colorLightGrey,
                  ),
                  projectsHoursRow(ImageConstants.clockIcon, "07:28 ${"hours".tr()}")
                ],
              ),
            ),
            const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
            projectHourRow(Color(0xFFBB6BD9), "MS", "8:50a", "10:47a", "02:57a",commonStepper()),
            const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
            projectHourRow(ColorConstants.primaryGradient1Color, "MS", "8:50a", "10:47a", "02:57a", commonStepper()),
            const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
            projectHourRow(ColorConstants.deepBlue, "AL", "8:50a", "10:47a", "02:57a", stepperLineWithOneCoolIcon()),
            const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
          ],
        ),
      ),
    );
  }
  /// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  /// Weekly Tab Bar UI!!!!!!!!!!!!!!!!!!!!!!!!!
  ///

  Widget weeklyTabBarContainer(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: DimensionConstants.d15.h),
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.deepBlue,
              borderRadius: BorderRadius.all(Radius.circular(DimensionConstants.d8.r)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(DimensionConstants.d16.w, DimensionConstants.d17.h, DimensionConstants.d16.w, DimensionConstants.d15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        backNextBtn(ImageConstants.backIconIos),
                        Text("Apr13 - Apr19").boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite),
                        backNextBtn(ImageConstants.nextIconIos)
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorBlack : ColorConstants.colorWhite),
                      border: Border.all(
                        color: ColorConstants.colorLightGreyF2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(DimensionConstants.d8.r)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorBlack : ColorConstants.colorWhite),
                            border: Border.all(
                              color: ColorConstants.colorLightGreyF2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(DimensionConstants.d8.r)),
                          ),
                          height: DimensionConstants.d70.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              projectsHoursRow(ImageConstants.mapIcon, "4 ${"projects".tr()}"),
                              Container(
                                height: DimensionConstants.d70.h,
                                width: DimensionConstants.d1.w,
                                color: ColorConstants.colorLightGrey,
                              ),
                              projectsHoursRow(ImageConstants.clockIcon, "07:28 ${"hours".tr()}")
                            ],
                          ),
                        ),
                        weeklyTabBarDateContainer("Tue, April 13"),
                        projectHourRow(Color(0xFFBB6BD9), "MS", "8:50a", "10:47a", "02:57a", stepperLineWithTwoCoolIcon(), onTap: (){
                          Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
                        }),
                        const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
                        projectHourRow(ColorConstants.primaryGradient1Color, "MD", "8:50a", "10:47a", "02:57a", stepperWithGrayAndGreen(), onTap: (){
                          Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
                        }),
                        weeklyTabBarDateContainer("Wed, April 14"),
                        projectHourRow(Color(0xFFBB6BD9), "MS", "8:50a", "10:47a", "02:57a", commonStepper(), onTap: (){
                          Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
                        }),
                        const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
                        projectHourRow(ColorConstants.primaryGradient1Color, "MD", "8:50a", "10:47a", "02:57a", commonStepper(), onTap: (){
                          Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
                        }),
                        projectHourRow(Color(0xFFBB6BD9), "MS", "8:50a", "10:47a", "02:57a", stepperLineWithOneCoolIcon(), onTap: (){
                          Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
                        }),
                        const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
                        projectHourRow(ColorConstants.primaryGradient1Color, "MD", "8:50a", "10:47a", "02:57a", commonStepper(), onTap: (){
                          Navigator.pushNamed(context, RouteConstants.timeSheetsScreen);
                        }),
                        const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
                        SizedBox(height: DimensionConstants.d12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("total_hours".tr()).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center),
                                  Text("48:28 Hrs").semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center)
                                ],
                              ),
                              SizedBox(height: DimensionConstants.d6.h),
                              Row(
                                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("x \$20.00/hr").semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center),
                                  Text("\$805.00").semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center)
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

  Widget backNextBtn(String path){
    return Container(
      alignment: Alignment.center,
      width: DimensionConstants.d25.w,
      height: DimensionConstants.d26.h,
      decoration: const BoxDecoration(
        color: ColorConstants.colorWhite30,
        shape: BoxShape.circle,
      ),
      child: ImageView(path: path,),
    );
  }

  Widget weeklyTabBarDateContainer(String date){
    return Container(
      color: ColorConstants.colorLightGreyF2,
      height: DimensionConstants.d32.h,
      alignment: Alignment.center,
      child: Text(date).boldText(context, DimensionConstants.d13.sp, TextAlign.center, color: ColorConstants.colorBlack),
    );
  }

  Widget projectHourRow(Color color, String name, String startingTime, String endTime, String totalTime, Widget stepper, {VoidCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: DimensionConstants.d11.h, horizontal: DimensionConstants.d16.w),
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
              child: Text(name).boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite),
            ),
            SizedBox(width: DimensionConstants.d15.w),
            Text(startingTime).regularText(context, DimensionConstants.d13.sp, TextAlign.center),
            SizedBox(width: DimensionConstants.d14.w),
            stepper,
            SizedBox(width: DimensionConstants.d10.w),
            Text(endTime).regularText(context, DimensionConstants.d13.sp, TextAlign.center),
            SizedBox(width: DimensionConstants.d15.w),
            Text(totalTime).boldText(context, DimensionConstants.d13.sp, TextAlign.center),
            SizedBox(width: DimensionConstants.d11.w),
            ImageView(path: ImageConstants.forwardArrowIcon, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack))
          ],
        ),
      ),
    );
  }

  Widget exportTimeSheetBtn(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      height: DimensionConstants.d40.h,
      width: DimensionConstants.d312.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorConstants.colorGray5, width: 1.0
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(DimensionConstants.d8.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageView(path: ImageConstants.exportIcon),
          SizedBox(width: DimensionConstants.d8.w),
          Text("export_time_sheet".tr()).boldText(context, DimensionConstants.d16.sp, TextAlign.center)
        ],
      ),
    );
  }

  Widget commonStepper(){
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

  Widget stepperLineWithOneCoolIcon(){
    return Row(
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
          width: DimensionConstants.d49.w,
          color: ColorConstants.colorGreen,
        )
      ],
    );
  }

  Widget stepperLineWithTwoCoolIcon(){
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
        SizedBox(height: DimensionConstants.d12.h,)
      ],
    );
  }

  Widget stepperWithGrayAndGreen(){
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
