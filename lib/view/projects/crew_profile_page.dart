import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';

class CrewProfilePage extends StatelessWidget {
  const CrewProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(context,
          title: "crew_profile", actionButtonRequired: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          crewProfileWidget(context),
          SizedBox(height: DimensionConstants.d16.h,),
          profileDetails(context),
        ],
      ),
    );
  }
}

Widget crewProfileWidget(BuildContext context) {
  return Container(
    height: DimensionConstants.d140.h,
    decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? ColorConstants.colorBlack
            : ColorConstants.colorWhite,
        border: Border(
          bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.littleDarkGray,
              width: DimensionConstants.d1.w),
        )),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: DimensionConstants.d25.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageView(
              path: ImageConstants.personIcon,
              height: DimensionConstants.d93.h,
              width: DimensionConstants.d93.w,
              fit: BoxFit.fill,
            ),
            SizedBox(width: DimensionConstants.d14.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Benjamin Poole").semiBoldText(
                    context, DimensionConstants.d22.sp, TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.deepBlue),
                SizedBox(height: DimensionConstants.d7.h,),
                Text("carpenter".tr()).boldText(
                    context, DimensionConstants.d18.sp, TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.deepBlue),
                SizedBox(height: DimensionConstants.d8.h,),
                Text("Finishing and Framing").regularText(
                    context, DimensionConstants.d14.sp, TextAlign.left,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.deepBlue),
              ],
            )
          ],
        )
      ],
    ),
  );
}
Widget profileDetails(BuildContext context){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d24.w),
    child: Column(
      children:<Widget> [
        Row(
          children:<Widget> [
             ImageView(path: ImageConstants.companyIcon,
            height: DimensionConstants.d24.h,
            width: DimensionConstants.d24.w,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack,
            ),
            SizedBox(width: DimensionConstants.d16.w,),
            Text("xyz Company").regularText(context, DimensionConstants.d14.sp, TextAlign.left,),


          ],
        ),
        SizedBox(height: DimensionConstants.d30.h,),
        Row(
          children:<Widget> [
            ImageView(path: ImageConstants.callerIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack,
            ),
            SizedBox(width: DimensionConstants.d16.w,),
            Text("123-555-2514").regularText(context, DimensionConstants.d14.sp, TextAlign.left,),


          ],
        ),
        SizedBox(height: DimensionConstants.d30.h,),
        Row(
          children:<Widget> [
            ImageView(path: ImageConstants.mailerIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack,
            ),
            SizedBox(width: DimensionConstants.d16.w,),
            Text("johnsmith@gmail.com").regularText(context, DimensionConstants.d14.sp, TextAlign.left,),


          ],
        ),
        SizedBox(height: DimensionConstants.d30.h,),
        Row(
          children:<Widget> [
            ImageView(path: ImageConstants.locationIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack,
            ),
            SizedBox(width: DimensionConstants.d16.w,),
            Text("88 Bloor St E. Toronto ONM4W3G9").regularText(context, DimensionConstants.d14.sp, TextAlign.left,),


          ],
        ),


      ],
    ),
  );



}
