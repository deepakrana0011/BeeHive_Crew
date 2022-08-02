import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeHiveIntroduction extends StatelessWidget {
  const BeeHiveIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: DimensionConstants.d270.h),
        ImageView(path: ImageConstants.appLogo, height: DimensionConstants.d60.h, width: DimensionConstants.d235.w),
        SizedBox(height: DimensionConstants.d82.h),
         Text("track_and_manage".tr()).semiBoldText(context, DimensionConstants.d30.sp, TextAlign.left, color: ColorConstants.colorWhite),
      ],
      );
  }
}
