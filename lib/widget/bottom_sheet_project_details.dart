
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/views_manager/projects_manager/timesheets_screen_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/image_constants.dart';
import 'image_view.dart';

bottomSheetProjectDetails(BuildContext context, {required VoidCallback onTap, required bool timeSheetOrSchedule,
}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DimensionConstants.d30.r),
              topRight: Radius.circular(DimensionConstants.d30.r))),
      context: context,
      builder: (context) {
        return Stack(
          children: [
            SizedBox(
              height: DimensionConstants.d380.h,
              child: Padding(
                padding: EdgeInsets.only(top: DimensionConstants.d40.h),
                child: Container(
                  height: DimensionConstants.d240.h,
                  width: DimensionConstants.d375.w,
                  decoration: BoxDecoration(
                    color: ColorConstants.colorWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DimensionConstants.d41.r),
                        topRight: Radius.circular(DimensionConstants.d41.r)),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: DimensionConstants.d28.h,
                      ),
                      projectInformation(context),
                      SizedBox(
                        height: DimensionConstants.d28.h,
                      ),
                      userProfile(context, ImageConstants.managerImage,timeSheetOrSchedule),
                      SizedBox(
                        height: DimensionConstants.d8.h,
                      ),
                      userProfile(context, ImageConstants.personIcon,timeSheetOrSchedule),


                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: DimensionConstants.d300.h,
                left: DimensionConstants.d270.w,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const ImageView(
                    path: ImageConstants.crossIcon,
                  ),
                )),
          ],
        );
      });
}

Widget projectInformation(BuildContext context){
  return Column(
    children:<Widget> [
      Container(
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d40.w,
        decoration: BoxDecoration(
          color: ColorConstants.schedule5,
          borderRadius: BorderRadius.circular(DimensionConstants.d20.r),
        ),
        child: Center(
          child: Text("MS").boldText(context, DimensionConstants.d16.sp, TextAlign.center,color: ColorConstants.colorWhite),
        )
      ),
      SizedBox(height: DimensionConstants.d11.h,),
      Text("Momentum Smart Project").boldText(context, DimensionConstants.d18.sp, TextAlign.center,color: ColorConstants.colorBlack),
      SizedBox(height: DimensionConstants.d6.h,),
      Text("Monday, June 13 2021").boldText(context, DimensionConstants.d16.sp, TextAlign.center,color: ColorConstants.colorBlack),
    ],
  );


}
Widget userProfile(BuildContext context,String image, bool timeSheetOrSchedule){
  return GestureDetector(
    onTap: (){
      if(timeSheetOrSchedule == true){
        Navigator.of(context).pop();
        Navigator.pushNamed(context, RouteConstants.crewPageProfileManager,);
      }else{
        Navigator.of(context).pop();
        Navigator.pushNamed(context, RouteConstants.timeSheetScreenManager,arguments: TimeSheetsScreenManager(removeInterruption: false));
      }

    },
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      child: Container(
        height: DimensionConstants.d76.h,
        width: DimensionConstants.d343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
          child: Row(
            children:<Widget> [
              ImageView(path: image,
              height: DimensionConstants.d50.h,
                width: DimensionConstants.d50.w,
              ),
              SizedBox(width: DimensionConstants.d16.w,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  Text("Benjamin Poole").boldText(context, DimensionConstants.d16.sp, TextAlign.left,color: ColorConstants.deepBlue),
                  Text("Carpenter    \$20.00/hr").regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.deepBlue),
                ],
              ),
              Expanded(child: Container()),
              ImageView(path: ImageConstants.arrowIcon,
              width: DimensionConstants.d10.w,
              height: DimensionConstants.d14.h,)

            ],
          ),
        ),
      ),
    ),
  );


}
