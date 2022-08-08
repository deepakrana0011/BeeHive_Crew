import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/decoration.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/continue_with_phone_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ContinueWithPhone extends StatelessWidget {
  ContinueWithPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ContinueWithPhoneProvider>(builder: (context, provider, _) {
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
                              phoneNumberWidget(provider.phoneNumberController),
                              SizedBox(height: DimensionConstants.d25.h),
                              Align(
                                alignment: Alignment.center,
                                child: Text("continue_with_email".tr()).regularText(context,
                                    DimensionConstants.d14.sp, TextAlign.center,
                                    color: ColorConstants.colorBlack,
                                    decoration: TextDecoration.underline
                                ),
                              ),
                              SizedBox(height: DimensionConstants.d50.h),
                              CommonWidgets.commonButton(context, "continue".tr(),
                                  onBtnTap: () {
                                  Navigator.pushNamed(context, RouteConstants.otpVerificationPage);
                              })
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

Widget phoneNumberWidget(TextEditingController controller) {
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
          onInputChanged: (value) {},
          formatInput: true,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
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
          left: DimensionConstants.d105.w,
          child: Container(
            height: DimensionConstants.d25.h,
            width: DimensionConstants.d2.w,
            color: ColorConstants.grayD2D2D7,
          ))
    ],
  );
}
