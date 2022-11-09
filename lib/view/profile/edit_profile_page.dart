import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/edit_profile_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/decoration.dart';
import '../../helper/dialog_helper.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileProvider>(
      onModelReady: (provider) async {
        await provider.getCrewProfile(context);
        provider.setAllController();
      },
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "edit_profile",
              actionButtonRequired: false, popFunction: () {
            CommonWidgets.hideKeyboard(context);
            Navigator.pop(context);
          }),
          body: provider.state == ViewState.busy
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.primaryGradient2Color,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: DimensionConstants.d17.h,
                    ),
                    profilePic(context, () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              DialogHelper.getPhotoDialog(
                                context,
                                photoFromCamera: () {
                                  provider.upDateImageChanged();
                                  provider.addProfilePic(context, 1);
                                },
                                photoFromGallery: () {
                                  provider.upDateImageChanged();
                                  provider.addProfilePic(context, 2);
                                },
                              ));
                    }, provider),
                    SizedBox(
                      height: DimensionConstants.d24.h,
                    ),
                    textFiledName(
                        context, "name", "John Smith", provider.nameController),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    textFiledName(context, "title", "Carpenter",
                        provider.titleController),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    textFiledName(context, "specialty", "Framing & Finishing",
                        provider.specialityController),
                    SizedBox(
                      height: DimensionConstants.d24.h,
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
                    textFiledName(context, "company", "xyz Company",
                        provider.companyNameController),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    textFiledName(context, "phone", "123-555-2514",
                        provider.phoneNumberController,
                        phoneNo: true),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    textFiledName(context, "email", "johnsmith@gmail.com",
                        provider.emailController,
                        readOnly: true),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    textFiledName(
                        context,
                        "address",
                        "88 Bloor St E. Toronto, ON, M4W3G9",
                        provider.addressController),
                    SizedBox(
                      height: DimensionConstants.d38.h,
                    ),
                    provider.updateLoader
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.primaryGradient2Color,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: DimensionConstants.d16.w),
                            child: CommonWidgets.commonButton(
                                context, "save".tr(),
                                color1: ColorConstants.primaryGradient2Color,
                                color2: ColorConstants.primaryGradient1Color,
                                fontSize: DimensionConstants.d14.sp,
                                onBtnTap: () {
                              if (provider.nameController.text.trim().isEmpty) {
                                DialogHelper.showMessage(
                                    context, "name_required".tr());
                              } else if (provider.phoneNumberController.text
                                  .trim()
                                  .isEmpty) {
                                DialogHelper.showMessage(
                                    context, "phone_required".tr());
                              } else {
                                provider.updateCrewProfile(context);
                              }
                            }, shadowRequired: true),
                          ),
                    SizedBox(
                      height: DimensionConstants.d50.h,
                    ),
                  ],
                )),
        );
      },
    );
  }
}

Widget profilePic(BuildContext context, VoidCallback changePhotoTap,
    EditProfileProvider provider) {
  return Align(
    alignment: Alignment.center,
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(DimensionConstants.d50.r),
          child: ImageView(
            path: provider.profileImage == " "
                ? ImageConstants.emptyImageIcon
                : provider.profileImage,
            height: DimensionConstants.d100.h,
            width: DimensionConstants.d100.w,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: DimensionConstants.d16.h,
        ),
        GestureDetector(
          onTap: changePhotoTap,
          child: Text("change_photo".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.center,
              color: ColorConstants.primaryColor),
        )
      ],
    ),
  );
}

Widget textFiledName(BuildContext context, String title, String hintName,
    TextEditingController controller,
    {bool readOnly = false, bool phoneNo = false}) {
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
            inputFormatters: phoneNo
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : [],
            readOnly: readOnly,
            controller: controller,
            cursorColor: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack,
            maxLines: 1,
            decoration: ViewDecoration.inputDecorationBox(
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
              fieldName: '',
            ),
          ),
        )
      ],
    ),
  );
}
