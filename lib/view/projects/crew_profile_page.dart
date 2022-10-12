import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/model/get_crew_profile_response.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';

class CrewProfilePage extends StatelessWidget {
  CrewProfilePage({Key? key, required this.profileData}) : super(key: key);

  Data profileData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(context,
          title: "crew_profile", actionButtonRequired: false, popFunction: () {
            CommonWidgets.hideKeyboard(context);
            Navigator.pop(context);
          }),
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


  Widget crewProfileWidget(BuildContext context) {
    return Container(
      height: DimensionConstants.d140.h,
      decoration: BoxDecoration(
          color: Theme
              .of(context)
              .brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.colorWhite,
          border: Border(
            bottom: BorderSide(
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
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
                path: profileData.profileImage == null ? ImageConstants.emptyImageIcon : "${ApiConstantsCrew.BASE_URL_IMAGE}${profileData.profileImage}",
                height: DimensionConstants.d93.h,
                width: DimensionConstants.d93.w,
                fit: BoxFit.fill,
              ),
              SizedBox(width: DimensionConstants.d14.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 SizedBox(
                   width: DimensionConstants.d150.w,
                   child:  Text(profileData.name ?? "").semiBoldText(
                       context, DimensionConstants.d22.sp, TextAlign.left,
                       color: Theme
                           .of(context)
                           .brightness == Brightness.dark
                           ? ColorConstants.colorWhite
                           : ColorConstants.deepBlue, maxLines: 1, overflow: TextOverflow.ellipsis),
                 ),
                  SizedBox(height: DimensionConstants.d7.h,),
                 SizedBox(
                   width: DimensionConstants.d150.w,
                   child: Text(profileData.position ?? "").boldText(
                       context, DimensionConstants.d18.sp, TextAlign.left,
                       color: Theme
                           .of(context)
                           .brightness == Brightness.dark
                           ? ColorConstants.colorWhite
                           : ColorConstants.deepBlue, maxLines: 1, overflow: TextOverflow.ellipsis),
                 ),
                  SizedBox(height: DimensionConstants.d8.h,),
                 SizedBox(
                   width: DimensionConstants.d150.w,
                   child:  Text(profileData.speciality ?? "").regularText(
                       context, DimensionConstants.d14.sp, TextAlign.left,
                       color: Theme
                           .of(context)
                           .brightness == Brightness.dark
                           ? ColorConstants.colorWhite
                           : ColorConstants.deepBlue, maxLines: 1, overflow: TextOverflow.ellipsis),
                 )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget profileDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d24.w),
      child: Column(
        children: <Widget>[
          (profileData.company == null || profileData.company == "") ? Container() : SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                ImageView(path: ImageConstants.companyIcon,
                  height: DimensionConstants.d24.h,
                  width: DimensionConstants.d24.w,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
                ),
                SizedBox(width: DimensionConstants.d16.w,),
               Expanded(
                 child:  Text(profileData.company ?? "").regularText(
                   context, DimensionConstants.d14.sp, TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis),
               )


              ],
            ),
          ),
          (profileData.company == null || profileData.company == "") ? Container() : SizedBox(height: DimensionConstants.d30.h,),
          (profileData.phoneNumber == null || profileData.phoneNumber == "") ? Container() :  SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                ImageView(path: ImageConstants.callerIcon,
                  height: DimensionConstants.d24.h,
                  width: DimensionConstants.d24.w,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
                ),
                SizedBox(width: DimensionConstants.d16.w,),
                Expanded(
                  child:  Text(profileData.phoneNumber.toString() ?? "").regularText(
                      context, DimensionConstants.d14.sp, TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis),
                )


              ],
            ),
          ),
          (profileData.phoneNumber == null || profileData.phoneNumber == "") ? Container() : SizedBox(height: DimensionConstants.d30.h,),
          (profileData.email == null || profileData.email == "") ? Container() :  SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                ImageView(path: ImageConstants.mailerIcon,
                  height: DimensionConstants.d24.h,
                  width: DimensionConstants.d24.w,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
                ),
                SizedBox(width: DimensionConstants.d16.w,),
                Expanded(
                  child:  Text(profileData.email ?? "").regularText(
                      context, DimensionConstants.d14.sp, TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis),
                )


              ],
            ),
          ),
          (profileData.email == null || profileData.email == "") ? Container() : SizedBox(height: DimensionConstants.d30.h,),
          (profileData.address == null || profileData.address == "") ? Container() :  SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                ImageView(path: ImageConstants.locationIcon,
                  height: DimensionConstants.d24.h,
                  width: DimensionConstants.d24.w,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
                ),
                SizedBox(width: DimensionConstants.d16.w,),
                Expanded(
                  child:  Text(profileData.address ?? "").regularText(
                      context, DimensionConstants.d14.sp, TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis),
                )


              ],
            ),
          ),

        ],
      ),
    );
  }

}