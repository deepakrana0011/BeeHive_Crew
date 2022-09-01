import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(context, title: "payment",popFunction: () { CommonWidgets.hideKeyboard(context);
      Navigator.pop(context);}),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d38.w),
        child: Column(
          children: <Widget>[
            SizedBox(height: DimensionConstants.d38.h,),
            payWidget(context,ImageConstants.appleIcon,"apple_pay"),
            SizedBox(height: DimensionConstants.d10.h,),
            payWidget(context,ImageConstants.googleIcon,"google_pay"),
            SizedBox(height: DimensionConstants.d10.h,),
            payWidget(context,ImageConstants.payPalIcon,"paypal"),
          ],
        ),
      ),
    );
  }
}

Widget payWidget(BuildContext context,String image,String text) {
  return Container(
    height: DimensionConstants.d60.h,
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorBlack
          : ColorConstants.grayF2F2F2,
      border: Theme.of(context).brightness == Brightness.dark
          ? Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.grayF2F2F2,
              width: DimensionConstants.d1.w)
          : null,
      borderRadius: BorderRadius.circular(DimensionConstants.d100.r),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: DimensionConstants.d15.w),
      child: Row(
        children: <Widget>[
          Container(
            height: DimensionConstants.d40.h,
            width: DimensionConstants.d40.w,
            decoration: BoxDecoration(
              color: ColorConstants.colorWhite,
              borderRadius: BorderRadius.circular(DimensionConstants.d20.r),
            ),
            child:  Center(
              child: ImageView(
                path: image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: DimensionConstants.d22.w,
          ),
          Text(text.tr()).regularText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
        ],
      ),
    ),
  );
}
