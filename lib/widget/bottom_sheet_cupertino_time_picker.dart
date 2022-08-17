import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/image_constants.dart';
import '../helper/common_widgets.dart';
import 'image_view.dart';

bottomSheetTimeSheetTimePicker(
  BuildContext context, {
  required VoidCallback onTap,
  required bool timeSheetOrSchedule,
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
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: DimensionConstants.d20.h,
                        ),
                        Text("change_time".tr()).boldText(
                            context, DimensionConstants.d20.sp, TextAlign.center,
                            color: ColorConstants.deepBlue),
                        SizedBox(height: DimensionConstants.d10.h,),
                        timeSelector(),
                        CommonWidgets.commonButton(
                            context, "save".tr(),
                            color1: ColorConstants.primaryGradient1Color,
                            color2: ColorConstants.primaryGradient2Color,
                            fontSize: DimensionConstants.d16.sp,
                            shadowRequired: true, onBtnTap: () {

                        }),
                      ],
                    ),
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

Widget timeSelector() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          height: DimensionConstants.d215.h,
          width: DimensionConstants.d307.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensionConstants.d12.r),
          ),
          child: Center(
              child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                    color: ColorConstants.deepBlue,
                    fontWeight: FontWeight.w400,
                    fontSize: DimensionConstants.d25.sp),
              ),
            ),
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.time,
              use24hFormat: false,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {},
            ),
          ))),

    ],
  );
}
