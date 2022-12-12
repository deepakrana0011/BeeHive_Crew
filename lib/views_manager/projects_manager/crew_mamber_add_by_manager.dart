import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/crew_member_add_by_manager_provider.dart';
import 'package:beehive/provider/edit_profile_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/decoration.dart';
import '../../helper/dialog_helper.dart';

class CrewMemberAddByManager extends StatelessWidget {
  String projectId;

  CrewMemberAddByManager({Key? key, required this.projectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CrewMemberAddByManagerProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "add_profile",
              actionButtonRequired: false, popFunction: () {
            CommonWidgets.hideKeyboard(context);
            Navigator.pop(context);
          }),
          body: SingleChildScrollView(
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
                              provider.addProfilePic(context, 1);
                            },
                            photoFromGallery: () {
                              provider.addProfilePic(context, 2);
                            },
                          ));
                  provider.updateImageChanged();
                }, provider),
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                textFiledName(context, "name", provider.nameController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(context, "title", provider.titleController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(
                    context, "specialty", provider.specialityController),
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
                textFiledName(context, "company", provider.companyController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(context, "phone", provider.phoneController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(context, "email", provider.emailController),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                textFiledName(context, "address", provider.addressController),
                SizedBox(
                  height: DimensionConstants.d38.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d16.w),
                  child: provider.state == ViewState.idle
                      ? CommonWidgets.commonButton(context, "save".tr(),
                          color1: ColorConstants.primaryGradient2Color,
                          color2: ColorConstants.primaryGradient1Color,
                          fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                        if (provider.nameController.text.trim().isEmpty) {
                          DialogHelper.showMessage(
                              context, "name_required".tr());
                        }else{
                          provider.addNewCrewByManager(context, projectId);
                        }

                        }, shadowRequired: true)
                      : const Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.primaryGradient2Color,
                          ),
                        ),
                ),
                SizedBox(
                  height: DimensionConstants.d50.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget profilePic(BuildContext context, VoidCallback changePhotoTap,
    CrewMemberAddByManagerProvider provider) {
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

Widget textFiledName(
    BuildContext context, String title, TextEditingController controller) {
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
              fieldName: '',
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
