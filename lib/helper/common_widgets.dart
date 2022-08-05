import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonWidgets{

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static Widget signInCreateAccountRow(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: DimensionConstants.d6.w, right: DimensionConstants.d29.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                  RouteConstants.selectToContinueScreen,
                      (route) => false);
            },
            child:  Text("sign_in".tr()).regularText(context,
                DimensionConstants.d20.sp, TextAlign.left, color: ColorConstants.colorWhite),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                  RouteConstants.selectToContinueScreen,
                      (route) => false);
            },
            child: Text("create_account".tr()).regularText(context,
                DimensionConstants.d20.sp, TextAlign.left, color: ColorConstants.primaryColor),
          ),
        ],
      ),
    );
  }


  static Widget commonButton(BuildContext context, String btnText, {VoidCallback? onBtnTap, double? height, Color? color1, Color? color2, double? fontSize}){
    return GestureDetector(
      onTap: onBtnTap,
      child: Container(
        height: height ?? DimensionConstants.d60.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
               color1 ?? ColorConstants.primaryGradient2Color,
               color2 ??  ColorConstants.primaryGradient1Color
              ],
            ),
          borderRadius: BorderRadius.all(
            Radius.circular(DimensionConstants.d8.r),
          ),
        ),
        child: Text(btnText).boldText(context, fontSize ?? DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite),
      ),
    );
  }

 static Widget totalProjectsTotalHoursRow(BuildContext context, String totalProject, String totalHours) {
    return Container(
          height: DimensionConstants.d72.h,
          width: DimensionConstants.d343.w,
          decoration: BoxDecoration(
            color: ColorConstants.littleDarkGray,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d40.w),
            child: Row(
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: DimensionConstants.d13.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(totalProject).semiBoldText(
                          context, DimensionConstants.d20.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.colorBlack),
                      SizedBox(
                        height: DimensionConstants.d5.h,
                      ),
                      Text("project_projects".tr()).regularText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.colorBlack),
                    ],
                  ),
                ),
                SizedBox(
                  width: DimensionConstants.d40.w,
                ),
                Container(
                  height: DimensionConstants.d72.h,
                  width: DimensionConstants.d1.w,
                  color: ColorConstants.colorGrayE8,
                ),
                SizedBox(
                  width: DimensionConstants.d55.w,
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: DimensionConstants.d13.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(totalHours).semiBoldText(
                          context, DimensionConstants.d20.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.colorBlack),
                      SizedBox(
                        height: DimensionConstants.d5.h,
                      ),
                      Text("total_hours".tr()).regularText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.colorBlack),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}