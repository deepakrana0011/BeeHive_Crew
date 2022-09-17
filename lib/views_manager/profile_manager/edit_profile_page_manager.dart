import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/edit_profile_provider.dart';
import 'package:beehive/provider/profile_page_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';

import '../../helper/decoration.dart';
import '../../helper/dialog_helper.dart';
import '../../widget/custom_switcher.dart';

class EditProfilePageManager extends StatefulWidget {
  const EditProfilePageManager({Key? key}) : super(key: key);

  @override
  State<EditProfilePageManager> createState() { return _EditProfilePageManagerState();}
}

class _EditProfilePageManagerState extends State<EditProfilePageManager> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilePageManagerProvider>(
      onModelReady: (provider) async {
      await  provider.getManagerProfile(context).then((value) => {
        provider.setEditProfilePageController(),
      });


      },
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "edit_profile", actionButtonRequired: false,popFunction: () { CommonWidgets.hideKeyboard(context);
              Navigator.pop(context);}),
          body: SingleChildScrollView(
            child: provider.state == ViewState.idle? Column(
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d17.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    profilePic(
                      context,
                      () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              DialogHelper.getPhotoDialog(
                            context,
                            photoFromCamera: () {
                              provider.addProfilePic(context, 1, 1);
                            },
                            photoFromGallery: () {
                              provider.addProfilePic(context, 2, 1);
                            },
                          ),
                        );
                        provider.updateImageChanged();
                      },
                      provider.profileImage,
                      "change_photo",
                      ImageConstants.emptyImageIcon,
                    ),
                    SizedBox(
                      width: DimensionConstants.d40.w,
                    ),
                    profilePic(
                      context,
                      () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DialogHelper.getPhotoDialog(
                                  context,
                                  photoFromCamera: () {
                                    provider.addProfilePic(context, 1, 2);
                                  },
                                  photoFromGallery: () {
                                    provider.addProfilePic(context, 2, 2);
                                  },
                                ));
                        provider.updateCompanyLogoChanged();
                      },
                      SharedPreference.prefs!.getString(SharedPreference.DashBoardIcon)== null? "": SharedPreference.prefs!.getString(SharedPreference.DashBoardIcon)!,
                      "change_logo",
                      ImageConstants.emptyLogo,
                    ),
                  ],
                ),
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                textFiledName(context, "name", "John Smith",provider.nameController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(context, "title", "Carpenter",provider.titleController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(context, "company", "Construction ltd.",provider.companyController),
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d16.w),
                  child: Row(
                    children: <Widget>[
                      Text("custom_colour".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.left,
                          color: ColorConstants.colorBlack),
                      Expanded(child: Container()),
                      Text("default_blue".tr()).regularText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: ColorConstants.colorBlack),
                      SizedBox(
                        width: DimensionConstants.d6.w,
                      ),
                      CustomSwitch(
                        value: provider.status,
                        onChanged: (value) {
                          provider.updateSwitcherStatus(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d13.h,
                ),
                provider.status == false
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensionConstants.d16.w),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: DimensionConstants.d40.h,
                              width: DimensionConstants.d40.w,
                              decoration: BoxDecoration(
                                  color: provider.currentColor.toColor(),
                                  borderRadius: BorderRadius.circular(
                                      DimensionConstants.d8.r)),
                            ),
                            SizedBox(
                              width: DimensionConstants.d21.w,
                            ),
                            SizedBox(
                                height: DimensionConstants.d15.h,
                                width: DimensionConstants.d282.w,
                                child: HuePicker(
                                  thumbShape: RoundSliderThumbShape(
                                    disabledThumbRadius:
                                        DimensionConstants.d10.r,
                                    elevation: 4,
                                    enabledThumbRadius:
                                        DimensionConstants.d10.r,
                                  ),
                                  initialColor: HSVColor.fromColor(Colors.green),
                                  onChanged: provider.updateColor,
                                )),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: DimensionConstants.d12.h,
                ),
                Container(
                  height: DimensionConstants.d1.h,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.grayE0E0E0,
                ),
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                textFiledName(context, "phone", "123-555-2514",provider.phoneController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(context, "email", "johnsmith@gmail.com",provider.emailController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(
                    context, "address", "88 Bloor St E. Toronto, ON, M4W3G9",provider.addressController),
                SizedBox(
                  height: DimensionConstants.d38.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d16.w),
                  child: CommonWidgets.commonButton(context, "save".tr(),
                      color1: ColorConstants.primaryGradient2Color,
                      color2: ColorConstants.primaryGradient1Color,
                      fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                    provider.updateProfileManager(context);

                  }, shadowRequired: true),
                ),
                SizedBox(
                  height: DimensionConstants.d50.h,
                ),
              ],
            ):Padding(
              padding:  EdgeInsets.only(top: DimensionConstants.d260.h),
              child: Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,),),
            ),
          ),
        );
      },
    );
  }
}

Widget profilePic(BuildContext context, VoidCallback changePhotoTap,
    String realImage, String name, String emptyImageIcon) {
  return Align(
    alignment: Alignment.center,
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(DimensionConstants.d50.r),
          child: ImageView(
            path: realImage == "" ? emptyImageIcon : realImage,
            height: DimensionConstants.d100.h,
            width: DimensionConstants.d100.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: DimensionConstants.d16.h,
        ),
        GestureDetector(
          onTap: changePhotoTap,
          child: Text(name.tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.center,
              color: ColorConstants.primaryColor),
        )
      ],
    ),
  );
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
            controller:  controller,
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
