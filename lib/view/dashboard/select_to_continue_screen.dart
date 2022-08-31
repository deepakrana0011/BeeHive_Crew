import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/view/light_theme_signup_login/email_address_screen.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/email_address_screen_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectToContinueScreen extends StatelessWidget {
  const SelectToContinueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.deepBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: DimensionConstants.d70.h),
              Text("select_to_continue_registration_or_login".tr()).semiBoldText(context, DimensionConstants.d25.sp, TextAlign.center, color: ColorConstants.colorWhite),
              SizedBox(height: DimensionConstants.d60.h),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: const [
                    ImageView(
                      path: ImageConstants.introEllipse,
                    ),
                    Positioned(
                      bottom: -20,
                      right: -35,
                      child:  ImageView(
                        path: ImageConstants.introduction4,
                      ),)
                  ],
                ),
              ),
              SizedBox(height: DimensionConstants.d60.h),
              CommonWidgets.commonButton(context, "crew".tr(), fontSize: DimensionConstants.d20.sp, onBtnTap: (){
                SharedPreference.prefs!.setBool(SharedPreference.INTRODUCTION_COMPLETE, true);
                Navigator.pushNamed(context, RouteConstants.emailAddressScreen,arguments: EmailAddressScreen(fromForgotPassword: false, routeForResetPassword: 1,));
              }),
              SizedBox(height: DimensionConstants.d25.h),
              CommonWidgets.commonButton(context, "manager".tr(), fontSize: DimensionConstants.d20.sp,onBtnTap: (){
                SharedPreference.prefs!.setBool(SharedPreference.INTRODUCTION_COMPLETE, true);
                Navigator.pushNamed(context, RouteConstants.emailAddressScreenManager,arguments: EmailAddressScreenManager(fromForgotPassword: false, routeForResetPassword: true,));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
