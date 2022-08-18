import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/dimension_constants.dart';

class ViewDecoration {



  static InputDecoration inputDecorationTextField({bool contPadding = false, Widget? suffixIcon, Color? fillColor, Color? focusColor, Widget? suffix}) {
    return InputDecoration(
      suffixIconConstraints: const BoxConstraints(maxHeight: 15),
        suffixIcon: suffixIcon,
        suffix: suffix,
        filled: true,
        isDense: true,
        errorMaxLines: 2,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: DimensionConstants.d14.sp,
          fontFamily: StringConstants.fontFamily
        ),
        fillColor: fillColor,
        focusColor: focusColor,
        contentPadding: contPadding ?
        EdgeInsets.fromLTRB(0.0, DimensionConstants.d16.h, 0.0, DimensionConstants.d16.h) :
        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, DimensionConstants.d10.h),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.colorWhite70),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.colorWhite70),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.colorWhite70),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
   );
  }

  static InputDecoration inputDecorationBox(

      {
        required String fieldName,required Color color, required Color?hintTextColor,
        required double? hintTextSize,
        IconData? icon,
        Widget? prefixIcon,
        Widget? suffixIcon,
        double? textSize,
        Color? fillColor,
        double? radius,
        bool imageView = false,
        String? path,
        Color? textFiledColor,

      }) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(
          //  top: DimensionConstants.d10.h,
            bottom: DimensionConstants.d24.h,
            left: DimensionConstants.d25.w,
            right: DimensionConstants.d25.w
        ),
        hintText: fieldName,
        hintStyle: textFieldStyle( hintTextSize!,FontWeight.w400, hintTextColor,),
        border: InputBorder.none,
        fillColor: color,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: fillColor ?? Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        disabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: fillColor ?? Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: fillColor ?? Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        errorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedErrorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(20)))


    );
  }
  static InputDecoration inputDecorationBoxRate(

      {
        required String fieldName,required Color color, required Color?hintTextColor,
        required double? hintTextSize,
        IconData? icon,
        Widget? prefixIcon,
        Widget? suffixIcon,
        double? textSize,
        Color? fillColor,
        double? radius,
        bool imageView = false,
        String? path,
        Color? textFiledColor,

      }) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(
          top: DimensionConstants.d5.h,
            bottom: DimensionConstants.d8.h,
            left: DimensionConstants.d10.w,
            right: DimensionConstants.d5.w
        ),
        hintText: fieldName,
        hintStyle: textFieldStyle( hintTextSize!,FontWeight.w400, hintTextColor,),
        border: InputBorder.none,
        fillColor: color,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: fillColor ?? Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        disabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: fillColor ?? Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: fillColor ?? Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        errorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedErrorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(20)))


    );
  }


  static TextStyle textFieldStyle(double size, fontWeight, color) {
    return TextStyle(
        color: color,
        fontFamily: StringConstants.fontFamily,
        fontWeight: fontWeight,
        fontSize: size,
        letterSpacing: 1.0);
  }


}