import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroductionWidget extends StatelessWidget {
  final image;
  final String subText;
  final String title;
  IntroductionWidget(
      {Key? key,
        this.image,
        required this.title,
        required this.subText})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: DimensionConstants.d50.h),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: DimensionConstants.d8.w),
          child:  GestureDetector(
            onTap: (){
              SharedPreference.prefs!.setBool(SharedPreference.INTRODUCTION_COMPLETE, true);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                  RouteConstants.selectToContinueScreen,
                      (route) => false);
            },
            child: Text("skip".tr()).regularText(context,
                DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.primaryColor),
          )
        ),
        SizedBox(height: DimensionConstants.d42.h),
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const ImageView(
                path: ImageConstants.introEllipse,
              ),
              Positioned(
                bottom: -20,
                right: -35,
                child:  ImageView(
                path: image,
              ),)
            ],
          ),
        ),
        SizedBox(height: DimensionConstants.d82.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title).boldText(context,
                DimensionConstants.d30.sp, TextAlign.center, color: ColorConstants.colorWhite),
            SizedBox(height: DimensionConstants.d16.h),
            Text(subText).regularText(context,
                DimensionConstants.d16.sp, TextAlign.left, color: ColorConstants.colorWhite),
          ],
        ),
      ],
    );
  }
}
