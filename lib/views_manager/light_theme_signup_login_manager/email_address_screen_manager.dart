

import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/decoration.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/light_theme_signup_login/sign_up_screen.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/sign_up_screen_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAddressScreenManager extends StatelessWidget {
  EmailAddressScreenManager({Key? key, this.fromForgotPassword}) : super(key: key);
  bool? fromForgotPassword;
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  bool contPadding = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<BaseProvider>(builder: (context, provider, _){
      return Scaffold(
        backgroundColor: ColorConstants.colorWhite,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const ImageView(path: ImageConstants.lightThemeSignUpBg),
                  Positioned(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: DimensionConstants.d44.h,
                                left: DimensionConstants.d24.w),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SizedBox(
                                  width: DimensionConstants.d24.w,
                                  height: DimensionConstants.d24.h,
                                  child: const ImageView(
                                      path: ImageConstants.backIcon, fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d32.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: DimensionConstants.d100.h),
                                SizedBox(
                                  width: DimensionConstants.d242.w,
                                  child: fromForgotPassword == true ?  Text("continue_with_email".tr()).boldText(context, DimensionConstants.d30.sp, TextAlign.left, color: ColorConstants.colorBlack)
                                 : Text("whats_your_email_address".tr()).boldText(context, DimensionConstants.d30.sp, TextAlign.left, color: ColorConstants.colorBlack),
                                ),
                                SizedBox(height: DimensionConstants.d32.h),
                               fromForgotPassword == true ? Text("enter_email".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite70)
                                   : Text("your_email".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                emailTextField(provider),
                                SizedBox(height: DimensionConstants.d39.h),
                                CommonWidgets.commonButton(context, "continue".tr(), onBtnTap: (){
                                  Navigator.pushNamed(context, RouteConstants.signUpScreenManager, arguments: SignUpScreenManager(email: emailController.text));
                                  // if(_formKey.currentState!.validate()){
                                  //
                                  // }
                                },shadowRequired: true)
                              ],
                            ),
                          )
                        ],
                      ),
                  )
                ],
              ),

            ],
          ),
        ),
      );
    });
  }

  Widget emailTextField(BaseProvider provider){
    return  TextFormField(
      focusNode: emailFocusNode,
      controller: emailController,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp, FontWeight.w400, ColorConstants.colorBlack),
      decoration: ViewDecoration.inputDecorationTextField(fillColor: ColorConstants.colorWhite, focusColor: ColorConstants.colorBlack, contPadding: contPadding,
        suffixIcon: fromForgotPassword == true ? null : IconButton(
        padding: EdgeInsets.zero,
        icon: const ImageView(
        path: ImageConstants.circleCloseIcon,
      ),
      onPressed: () {
       emailController.clear();
       contPadding = false;
        provider.updateLoadingStatus(true);
      },
    )),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          contPadding = true;
        } else{
          contPadding = false;
        }
        provider.updateLoadingStatus(true);
      },
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "email_required".tr();
        } else if (!Validations.emailValidation(
            value.trim())) {
          return "invalid_email".tr();
        } else {
          return null;
        }
      },
    );
  }
}
