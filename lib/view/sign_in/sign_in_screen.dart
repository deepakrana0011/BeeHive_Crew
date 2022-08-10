import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/decoration.dart';
import 'package:beehive/helper/validations.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/sign_in_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {


  const SignInScreen({Key? key,}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with TickerProviderStateMixin{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  SignInProvider provider = locator<SignInProvider>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        CommonWidgets.hideKeyboard(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.deepBlue,
        body: BaseView<SignInProvider>(
          onModelReady: (provider){
            this.provider = provider;
            provider.tabController = TabController(length: 2, vsync: this);
            provider.tabController!.addListener(() {
              provider.selectedIndex = provider.tabController!.index;
              emailController.clear();
              passwordController.clear();
              FocusScope.of(context).requestFocus(FocusNode());
              provider.emailContentPadding = false;
              provider.emailContentPadding1  = false;
              provider.passwordContentPadding = false;
              provider.passwordContentPadding1 = false;
              provider.updateLoadingStatus(true);
            });

          },
          builder: (context, provider, _){
            return SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: DimensionConstants.d72.h),
                    const Center(child: ImageView(path: ImageConstants.appLogo1)),
                    SizedBox(height: DimensionConstants.d60.h),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.0),
                          border: const Border(bottom: BorderSide(color: ColorConstants.colorGrey, width: 1.0))),
                      margin: EdgeInsets.only(left: DimensionConstants.d36.w, right: DimensionConstants.d44.w, bottom: DimensionConstants.d32.h),
                      child: TabBar(
                        onTap: (int i){
                          emailController.clear();
                          passwordController.clear();
                          provider.rememberMeValue = false;
                          if(i == 1){
                            provider.tab0 = false;
                            provider.tab1 = true;
                            provider.updateLoadingStatus(true);
                          } else if(i == 0){
                            provider.tab1 = false;
                            provider.tab0 = true;
                            provider.updateLoadingStatus(true);
                          }
                        },
                        controller: provider.tabController,
                        unselectedLabelColor: ColorConstants.deepBlue,
                        labelPadding: EdgeInsets.only(bottom: DimensionConstants.d13.h),
                        tabs: [
                        provider.tab0 ? Text("sign_in_".tr()).mediumText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite) :
                        Text("sign_in_".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite),
                          provider.tab1 ? Text("create_account".tr()).mediumText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite) :
                          Text("create_account".tr()).regularText(context, DimensionConstants.d16.sp, TextAlign.center, color: ColorConstants.colorWhite),
                        ],
                      ),
                    ),
                     Expanded(
                       child: Container(
                         alignment: Alignment.topCenter,
                         padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d32.w),
                         child: TabBarView(
                           physics: const NeverScrollableScrollPhysics(),
                          controller: provider.tabController,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("your_email".tr()).mediumText(context, DimensionConstants.d12.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                emailTextField(),
                                SizedBox(height: DimensionConstants.d32.h),
                                Text("your_password".tr()).mediumText(context, DimensionConstants.d12.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                passwordTextField(),
                                SizedBox(height: DimensionConstants.d27.h),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.4,
                                      child: Checkbox(
                                        side: const BorderSide(
                                          color: ColorConstants.colorWhite70, //your desire colour here
                                          width: 1.5,
                                        ),
                                        checkColor: ColorConstants.deepBlue,
                                        value: provider.rememberMeValue,
                                        onChanged: (bool? value) {
                                          provider.rememberMeValue = value!;
                                          provider.updateLoadingStatus(true);
                                        },
                                      ),
                                    ),
                                    Text("remember_me".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite),
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                      child: CommonWidgets.commonButton(context, "sign_in_".tr(), onBtnTap: (){
                                        // if(_formKey.currentState!.validate()){
                                        //
                                        // }
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                            RouteConstants.bottomNavigationBar,
                                                (route) => false);
                                      })),
                                ),
                                SizedBox(height: DimensionConstants.d10.h),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("your_email".tr()).mediumText(context, DimensionConstants.d12.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                emailTextField(),
                                SizedBox(height: DimensionConstants.d32.h),
                                Text("your_password".tr()).mediumText(context, DimensionConstants.d12.sp, TextAlign.center, color: ColorConstants.colorWhite70),
                                passwordTextField(),
                                SizedBox(height: DimensionConstants.d27.h),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.4,
                                      child: Checkbox(
                                        side: const BorderSide(
                                          color: ColorConstants.colorWhite70, //your desire colour here
                                          width: 1.5,
                                        ),
                                        checkColor: ColorConstants.deepBlue,
                                        value: provider.rememberMeValue,
                                        onChanged: (bool? value) {
                                          provider.rememberMeValue = value!;
                                          provider.updateLoadingStatus(true);
                                        },
                                      ),
                                    ),
                                    Text("remember_me".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center, color: ColorConstants.colorWhite),
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: CommonWidgets.commonButton(context, "create_account".tr(), onBtnTap: (){
                                        // if(_formKey.currentState!.validate()){
                                        //
                                        // }
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                            RouteConstants.bottomNavigationBar,
                                                (route) => false);
                                      })),
                                ),
                                SizedBox(height: DimensionConstants.d10.h),
                              ],
                            ),
                          ],
                    ),
                       ),
                     ),


                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget emailTextField(){
    return  TextFormField(
      focusNode: emailFocusNode,
      controller: emailController,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d18.sp, FontWeight.w400, ColorConstants.colorWhite),
      decoration: ViewDecoration.inputDecorationTextField(contPadding: provider.selectedIndex == 0 ? provider.emailContentPadding : provider.emailContentPadding1),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          if(provider.selectedIndex == 0){
            provider.emailContentPadding = true;
          } else{
            provider.emailContentPadding1 = true;
          }
        } else{
          if(provider.selectedIndex == 0){
            provider.emailContentPadding = false;
          } else{
            provider.emailContentPadding1 = false;
          }
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

  Widget passwordTextField(){
    return  TextFormField(
      focusNode: passwordFocusNode,
      controller: passwordController,
      obscureText: !provider.passwordVisible,
      style: ViewDecoration.textFieldStyle(DimensionConstants.d18.sp, FontWeight.w400, ColorConstants.colorWhite),
      decoration: ViewDecoration.inputDecorationTextField(contPadding: provider.selectedIndex == 0 ? provider.passwordContentPadding : provider.passwordContentPadding1, suffixIcon:  IconButton(
        padding: EdgeInsets.zero,
        icon: const ImageView(
          path: ImageConstants.eyeIcon,
        ),
        onPressed: () {
          provider.passwordVisible = !provider.passwordVisible;
          provider.updateLoadingStatus(true);
        },
      )),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          if(provider.selectedIndex == 0){
            provider.passwordContentPadding = true;
          } else{
            provider.passwordContentPadding1 = true;
          }
        } else{
          if(provider.selectedIndex == 0){
            provider.passwordContentPadding = false;
          } else{
            provider.passwordContentPadding1 = false;
          }
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
