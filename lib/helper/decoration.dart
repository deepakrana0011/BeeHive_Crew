import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/dimension_constants.dart';

class ViewDecoration {

  static InputDecoration inputDecorationTextField({bool contPadding = false, Widget? suffixIcon}) {
    return InputDecoration(
      suffixIconConstraints: const BoxConstraints(maxHeight: 15),
        suffixIcon: suffixIcon,
        filled: true,
        isDense: true,
        errorMaxLines: 2,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: DimensionConstants.d14.sp,
          fontFamily: StringConstants.fontFamily
        ),
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


  static TextStyle textFieldStyle(double size, fontWeight, color) {
    return TextStyle(
        color: color,
        fontFamily: StringConstants.fontFamily,
        fontWeight: fontWeight,
        fontSize: size,
        letterSpacing: 1.0);
  }
}