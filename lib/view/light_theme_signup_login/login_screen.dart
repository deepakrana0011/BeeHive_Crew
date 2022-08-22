import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/decoration.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/login_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/light_theme_signup_login/email_address_screen.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginProvider>(

        builder: (context, provider, _){
          return GestureDetector(
            onTap: (){
              CommonWidgets.hideKeyboard(context);
            },
            child: Scaffold(
              backgroundColor: ColorConstants.colorWhite,
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
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
                                        SizedBox(height: DimensionConstants.d75.h),
                                        SizedBox(
                                          width: DimensionConstants.d242.w,
                                          child: Text("login".tr()).boldText(context, DimensionConstants.d30.sp, TextAlign.left, color: ColorConstants.colorBlack),
                                        ),
                                        SizedBox(height: DimensionConstants.d42.h),
                                        Text("your_email".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                        emailTextField(provider),
                                        SizedBox(height: DimensionConstants.d24.h),
                                        Text("your_password".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                        passwordTextField(provider),
                                        SizedBox(height: DimensionConstants.d16.h),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pushNamed(context, RouteConstants.resetPasswordScreen);
                                          },
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("forgot_password".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorBlack,decoration: TextDecoration.underline),
                                          ),
                                        ),
                                        SizedBox(height: DimensionConstants.d29.h),
                                        CommonWidgets.commonButton(context, "login".tr(), onBtnTap: (){
                                          CommonWidgets.hideKeyboard(context);
                                          Navigator.pushNamed(context, RouteConstants.bottomNavigationBar,);
                                        },shadowRequired: true),
                                        SizedBox(height: DimensionConstants.d16.h),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pushNamed(context, RouteConstants.emailAddressScreen,arguments: EmailAddressScreen(fromForgotPassword: false,));
                                          },
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("sign_up".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorBlack,decoration: TextDecoration.underline),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget emailTextField(LoginProvider provider){
    return  TextFormField(
      cursorColor: ColorConstants.colorWhite70,
      focusNode: emailFocusNode,
      controller: emailController,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp, FontWeight.w400, ColorConstants.colorBlack),
      decoration: ViewDecoration.inputDecorationTextField(contPadding: provider.emailContentPadding, fillColor: ColorConstants.colorWhite),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          provider.emailContentPadding = true;
        } else{
          provider.emailContentPadding = false;
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

  Widget passwordTextField(LoginProvider provider){
    return  TextFormField(
      cursorColor: ColorConstants.colorWhite70,
      focusNode: passwordFocusNode,
      controller: passwordController,
      obscureText: !provider.passwordVisible,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp, FontWeight.w400, ColorConstants.colorBlack),
      decoration: ViewDecoration.inputDecorationTextField(contPadding: provider.passwordContentPadding, suffixIcon:  IconButton(
        padding: EdgeInsets.zero,
        icon: const ImageView(
          path: ImageConstants.eyeIcon,
        ),
        onPressed: () {
          provider.passwordVisible = !provider.passwordVisible;
          provider.updateLoadingStatus(true);
        },
      ), fillColor: ColorConstants.colorWhite),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          provider.passwordContentPadding = true;
        } else{
          provider.passwordContentPadding = false;
        }
        provider.updateLoadingStatus(true);
      },
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "password_required".tr();
        } else if (!Validations.validateStructure(
            value)) {
          return "invalid_password_format".tr();
        }
        {
          return null;
        }
      },
    );
  }
}
