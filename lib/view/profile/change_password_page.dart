import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../helper/decoration.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CommonWidgets.appBarWithTitleAndAction(context,title: "change_password".tr(),actionButtonRequired: false,),
      body: Column(
        children:<Widget> [
          SizedBox(height: DimensionConstants.d24.h,),
          textFiledName(context, "old_password", "*********"),
          SizedBox(height: DimensionConstants.d16.h,),
          textFiledName(context, "new_password", "*********"),
          SizedBox(height: DimensionConstants.d16.h,),
          textFiledName(context, "re_enter_new_password", "*********"),
          SizedBox(height: DimensionConstants.d335.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: CommonWidgets.commonButton(
                context, "change_password".tr(),
                color1: ColorConstants.primaryGradient2Color,
                color2: ColorConstants.primaryGradient1Color,
                fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                  Navigator.pop(context);
            },
                shadowRequired: true
            ),
          ),

        ],
      ),
    );
  }
}

Widget textFiledName(BuildContext context, String title, String hintName) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title.tr()).boldText(
            context, DimensionConstants.d16.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack),
        SizedBox(
          height: DimensionConstants.d8.h,
        ),
        Container(
          height: DimensionConstants.d45.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.grayF3F3F3
                : ColorConstants.colorBlack,
            border: Theme.of(context).brightness == Brightness.dark
                ? Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : Colors.transparent)
                : null,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: TextFormField(
            cursorColor: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack,
            maxLines: 1,
            decoration: ViewDecoration.inputDecorationBox(
              fieldName: hintName.tr(),
              radius: DimensionConstants.d8.r,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.grayF3F3F3,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.grayF3F3F3,
              hintTextColor: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack,
              hintTextSize: DimensionConstants.d16.sp,
            ),
          ),
        )
      ],
    ),
  );
}

