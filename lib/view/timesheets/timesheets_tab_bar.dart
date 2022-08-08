import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/widget/custom_tab_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeSheetsTabBar extends StatelessWidget {
  const TimeSheetsTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        elevation: 0.0,
        title: Text("time_sheets".tr()).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center),
      ),*/
      body: Column(
        children: [
          //SizedBox(height: DimensionConstants.d5.h),
        //  const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
          SizedBox(height: DimensionConstants.d24.h),
          CommonWidgets.totalProjectsTotalHoursRow(context, "4", "564"),
          CustomTabBar()
        ],
      ),
    );
  }
}
