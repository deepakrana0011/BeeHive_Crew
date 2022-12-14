import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/add_note_page_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/image_constants.dart';
import '../../helper/decoration.dart';
import '../../widget/image_view.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddNotePageProvider>(
      onModelReady: (provider) {},
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              actionButtonRequired: false, title: "add_note",),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d37.h,
                ),
                titleWidget(context),
                SizedBox(
                  height: DimensionConstants.d24.h,
                ),
                noteWidget(context),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                addPhotoButton(context, provider),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                SizedBox(
                  height: DimensionConstants.d160.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.allImageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: DimensionConstants.d8.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    DimensionConstants.d8.r),
                                child: Image.file(
                                  provider.allImageList[index]!,
                                  height: DimensionConstants.d149.h,
                                  width: DimensionConstants.d163.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                left: DimensionConstants.d110.w,
                                child: GestureDetector(
                                    onTap: () =>
                                        provider.removeImageFromList(index),
                                    child: const ImageView(
                                      path: ImageConstants.crossIcon,
                                    ))),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: DimensionConstants.d55.h,
                ),
                CommonWidgets.commonButton(
                  context,
                  "add_note".tr(),
                  color1: ColorConstants.primaryGradient1Color,
                  color2: ColorConstants.primaryGradient2Color,
                  fontSize: DimensionConstants.d16.sp,
                  onBtnTap: (){Navigator.of(context).pop();}
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget noteWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("note".tr()).boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorWhite
              : ColorConstants.colorBlack),
      SizedBox(
        height: DimensionConstants.d8.h,
      ),
      Container(
        height: DimensionConstants.d200.h,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.littleDarkGray
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
          maxLines: 10,
          decoration: ViewDecoration.inputDecorationBox(
            fieldName: "".tr(),
            radius: DimensionConstants.d8.r,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.littleDarkGray,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorBlack
                : ColorConstants.littleDarkGray,
            hintTextColor: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.littleDarkGray,
            hintTextSize: DimensionConstants.d16.sp,
          ),
        ),
      )
    ],
  );
}

Widget titleWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text("title".tr()).boldText(
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
              ? ColorConstants.littleDarkGray
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
          maxLines: 10,
          decoration: ViewDecoration.inputDecorationBox(
            fieldName: "note_title_here".tr(),
            radius: DimensionConstants.d8.r,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.littleDarkGray,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorBlack
                : ColorConstants.littleDarkGray,
            hintTextColor: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.darkGray4F4F4F,
            hintTextSize: DimensionConstants.d16.sp,
          ),
        ),
      )
    ],
  );
}

Widget addPhotoButton(BuildContext context, AddNotePageProvider provider) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) => DialogHelper.getPhotoDialog(
                context,
                photoFromCamera: () {
                  provider.addPhotos(context, 1);
                },
                photoFromGallery: () {
                  provider.addPhotos(context, 2);
                },
              ));
    },
    child: Container(
      height: DimensionConstants.d40.h,
      width: DimensionConstants.d118,
      decoration: BoxDecoration(
        color: ColorConstants.deepBlue,
        border: Theme.of(context).brightness == Brightness.dark
            ? Border.all(
                color: ColorConstants.colorWhite,
                width: DimensionConstants.d1.w)
            : null,
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d8.w),
        child: Row(
          children: <Widget>[
            ImageView(
              path: ImageConstants.addNotesIcon,
              height: DimensionConstants.d16.h,
              width: DimensionConstants.d16.w,
            ),
            SizedBox(
              width: DimensionConstants.d7.w,
            ),
            Text("add_photo".tr()).semiBoldText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.colorWhite),
          ],
        ),
      ),
    ),
  );
}
