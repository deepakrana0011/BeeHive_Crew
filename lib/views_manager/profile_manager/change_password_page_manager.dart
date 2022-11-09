import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/provider/change_password_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/image_constants.dart';
import '../../helper/decoration.dart';
import '../../widget/image_view.dart';

class ChangePasswordPageManager extends StatelessWidget {
  ChangePasswordPageManager({Key? key}) : super(key: key);

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final renewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    var appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(context,
          title: "change_password".tr(),
          actionButtonRequired: false, popFunction: () {
        CommonWidgets.hideKeyboard(context);
        Navigator.pop(context);
      }),
      body: BaseView<ChangePasswordManagerProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      statusBarHeight -
                      appBarHeight,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionConstants.d16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: DimensionConstants.d24.h,
                          ),
                          Text("old_password".tr()).boldText(context,
                              DimensionConstants.d16.sp, TextAlign.left,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack),
                          SizedBox(
                            height: DimensionConstants.d8.h,
                          ),
                          oldPasswordTextField(provider, context),
                          SizedBox(
                            height: DimensionConstants.d16.h,
                          ),
                          Text("new_password".tr()).boldText(context,
                              DimensionConstants.d16.sp, TextAlign.left,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack),
                          SizedBox(
                            height: DimensionConstants.d8.h,
                          ),
                          newPasswordTextField(provider, context),
                          //  textFiledName(context, "old_password", "*********", oldPasswordController),
                          SizedBox(
                            height: DimensionConstants.d16.h,
                          ),
                          Text("re_enter_new_password".tr()).boldText(context,
                              DimensionConstants.d16.sp, TextAlign.left,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack),
                          SizedBox(
                            height: DimensionConstants.d8.h,
                          ),
                          confirmPasswordTextField(provider, context),
                          // textFiledName(context, "new_password", "*********", newPasswordController),
                          /* SizedBox(height: DimensionConstants.d16.h,),
                          textFiledName(context, "re_enter_new_password", "*********", renewPasswordController),*/
                          const Spacer(),
                          CommonWidgets.commonButton(
                              context, "change_password".tr(),
                              color1: ColorConstants.primaryGradient2Color,
                              color2: ColorConstants.primaryGradient1Color,
                              fontSize: DimensionConstants.d14.sp,
                              onBtnTap: () {
                            CommonWidgets.hideKeyboard(context);
                            newPasswordFocus = true;
                            confirmPasswordFocus = true;
                            oldPasswordFocus = true;
                            if (_formKey.currentState!.validate()) {
                              CommonWidgets.hideKeyboard(context);
                              if (newPasswordController.text ==
                                  renewPasswordController.text) {
                                provider.changePassword(
                                    context,
                                    oldPasswordController.text,
                                    newPasswordController.text);
                              } else {
                                DialogHelper.showMessage(
                                    context, "Password not match");
                              }
                            }
                          },
                              /*if(oldPasswordController.text.trim().isEmpty || newPasswordController.text.trim().isEmpty
                                || renewPasswordController.text.trim().isEmpty){
                              DialogHelper.showMessage(context, "all_fields_required".tr());
                            } else if (!Validations.validateStructure(oldPasswordController.text.trim())
                                || !Validations.validateStructure(newPasswordController.text.trim()) ||
                                !Validations.validateStructure(renewPasswordController.text.trim())) {
                              DialogHelper.showMessage(context, "invalid_password_format".tr());
                            } else if(newPasswordController.text.trim() != renewPasswordController.text.trim()){
                              DialogHelper.showMessage(context, "new_password_not_matched".tr());
                            } else{
                              provider.changePassword(context, oldPasswordController.text, newPasswordController.text).then((value){
                              });

                            }
                          },*/
                              shadowRequired: true),
                          SizedBox(
                            height: DimensionConstants.d57.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                provider.state == ViewState.busy
                    ? const CustomCircularBar()
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }

  bool? oldPasswordFocus;
  bool? newPasswordFocus;
  bool? confirmPasswordFocus;

  Widget oldPasswordTextField(
      ChangePasswordManagerProvider provider, BuildContext context) {
    return TextFormField(
      controller: oldPasswordController,
      obscureText: !provider.oldPasswordVisible,
      focusNode: provider.oldPassWordFocusNode,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp,
          FontWeight.w400, ColorConstants.colorBlack),
      cursorColor: Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorWhite
          : ColorConstants.colorBlack,
      decoration: ViewDecoration.inputDecorationBoxPassword(
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: EdgeInsets.zero,
            icon: ImageView(
              path: provider.oldPasswordVisible
                  ? ImageConstants.eyeIcon
                  : ImageConstants.passwordHideIcon,
            ),
            onPressed: () {
              provider.oldPasswordVisible = !provider.oldPasswordVisible;
              provider.updateLoadingStatus(true);
            },
          ),
          radius: DimensionConstants.d8.r,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorWhite
              : ColorConstants.grayF3F3F3,
          showError: oldPasswordFocus == null
              ? provider.oldPassWordFocusNode.hasFocus
              : oldPasswordFocus!),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          oldPasswordFocus = false;
          provider.oldPasswordContentPadding = true;
        } else {
          oldPasswordFocus = true;
          provider.oldPasswordContentPadding = false;
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

  Widget newPasswordTextField(
      ChangePasswordManagerProvider provider, BuildContext context) {
    return TextFormField(
      controller: newPasswordController,
      obscureText: !provider.newPasswordVisible,
      focusNode: provider.newPasswordFocusNode,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp,
          FontWeight.w400, ColorConstants.colorBlack),
      cursorColor: Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorWhite
          : ColorConstants.colorBlack,
      decoration: ViewDecoration.inputDecorationBoxPassword(
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
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
          radius: DimensionConstants.d8.r,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorWhite
              : ColorConstants.grayF3F3F3,
          showError: oldPasswordFocus == null
              ? provider.oldPassWordFocusNode.hasFocus
              : oldPasswordFocus!),
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

  Widget confirmPasswordTextField(
      ChangePasswordManagerProvider provider, BuildContext context) {
    return TextFormField(
      controller: renewPasswordController,
      obscureText: !provider.confirmPasswordVisible,
      focusNode: provider.confirmPasswordFocusNode,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d16.sp,
          FontWeight.w400, ColorConstants.colorBlack),
      cursorColor: Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorWhite
          : ColorConstants.colorBlack,
      decoration: ViewDecoration.inputDecorationBoxPassword(
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
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
          radius: DimensionConstants.d8.r,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorWhite
              : ColorConstants.grayF3F3F3,
          showError: oldPasswordFocus == null
              ? provider.oldPassWordFocusNode.hasFocus
              : oldPasswordFocus!),
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

/*Widget textFiledName(BuildContext context, String title, String hintName, TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title.tr()).boldText(
            context, DimensionConstants.d16.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack),
        SizedBox(
          height: DimensionConstants.d8.h,
        ),
        Container(
          height: DimensionConstants.d45.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.grayF3F3F3
                : ColorConstants.colorBlack,
            border: Theme.of(context).brightness == Brightness.dark
                ? Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : Colors.transparent)
                : null,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: TextFormField(
            controller: controller,
            cursorColor: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack,
            maxLines: 1,
            decoration: ViewDecoration.inputDecorationBox(
              fieldName: hintName.tr(),
              radius: DimensionConstants.d8.r,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.grayF3F3F3,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorBlack
                  : ColorConstants.grayF3F3F3,
              hintTextColor: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack,
              hintTextSize: DimensionConstants.d16.sp,
            ),
          ),
        )
      ],
    ),
  );
}*/
