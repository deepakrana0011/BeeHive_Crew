import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/decoration.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/reset_password_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatelessWidget {
  String? authToken;
  ResetPasswordScreen({Key? key,this.authToken}) : super(key: key);

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordProvider>(builder: (context, provider, _) {
      return GestureDetector(
        onTap: () {
          CommonWidgets.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: ColorConstants.colorWhite,
          body: Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          const ImageView(
                              path: ImageConstants.lightThemeSignUpBg),
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
                                          path: ImageConstants.backIcon,
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: DimensionConstants.d32.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: DimensionConstants.d75.h),
                                    SizedBox(
                                      width: DimensionConstants.d242.w,
                                      child: Text("reset_password".tr())
                                          .boldText(
                                              context,
                                              DimensionConstants.d30.sp,
                                              TextAlign.left,
                                              color: ColorConstants.colorBlack),
                                    ),
                                    SizedBox(height: DimensionConstants.d59.h),
                                    Text("new_password_".tr()).boldText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.center,
                                        color: ColorConstants.colorWhite70),
                                    newPasswordTextField(provider),
                                    SizedBox(height: DimensionConstants.d24.h),
                                    Text("confirm_new_password".tr()).boldText(
                                        context,
                                        DimensionConstants.d14.sp,
                                        TextAlign.center,
                                        color: ColorConstants.colorWhite70),
                                    confirmPasswordTextField(provider),
                                    SizedBox(height: DimensionConstants.d64.h),
                                    CommonWidgets.commonButton(
                                        context, "reset_password".tr(),
                                        onBtnTap: () {
                                          CommonWidgets.hideKeyboard(context);
                                          newPasswordFocus = true;
                                          confirmPasswordFocus = true;
                                      if (_formKey.currentState!.validate()) {
                                        CommonWidgets.hideKeyboard(context);
                                        if (newPasswordController.text ==
                                            confirmPasswordController.text) {
                                          provider.resetPasswordCrew(context,
                                              newPasswordController.text,authToken!);
                                        } else {
                                          DialogHelper.showMessage(
                                              context, "Password not match");
                                        }
                                      }
                                    }, shadowRequired: true)
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
              if (provider.state == ViewState.busy) const CustomCircularBar()
            ],
          ),
        ),
      );
    });
  }

  bool? newPasswordFocus;
  bool? confirmPasswordFocus;

  Widget newPasswordTextField(ResetPasswordProvider provider) {
    return TextFormField(
      cursorColor: ColorConstants.colorWhite70,
      controller: newPasswordController,
      focusNode: newPasswordFocusNode,
      obscureText: !provider.newPasswordVisible,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp,
          FontWeight.w400, ColorConstants.colorBlack),
      decoration: ViewDecoration.inputDecorationTextField(
          contPadding: provider.newPasswordContentPadding,
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            icon: ImageView(
              path: provider.newPasswordVisible
                  ? ImageConstants.eyeIcon
                  : ImageConstants.passwordHideIcon,
            ),
            onPressed: () {
              provider.newPasswordVisible = !provider.newPasswordVisible;
              provider.updateLoadingStatus(true);
            },
          ),
          fillColor: ColorConstants.colorWhite, showError: newPasswordFocus ?? !newPasswordFocusNode.hasFocus),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          newPasswordFocus = false;
          provider.newPasswordContentPadding = true;
        } else {
          newPasswordFocus = true;
          provider.newPasswordContentPadding = false;
        }
        provider.updateLoadingStatus(true);
      },
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "password_required".tr();
        } else if (!Validations.validateStructure(value)) {
          return "invalid_password_format".tr();
        }
        {
          return null;
        }
      },
    );
  }

  Widget confirmPasswordTextField(ResetPasswordProvider provider) {
    return TextFormField(
      cursorColor: ColorConstants.colorWhite70,
      controller: confirmPasswordController,
      focusNode: confirmPasswordFocusNode,
      obscureText: !provider.confirmPasswordVisible,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp,
          FontWeight.w400, ColorConstants.colorBlack),
      decoration: ViewDecoration.inputDecorationTextField(
          contPadding: provider.confirmPasswordContentPadding,
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            icon: ImageView(
              path: provider.confirmPasswordVisible
                  ? ImageConstants.eyeIcon
                  : ImageConstants.passwordHideIcon,
            ),
            onPressed: () {
              provider.confirmPasswordVisible =
                  !provider.confirmPasswordVisible;
              provider.updateLoadingStatus(true);
            },
          ),
          fillColor: ColorConstants.colorWhite, showError: confirmPasswordFocus ?? !confirmPasswordFocusNode.hasFocus),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          confirmPasswordFocus = false;
          provider.confirmPasswordContentPadding = true;
        } else {
          confirmPasswordFocus = true;
          provider.confirmPasswordContentPadding = false;
        }
        provider.updateLoadingStatus(true);
      },
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "password_required".tr();
        } else if (!Validations.validateStructure(value)) {
          return "invalid_password_format".tr();
        }
        {
          return null;
        }
      },
    );
  }
}
