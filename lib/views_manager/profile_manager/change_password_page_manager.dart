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
import '../../helper/decoration.dart';

class ChangePasswordPageManager extends StatelessWidget {
  ChangePasswordPageManager({Key? key}) : super(key: key);

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final renewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CommonWidgets.appBarWithTitleAndAction(context,title: "change_password".tr(),actionButtonRequired: false,popFunction: () { CommonWidgets.hideKeyboard(context);
      Navigator.pop(context);}),
      body: BaseView<ChangePasswordManagerProvider>(
        builder: (context, provider, _){
          return provider.state == ViewState.busy ? const CustomCircularBar() : Column(
            children:<Widget> [
              SizedBox(height: DimensionConstants.d24.h,),
              textFiledName(context, "old_password", "*********", oldPasswordController),
              SizedBox(height: DimensionConstants.d16.h,),
              textFiledName(context, "new_password", "*********", newPasswordController),
              SizedBox(height: DimensionConstants.d16.h,),
              textFiledName(context, "re_enter_new_password", "*********", renewPasswordController),
              SizedBox(height: DimensionConstants.d335.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: CommonWidgets.commonButton(
                    context, "change_password".tr(),
                    color1: ColorConstants.primaryGradient2Color,
                    color2: ColorConstants.primaryGradient1Color,
                    fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                  if(oldPasswordController.text.trim().isEmpty || newPasswordController.text.trim().isEmpty
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
                },
                    shadowRequired: true
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}

Widget textFiledName(BuildContext context, String title, String hintName, TextEditingController controller) {
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
}

