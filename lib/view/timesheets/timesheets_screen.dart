import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeSheetsScreen extends StatelessWidget {
  const TimeSheetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("time_sheets".tr()).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: Icon(Icons.keyboard_backspace, color: Theme.of(context).iconTheme.color, size: 28,)),
      ),
      body: Column(
        children: [
          SizedBox(height: DimensionConstants.d5.h),
          const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d36.w),
            child: Row(
              children: [
                crewProfileContainer(context, "Benjamin Poole", path: ImageConstants.timeSheetsProfile),
                SizedBox(width: DimensionConstants.d14.w),
                Container(
                  width: DimensionConstants.d1.w,
                  height: DimensionConstants.d72.h,
                  color: ColorConstants.colorGrayE8,
                ),
                SizedBox(width: DimensionConstants.d24.w),
                crewProfileContainer(context, "Momentum Digital", shortName: "MD", color: ColorConstants.colorGreen),
              ],
            ),
          ),
          const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
          SizedBox(height: DimensionConstants.d24.h),
          Text("Tue, Apr 13 2021").boldText(context, DimensionConstants.d18.sp, TextAlign.center),
          SizedBox(height: DimensionConstants.d16.h),
          hoursContainer(context),
          SizedBox(height: DimensionConstants.d26.h),
          checkInCHeckOutStepper(context)
        ],
      ),
    );
  }

  Widget crewProfileContainer(BuildContext context, String name, {String? path, String? shortName, Color? color}){
    return Row(
      children: [
      path != null ?  SizedBox(
          height: DimensionConstants.d40.h,
          width: DimensionConstants.d40.w,
          child: ImageView(path: path),
        ) :  Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(DimensionConstants.d5),
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Text(shortName!).boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite),
      ),
        SizedBox(width: DimensionConstants.d13.w),
        SizedBox(
          width: DimensionConstants.d75.w,
          child: Text(name).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget hoursContainer(BuildContext context){
    return Container(
      alignment: Alignment.center,
      width: DimensionConstants.d120.w,
      height: DimensionConstants.d36.h,
      decoration: BoxDecoration(
        color: ColorConstants.colorLightGreyF2,
        borderRadius: BorderRadius.all(
          Radius.circular(DimensionConstants.d100.r),
        ),
      ),
      child: Text("8:57 Hrs").boldText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorBlack),
    );
  }

  Widget checkInCHeckOutStepper(BuildContext context){
    return Column(
      children: [
        checkInCheckOut(context, "check_in".tr(), "8:50a", CrossAxisAlignment.end),
        stepperLine(DimensionConstants.d35.h, ColorConstants.colorGreen),
        SizedBox(height: DimensionConstants.d2.h),
        stepperLineWithRowText(context, DimensionConstants.d13.h, "15m ${"interruption".tr()}", "10:15a - 10:30a", ColorConstants.colorLightRed, ColorConstants.colorGray2),
        SizedBox(height: DimensionConstants.d2.h),
        stepperLine(DimensionConstants.d80.h, ColorConstants.colorGreen),
        SizedBox(height: DimensionConstants.d4.h),
        stepperLineWithRowText(context, DimensionConstants.d42.h, "break".tr(), "12:00p - 12:30p", ColorConstants.colorGray, ColorConstants.colorGray2),
        SizedBox(height: DimensionConstants.d4.h),
        stepperLine(DimensionConstants.d60.h, ColorConstants.colorGreen),
        stepperLineWithRowText(context, DimensionConstants.d6.h, "5m ${"interruption".tr()}", "3:15p - 3:20p", ColorConstants.colorLightRed, ColorConstants.colorGray2),
        stepperLine(DimensionConstants.d60.h, ColorConstants.colorGreen),
        checkInCheckOut(context, "check_out".tr(), "05:47p", CrossAxisAlignment.start)
      ],
    );
  }

  Widget checkInCheckOut(BuildContext context, String checkText, String time, alignment){
    return Row(
      crossAxisAlignment: alignment,
      children: [
        Container(
          alignment: Alignment.bottomRight,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Text(checkText).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center),
        ),
        SizedBox(width: DimensionConstants.d10.w),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: DimensionConstants.d6.h,
            decoration: BoxDecoration(
              color: ColorConstants.colorBlack,
              borderRadius: BorderRadius.all(
                Radius.circular(DimensionConstants.d4.r),
              ),
            ),
            width: DimensionConstants.d15.w,
          ),
        ),
        SizedBox(width: DimensionConstants.d10.w),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Text(time).regularText(context, DimensionConstants.d13.sp, TextAlign.center),
        )
      ],
    );
  }

  Widget stepperLine(double height, Color color){
    return Container(
      width: DimensionConstants.d6.w,
      height: height,
      color: color,
    );
  }

  Widget stepperLineWithRowText(BuildContext context, double height, String txt, String time, Color color, Color timeColor){
    return Row(
     // crossAxisAlignment: alignment,
      children: [
        Container(
          alignment: Alignment.bottomRight,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Text(txt).regularText(context, DimensionConstants.d14.sp, TextAlign.center, color: color),
        ),
        SizedBox(width: DimensionConstants.d13.w),
        Expanded(
          child: Container(
            width: DimensionConstants.d6.w,
            height: height,
            color: color,
          )
        ),
        SizedBox(width: DimensionConstants.d13.w),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 2.2,
          child: Text(time).regularText(context, DimensionConstants.d13.sp, TextAlign.center, color: timeColor),
        )
      ],
    );
  }
}
