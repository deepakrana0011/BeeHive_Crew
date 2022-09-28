import 'package:beehive/Constants/color_constants.dart';
import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/model/project_detail_crew_response.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowNotePageCrew extends StatelessWidget {
  const ShowNotePageCrew({Key? key, required this.noteData}) : super(key: key);

  final Note noteData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(
          context,
          actionButtonRequired: false,
          title: "note",
          popFunction: () { CommonWidgets.hideKeyboard(context);
          Navigator.pop(context);}
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: DimensionConstants.d37.h,
              ),
              titleWidget(context),
              SizedBox(
                height: DimensionConstants.d24.h,
              ),
              noteWidget(context),
              SizedBox(
                height: DimensionConstants.d24.h,
              ),
              noteData.image!.isEmpty ? Container() : photosWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("title".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          Text(noteData.title ?? "").regularText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
        ],
      ),
    );
  }

  Widget noteWidget(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("note".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          Text(noteData.note ?? "").regularText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
        ],
      ),
    );
  }


  Widget photosWidget(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("photos".tr()).boldText(
              context, DimensionConstants.d16.sp, TextAlign.left,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorConstants.colorWhite
                  : ColorConstants.colorBlack),
          SizedBox(
            height: DimensionConstants.d10.h,
          ),
          SizedBox(
              height: DimensionConstants.d350.h,
              // padding: EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: noteData.image!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0
                ),
                itemBuilder: (BuildContext context, int index){
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(
                          DimensionConstants.d8.r),
                      child: ImageView(path: ApiConstantsCrew.BASE_URL_IMAGE + noteData.image![index],
                        height: DimensionConstants.d149.h,
                        width: DimensionConstants.d163.w,
                        fit: BoxFit.cover,)
                  );
                },
              )),
        ],
      ),
    );
  }

}
