import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/string_constants.dart';
import 'package:flutter/material.dart';

extension ExtendText on Text {
  regularText(BuildContext context, double textSize, TextAlign alignment,
      {maxLines, overflow, Color? color, letterSpacing = 0.0}) {
    return Text(
      data!,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: alignment,
      style: TextStyle(
          color: color ?? (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
          fontFamily: StringConstants.fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: textSize,
          letterSpacing: letterSpacing),
    );
  }

  mediumText(BuildContext context, double textSize, TextAlign alignment,
      {maxLines, overflow, Color? color}) {
    return Text(
      data!,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: alignment,
      style: TextStyle(
          color: color ?? (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
          fontFamily: StringConstants.fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: textSize),
    );
  }

  semiBoldText(BuildContext context, double textSize, TextAlign alignment,
      {maxLines, overflow, Color? color}) {
    return Text(
      data!,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: alignment,
      style: TextStyle(
          color: color ?? (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
          fontFamily: StringConstants.fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: textSize),
    );
  }


  boldText(BuildContext context, double textSize, TextAlign alignment,
      {maxLines, overflow, Color? color}) {
    return Text(
      data!,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: alignment,
      style: TextStyle(
          color: color ?? (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack),
          fontFamily: StringConstants.fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: textSize),
    );
  }
}