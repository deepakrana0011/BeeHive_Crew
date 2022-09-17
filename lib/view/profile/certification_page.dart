import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/certification_page_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../helper/decoration.dart';

class CertificationPage extends StatelessWidget {
  const CertificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CertificationPageProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "certification".tr(),
              actionButtonRequired: true,
              actionIcon: ImageConstants.notificationIconBell,onTapAction: (){Navigator.pushNamed(context, RouteConstants.notificationsScreen);},popFunction: () { CommonWidgets.hideKeyboard(context);
              Navigator.pop(context);}),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: DimensionConstants.d26.h,
              ),
              textFiledName(
                  context, "certification_name", "certification_name"),
              SizedBox(
                height: DimensionConstants.d16.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    takePictureBox(
                        context, ImageConstants.galleryIcon, "upload", () {
                      provider.addProfilePic(context, 2);
                    }),
                    takePictureBox(
                        context, ImageConstants.cameraIcon, "take_picture", () {
                      provider.addProfilePic(context, 1);
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: DimensionConstants.d16.h,
              ),
              Container(
                height: DimensionConstants.d310.h,
                width: DimensionConstants.d343.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorBlack
                      : ColorConstants.grayF2F2F2,
                  border: Theme.of(context).brightness == Brightness.dark
                      ? Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : Colors.transparent)
                      : null,
                  borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                ),
                child:provider.profileImage != " "? ClipRRect(
                    borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                    child: ImageView(path: provider.profileImage,fit: BoxFit.fill,)):Container(),
              ),
              SizedBox(
                height: DimensionConstants.d22.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: CommonWidgets.commonButton(context, "save".tr(),
                    color1: ColorConstants.primaryGradient2Color,
                    color2: ColorConstants.primaryGradient1Color,
                    fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                  Navigator.of(context).pop();
                },
                  shadowRequired: true
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget textFiledName(BuildContext context, String title, String hintName) {
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
        ),
      ],
    ),
  );
}

Widget takePictureBox(
    BuildContext context, String image, String text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: DimensionConstants.d120.h,
      width: DimensionConstants.d167.w,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.littleDarkGray,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          border: Theme.of(context).brightness == Brightness.dark
              ? Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : Colors.transparent,
                  width: DimensionConstants.d1.w)
              : null),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: DimensionConstants.d36.h,
          ),
          ImageView(
            path: image,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.darkGray4F4F4F,
          ),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          Text(text.tr()).regularText(
            context,
            DimensionConstants.d14.sp,
            TextAlign.center,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.darkGray4F4F4F,
          )
        ],
      ),
    ),
  );
}
