import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/continue_with_phone_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/email_address_screen_manager.dart';
import 'package:beehive/views_manager/light_theme_signup_login_manager/otp_verification_page_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../helper/dialog_helper.dart';

class ContinueWithPhoneManager extends StatelessWidget {
  int routeForResetPassword;
  ContinueWithPhoneManager({Key? key,required this.routeForResetPassword}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<ContinueWithPhoneManagerProvider>(
        builder: (context, provider, _) {
      return GestureDetector(
        onTap: () {
          CommonWidgets.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: ColorConstants.colorWhite,
          body: Form(
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
                                child: Text("continue_with_phone".tr())
                                    .boldText(
                                        context,
                                        DimensionConstants.d30.sp,
                                        TextAlign.left,
                                        color: ColorConstants.colorBlack),
                              ),
                              SizedBox(height: DimensionConstants.d42.h),
                              Text("enter_phone_number".tr()).boldText(context,
                                  DimensionConstants.d14.sp, TextAlign.center,
                                  color: ColorConstants.colorWhite70),
                              SizedBox(height: DimensionConstants.d42.h),
                              phoneNumberWidget(provider.phoneNumberController,provider),
                              SizedBox(height: DimensionConstants.d25.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      RouteConstants.emailAddressScreenManager,
                                      arguments: EmailAddressScreenManager(
                                        fromForgotPassword: true, routeForResetPassword: true,
                                      ));
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("continue_with_email".tr())
                                      .regularText(
                                          context,
                                          DimensionConstants.d14.sp,
                                          TextAlign.center,
                                          color: ColorConstants.colorBlack,
                                          decoration: TextDecoration.underline),
                                ),
                              ),
                              SizedBox(height: DimensionConstants.d50.h),
                            provider.state == ViewState.idle?  CommonWidgets.commonButton(
                                  context, "continue".tr(), onBtnTap: () {
                                if (provider
                                    .phoneNumberController.text.isEmpty) {
                                  DialogHelper.showMessage(context,
                                      "mobile_number_cant_be_empty".tr());
                                } else {
                                 routeForResetPassword == 1? provider.phoneVerification(context):provider.resetPasswordByPhone(context);
                                }
                              }, shadowRequired: true):Center(child: const CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,),)
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
      );
    });
  }
}

Widget phoneNumberWidget(TextEditingController controller, ContinueWithPhoneManagerProvider provider) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: ColorConstants.grayD2D2D7,
                    width: DimensionConstants.d2.w))),
        child: InternationalPhoneNumberInput(
          textFieldController: controller,
          onInputChanged: (value) {
            provider.getDialCode(value.dialCode!);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          formatInput: false,
          selectorTextStyle: TextStyle(
              fontSize: DimensionConstants.d20.sp, fontWeight: FontWeight.w700),
          inputDecoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: DimensionConstants.d15.h,
                right: DimensionConstants.d10.w,
              ),
              border: InputBorder.none,
              hintText: "mobileNumber".tr(),
              hintStyle: TextStyle(
                color: ColorConstants.colorBlack,
                fontSize: DimensionConstants.d18.sp,
              )),
        ),
      ),
      Positioned(
          top: DimensionConstants.d12.h,
          left: DimensionConstants.d100.w,
          child: Row(
            children: [
              ImageView(
                path: ImageConstants.dropDownPhoneIcon,
                width: DimensionConstants.d9.w,
                height: DimensionConstants.d6.h,
              ),
              SizedBox(
                width: DimensionConstants.d6.w,
              ),
              Container(
                height: DimensionConstants.d25.h,
                width: DimensionConstants.d2.w,
                color: ColorConstants.grayD2D2D7,
              ),
            ],
          ))
    ],
  );
}
