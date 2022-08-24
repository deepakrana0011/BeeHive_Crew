import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/otp_page_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../constants/image_constants.dart';
import '../../helper/common_widgets.dart';
import '../../widget/image_view.dart';

class OtpVerificationPage extends StatelessWidget {
  String phoneNumber;
  bool continueWithPhoneOrEmail;
  bool routeForResetPassword;
   OtpVerificationPage({Key? key,required this.phoneNumber,required this.continueWithPhoneOrEmail,required this.routeForResetPassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OtpPageProvider>(
        onModelReady: (provider) {},
        builder: (context, provider, _) {
          return Scaffold(
            body: Column(
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
                                child: Text(continueWithPhoneOrEmail == true?"verify_phone".tr():"verify_email".tr()).boldText(
                                    context,
                                    DimensionConstants.d30.sp,
                                    TextAlign.left,
                                    color: ColorConstants.colorBlack),
                              ),
                              SizedBox(height: DimensionConstants.d18.h),
                               Text("Code sent to ""$phoneNumber")
                                  .boldText(
                                context,
                                DimensionConstants.d16.sp,
                                TextAlign.center,
                                color: ColorConstants.colorBlack,
                              ),
                              SizedBox(height: DimensionConstants.d60.h),
                              optFiled(context, provider),
                              SizedBox(height: DimensionConstants.d25.h),
                              Align(
                                alignment: Alignment.center,
                                child: Text("resend_code".tr()).regularText(
                                    context,
                                    DimensionConstants.d14.sp,
                                    TextAlign.center,
                                    color: ColorConstants.colorBlack,
                                    decoration: TextDecoration.underline),
                              ),
                              SizedBox(height: DimensionConstants.d35.h),
                             provider.state == ViewState.idle? CommonWidgets.commonButton(
                                  context, continueWithPhoneOrEmail == true?"verify_phone".tr():"verify_email".tr(), onBtnTap: () {
                                    if(provider.otp == ""){
                                      DialogHelper.showMessage(context, "Please enter OTP");
                                    }else{
                                    continueWithPhoneOrEmail == true? provider.otpVerificationCrew(context, phoneNumber,routeForResetPassword):provider.verifyEmailForOtp(context, phoneNumber);
                                    }

                              }, shadowRequired: true):Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,),),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ],
            ),
          );
        });
  }
}

Widget optFiled(
  BuildContext context,
  OtpPageProvider provider,
) {
  return OtpTextField(

    fieldWidth: DimensionConstants.d60.w,
    numberOfFields: 4,
    cursorColor: ColorConstants.primaryColor,
    borderColor: ColorConstants.grayD2D2D7,
    showFieldAsBox: true,
    textStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: DimensionConstants.d20.sp,
    ),
    focusedBorderColor: ColorConstants.primaryColor,
    enabled: true,
    borderRadius: BorderRadius.circular(DimensionConstants.d20.r),
    onCodeChanged: (String code) {

    },
    onSubmit: (String verificationCode) {
      provider.updateProvider(verificationCode);
  }, // end onSubmit
  );
}
