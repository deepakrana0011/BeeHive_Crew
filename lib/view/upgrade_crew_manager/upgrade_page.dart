import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/dialog_helper.dart';

class UpgradePage extends StatelessWidget {
  const UpgradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndGradient(
        context,
        title: "upgrade",
        actionButtonRequired: true,
        actionIcon: ImageConstants.notificationIconBell,
      ),
      body: Column(
        children: <Widget>[
          detailsWidget(context),
          SizedBox(
            height: DimensionConstants.d140.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: CommonWidgets.commonButton(context, "continue".tr(),
                color1: ColorConstants.primaryGradient2Color,
                color2: ColorConstants.primaryGradient1Color,
                fontSize: DimensionConstants.d14.sp, onBtnTap: () {
              Navigator.pushNamed(context, RouteConstants.paymentPage);

            }),
          ),
        ],
      ),
    );
  }
}

Widget detailsWidget(BuildContext context) {
  return Container(
    height: DimensionConstants.d490.h,
    width: DimensionConstants.d375.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(DimensionConstants.d40.r),
          bottomLeft: Radius.circular(DimensionConstants.d40.r)),
      gradient: const LinearGradient(colors: [
        ColorConstants.blueGradient1Color,
        ColorConstants.blueGradient2Color
      ]),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: DimensionConstants.d20.h,
          ),
          SizedBox(
            height: DimensionConstants.d61.h,
            width: DimensionConstants.d260.w,
            child: Text("once_you_upgrade_as_a_crew_manger_you_will_get".tr())
                .semiBoldText(
                    context, DimensionConstants.d22.sp, TextAlign.left,
                    color: ColorConstants.colorWhite),
          ),
          SizedBox(
            height: DimensionConstants.d29.h,
          ),
          projectsWidget(
              context,
              "free_projects",
              "create_as_many_projects_as_you_like_free_of_charge",
              ImageConstants.allProjectIcon),
          SizedBox(
            height: DimensionConstants.d40.h,
          ),
          projectsWidget(
              context,
              "add_your_crew_members",
              "projects_are_free_active_crew_members_are_only_per_month",
              ImageConstants.userIcon),
          SizedBox(
            height: DimensionConstants.d40.h,
          ),
          projectsWidget(
              context,
              "don_use_it_don_pay",
              "you_will_not_be_charged_for_inactive_crew_members",
              ImageConstants.cardIcon),
        ],
      ),
    ),
  );
}

Widget projectsWidget(
    BuildContext context, String title, String text, String image) {
  return Row(
    children: <Widget>[
      Container(
        height: DimensionConstants.d80.h,
        width: DimensionConstants.d80.w,
        decoration: BoxDecoration(
            color: ColorConstants.deepBlue,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: Center(
            child: ImageView(
          path: image,
          height: DimensionConstants.d42.h,
          width: DimensionConstants.d40.w,
        )),
      ),
      SizedBox(
        width: DimensionConstants.d16.w,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title.tr()).boldText(
              context, DimensionConstants.d18.sp, TextAlign.left,
              color: ColorConstants.colorWhite),
          SizedBox(
            height: DimensionConstants.d9.h,
          ),
          Container(
            height: DimensionConstants.d40.h,
            width: DimensionConstants.d210.w,
            child: Text(text.tr()).regularText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: ColorConstants.colorWhite),
          )
        ],
      )
    ],
  );
}
