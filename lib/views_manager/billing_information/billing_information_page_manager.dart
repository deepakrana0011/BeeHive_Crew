import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/views_manager/projects_manager/set_rates_page_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingInformationPageManager extends StatelessWidget {
  bool texOrNot;
   BillingInformationPageManager({Key? key,required this.texOrNot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(context,
          title: "billing_information".tr(), actionButtonRequired: false,popFunction: () { CommonWidgets.hideKeyboard(context);
          Navigator.pop(context);}),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: DimensionConstants.d20.h,
            ),
            userProfile(context),
            SizedBox(
              height: DimensionConstants.d20.h,
            ),
            Devider(DimensionConstants.d1.h, DimensionConstants.d375.w,
                ColorConstants.grayF3F3F3),
            SizedBox(
              height: DimensionConstants.d20.h,
            ),
            billingInformationWidget(context,texOrNot),
            SizedBox(
              height: DimensionConstants.d50.h,
            ),

          ],
        ),
      ),
    );
  }
}

Widget userProfile(BuildContext context) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: DimensionConstants.d28.w,
      ),
      Text("billed_to".tr()).mediumText(
          context, DimensionConstants.d14.sp, TextAlign.left,
          color: ColorConstants.colorBlack),
      SizedBox(
        width: DimensionConstants.d8.w,
      ),
      ImageView(
        path: ImageConstants.personIcon,
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d40.w,
      ),
      SizedBox(
        width: DimensionConstants.d14.w,
      ),
      Text("Benjamin Poole").mediumText(
          context, DimensionConstants.d14.sp, TextAlign.left,
          color: ColorConstants.colorBlack),
    ],
  );
}

Widget billingInformationWidget(BuildContext context,bool texPrNot){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d36.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget> [
        Text("dear_customer".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
        SizedBox(
          height: DimensionConstants.d20.h,
        ),
        Text("you_have_the_following_purchase_with_details".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
        SizedBox(
          height: DimensionConstants.d30.h,
        ),
        subcriptionWidget(context,texPrNot),
        SizedBox(height: DimensionConstants.d25.h,),
        Text("para1".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
        SizedBox(height: DimensionConstants.d20.h,),
        Text("para2".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
        SizedBox(height: DimensionConstants.d20.h,),
        Text("para3".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
        SizedBox(
          height: DimensionConstants.d45.h,
        ),
        CommonWidgets.commonButton(context, "pay_subcription".tr(),
            color1: ColorConstants.primaryGradient2Color,
            color2: ColorConstants.primaryGradient1Color,
            fontSize: DimensionConstants.d18.sp, onBtnTap: () {

          Navigator.pushNamed(context, RouteConstants.paymentPageManager);
            },
            shadowRequired: true
        ),
        SizedBox(
          height: DimensionConstants.d20.h,
        ),
        Container(
          height: DimensionConstants.d50.h,
          width: DimensionConstants.d343.w,
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.colorGray,width: DimensionConstants.d1.w),
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)
          ),
          child: Center(
            child: Text("cancel_your_purchase".tr()).boldText(context, DimensionConstants.d16.sp, TextAlign.center,color: ColorConstants.redColorEB5757),
          ),
        )

      ],
    ),
  );
}
Widget subcriptionWidget(BuildContext context, bool texOrNot){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget> [
        rowForDetails(context,"app","beehive_name",DimensionConstants.d65.w),
        SizedBox(height: DimensionConstants.d19.h,),
        rowForDetails(context,"subscription","Additional Crew Member",DimensionConstants.d18.w),
        SizedBox(height: DimensionConstants.d19.h,),
        rowForDetails(context,"total_crew","5",DimensionConstants.d30.w),
        SizedBox(height:texOrNot == true? DimensionConstants.d19.h:DimensionConstants.d1.h,),
      texOrNot== texOrNot?  rowForDetails(context,"tax","\$2.00",DimensionConstants.d72.w):Container(),
        SizedBox(height: DimensionConstants.d19.h,),
        rowForDetails(context,"total_price","\$25.00",DimensionConstants.d30.w),



      ],
    ),
  );
}
Widget rowForDetails(BuildContext context,String filedName,String detailName,double width){
  return Row(
    children:<Widget>[
      Text(filedName.tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
      SizedBox(width:width),
      const Text(":").regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
      SizedBox(width: DimensionConstants.d22.w,),
      Text(detailName.tr()).mediumText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.colorBlack),
    ],
  );

}
