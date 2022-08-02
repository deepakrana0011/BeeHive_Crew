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
                  RouteConstants.signInScreen,
                      (route) => false);
            },
            child:  Text("sign_in".tr()).regularText(context,
                DimensionConstants.d20.sp, TextAlign.left, color: ColorConstants.colorWhite),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                  RouteConstants.signInScreen,
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
}