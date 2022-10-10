import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowPrivateNoteManager extends StatelessWidget {
  const ShowPrivateNoteManager({Key? key, required this.title, required this.note}) : super(key: key);

  final String title;
  final String note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(
          context,
          actionButtonRequired: false,
          title: "private_note",
          popFunction: () { CommonWidgets.hideKeyboard(context);
          Navigator.pop(context);}
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: DimensionConstants.d37.h,
              ),
              titleWidget(context),
              SizedBox(
                height: DimensionConstants.d24.h,
              ),
              noteWidget(context),
              SizedBox(
                height: DimensionConstants.d24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("title".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          Text(title).regularText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
        ],
      ),
    );
  }

  Widget noteWidget(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("note".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          Text(note).regularText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
        ],
      ),
    );
  }

}
