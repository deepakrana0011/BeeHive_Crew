import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/decoration.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/provider/sign_up_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  final nameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  SignUpProvider provider = locator<SignUpProvider>();
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpProvider>(
      onModelReady: (provider){
        this.provider = provider;
      },
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
                                      child: Text("sign_up".tr()).boldText(context, DimensionConstants.d30.sp, TextAlign.left, color: ColorConstants.colorBlack),
                                    ),
                                    SizedBox(height: DimensionConstants.d16.h),
                                    Text(email).regularText(context, DimensionConstants.d16.sp, TextAlign.left, color: ColorConstants.colorBlack),
                                    SizedBox(height: DimensionConstants.d49.h),
                                    Text("your_name".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                    nameTextField(provider),
                                    SizedBox(height: DimensionConstants.d24.h),
                                    Text("your_password".tr()).boldText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                    passwordTextField(provider),
                                    SizedBox(height: DimensionConstants.d39.h),
                                   provider.state == ViewState.idle? CommonWidgets.commonButton(context, "sign_up_".tr(), onBtnTap: (){
                                      if(_formKey.currentState!.validate()){
                                      provider.signUpCrew(context, email);
                                      }else{
                                      }
                                    },shadowRequired: true):Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,),),
                                    SizedBox(height: DimensionConstants.d20.h),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, RouteConstants.loginScreen);
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("login".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorBlack,decoration: TextDecoration.underline),
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

  Widget nameTextField(SignUpProvider provider){
    return  TextFormField(
      cursorColor: ColorConstants.colorWhite70,
      focusNode: nameFocusNode,
      controller: provider.nameController,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp, FontWeight.w400, ColorConstants.colorBlack),
      decoration: ViewDecoration.inputDecorationTextField(contPadding: provider.nameContentPadding, fillColor: ColorConstants.colorWhite),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
            provider.nameContentPadding = true;
        } else{
            provider.nameContentPadding = false;
        }
        provider.updateLoadingStatus(true);
      },
    );
  }

  Widget passwordTextField(SignUpProvider provider){
    return  TextFormField(
      cursorColor: ColorConstants.colorWhite70,
      focusNode: passwordFocusNode,
      controller: provider.passwordController,
      obscureText: !provider.passwordVisible,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp, FontWeight.w400, ColorConstants.colorBlack),
      decoration: ViewDecoration.inputDecorationTextField(contPadding: provider.passwordContentPadding, suffixIcon:  IconButton(
        padding: EdgeInsets.zero,
        icon:ImageView(
          path: provider.passwordVisible ? ImageConstants.eyeIcon:ImageConstants.passwordHideIcon,
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
