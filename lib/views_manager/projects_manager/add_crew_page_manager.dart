import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/add_crew_page_provider_manager.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/decoration.dart';

class AddCrewPageManager extends StatelessWidget {
  const AddCrewPageManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddCrewPageManagerProvider>(
      onModelReady: (provider){},
      builder: (context,provider,_){

        return Scaffold(
          appBar:
          CommonWidgets.appBarWithTitleAndAction(context, title: "add_crew"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: DimensionConstants.d16.h,
                  ),
                  searchBarWidget(),
                  SizedBox(
                    height: DimensionConstants.d13.h,
                  ),
                  shareWidget(context,provider),
                  SizedBox(
                    height: DimensionConstants.d13.h,
                  ),
                  crewWidget(context,ImageConstants.userImage,ImageConstants.selectedIcon),
                  SizedBox(height: DimensionConstants.d5.h,),
                  crewWidget(context,ImageConstants.userImage2,ImageConstants.blankIcon),
                  SizedBox(height: DimensionConstants.d5.h,),
                  crewWidget(context,ImageConstants.userImage,ImageConstants.selectedIcon),
                  SizedBox(height: DimensionConstants.d5.h,),
                  crewWidget(context,ImageConstants.userImage3,ImageConstants.blankIcon),
                  SizedBox(height: DimensionConstants.d5.h,),
                  crewWidget(context,ImageConstants.userImage2,ImageConstants.selectedIcon),
                  SizedBox(height: DimensionConstants.d5.h,),
                  crewWidget(context,ImageConstants.userImage,ImageConstants.selectedIcon),
                  SizedBox(height: DimensionConstants.d5.h,),
                  crewWidget(context,ImageConstants.userImage2,ImageConstants.blankIcon),
                  SizedBox(height: DimensionConstants.d30.h,),
                  CommonWidgets.commonButton(context, "next".tr(),
                      color1: ColorConstants.primaryGradient2Color,
                      color2: ColorConstants.primaryGradient1Color,
                      fontSize: DimensionConstants.d14.sp, onBtnTap: () {

                    Navigator.pushNamed(context, RouteConstants.setRatesManager);

                      },
                      shadowRequired: true
                  ),

                ],
              ),
            ),
          ),
        );




      },

    );
  }
}

Widget searchBarWidget() {
  return Container(
    height: DimensionConstants.d45.h,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Row(
        children: <Widget>[
          ImageView(
            path: ImageConstants.searchIcon,
            height: DimensionConstants.d24.h,
            width: DimensionConstants.d24.w,
          ),
          SizedBox(
            height: DimensionConstants.d45.h,
            width: DimensionConstants.d287.w,
            child: TextFormField(
              cursorColor: ColorConstants.colorBlack,
              maxLines: 1,
              decoration: ViewDecoration.inputDecorationBox(
                fieldName: "search_for_name_city_or_trade".tr(),
                radius: DimensionConstants.d8.r,
                fillColor: ColorConstants.grayF2F2F2,
                color: ColorConstants.grayF3F3F3,
                hintTextColor: ColorConstants.colorBlack,
                hintTextSize: DimensionConstants.d16.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget shareWidget(BuildContext context,AddCrewPageManagerProvider provider) {
  return Row(
    children: <Widget>[
      Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: GestureDetector(
          onTap: () {
            provider.onShare(context);
          },
          child: Container(
            height: DimensionConstants.d50.h,
            width: DimensionConstants.d284.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
              child: Row(
                children: <Widget>[
                  const ImageView(
                    path: ImageConstants.messageIcon,
                  ),
                  SizedBox(
                    width: DimensionConstants.d14.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("send_invite".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.left,
                          color: ColorConstants.deepBlue),
                      Text("invite_a_new_crew_member".tr()).regularText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: ColorConstants.deepBlue),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Expanded(child: Container()),
      Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.crewMemberAddByManager);
          },
          child: Container(
            height: DimensionConstants.d50.h,
            width: DimensionConstants.d50.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: const Center(
              child: ImageView(
                path: ImageConstants.addCrewIcon,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

Widget crewWidget(BuildContext context,String image,String selected){
  return Container(
    height: DimensionConstants.d60.h,
    width: double.infinity,
    child: Row(
      children:<Widget> [
        ImageView(path: image ),
        SizedBox(width: DimensionConstants.d16.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text("Jason Smith").boldText(context, DimensionConstants.d16.sp, TextAlign.left,color: ColorConstants.deepBlue),
            Text("Carpenter").regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.deepBlue),
            Text("Belleville, ON").regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.deepBlue),

          ],
        ),
        Expanded(child: Container()),
        ImageView(path: selected,),

      ],
    ),


  );

}
