import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/crew_profile_page_provider_manager.dart';
import 'package:beehive/view/base_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../constants/image_constants.dart';
import '../../constants/route_constants.dart';
import '../../helper/dialog_helper.dart';
import '../../widget/image_view.dart';
import 'add_note_page_manager.dart';

class CrewProfilePageManager extends StatelessWidget {
  const CrewProfilePageManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CrewProfilePageProviderManager>(
        onModelReady: (provider) {},
        builder: (context, provider, _) {
          return Scaffold(
            appBar: CommonWidgets.appBarWithTitleAndAction(context,
                title: "crew_profile", actionButtonRequired: false),
            body: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    crewProfileWidget(context, provider),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    profileDetails(context),
                    SizedBox(
                      height: DimensionConstants.d40.h,
                    ),
                    Text("projects".tr()).boldText(
                        context, DimensionConstants.d20.sp, TextAlign.left,
                        color: ColorConstants.colorBlack),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    projectNameWidget(context),
                    SizedBox(
                      height: DimensionConstants.d32.h,
                    ),
                    Text("certifications".tr()).boldText(
                        context, DimensionConstants.d20.sp, TextAlign.left,
                        color: ColorConstants.colorBlack),
                    SizedBox(
                      height: DimensionConstants.d16.h,
                    ),
                    scaleNotesWidget(context),
                    SizedBox(
                      height: DimensionConstants.d32.h,
                    ),
                    addPrivateNote(context),
                    SizedBox(
                      height: DimensionConstants.d53.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget crewProfileWidget(
    BuildContext context, CrewProfilePageProviderManager provider) {
  return Container(
    height: DimensionConstants.d192.h,
    decoration: BoxDecoration(
        color: ColorConstants.colorWhite,
        border: Border(
          bottom: BorderSide(
              color: ColorConstants.littleDarkGray,
              width: DimensionConstants.d1.w),
        )),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: DimensionConstants.d25.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageView(
              path: ImageConstants.personIcon,
              height: DimensionConstants.d93.h,
              width: DimensionConstants.d93.w,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: DimensionConstants.d14.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Benjamin Poole").semiBoldText(
                    context, DimensionConstants.d22.sp, TextAlign.left,
                    color: ColorConstants.deepBlue),
                SizedBox(
                  height: DimensionConstants.d7.h,
                ),
                Text("carpenter".tr()).boldText(
                    context, DimensionConstants.d18.sp, TextAlign.left,
                    color: ColorConstants.deepBlue),
                SizedBox(
                  height: DimensionConstants.d8.h,
                ),
                Text("Finishing and Framing").regularText(
                    context, DimensionConstants.d14.sp, TextAlign.left,
                    color: ColorConstants.deepBlue),
              ],
            )
          ],
        ),
        SizedBox(
          height: DimensionConstants.d16.h,
        ),
        crewRateWidget(context, provider),
      ],
    ),
  );
}

Widget crewRateWidget(
    BuildContext context, CrewProfilePageProviderManager provider) {
  return GestureDetector(
    onTap: () {

      showDialog(
          context: context,
          builder: (BuildContext context) =>
              DialogHelper.editRateDialogBox(
                context,
                cancel: () {},
                delete: () {},
              ));
    },
    child: Container(
      height: DimensionConstants.d42.h,
      width: DimensionConstants.d128.w,
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorConstants.grayD2D2D7, width: DimensionConstants.d1.w),
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: DimensionConstants.d14.w),
        child: Row(
          children: <Widget>[
            const Text("\$").semiBoldText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: ColorConstants.colorBlack),
            Text(provider.rateSetByManager).semiBoldText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: ColorConstants.colorBlack),
            const Text("/hr").semiBoldText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                color: ColorConstants.colorBlack),
            SizedBox(
              width: DimensionConstants.d3.w,
            ),
            const ImageView(
              path: ImageConstants.penIcon,
              color: ColorConstants.colorBlack,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget profileDetails(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d8.w),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ImageView(
              path: ImageConstants.companyIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
              color: ColorConstants.colorBlack,
            ),
            SizedBox(
              width: DimensionConstants.d16.w,
            ),
            Text("xyz Company").regularText(
              context,
              DimensionConstants.d14.sp,
              TextAlign.left,
            ),
          ],
        ),
        SizedBox(
          height: DimensionConstants.d30.h,
        ),
        Row(
          children: <Widget>[
            ImageView(
              path: ImageConstants.callerIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
              color: ColorConstants.colorBlack,
            ),
            SizedBox(
              width: DimensionConstants.d16.w,
            ),
            Text("123-555-2514").regularText(
              context,
              DimensionConstants.d14.sp,
              TextAlign.left,
            ),
          ],
        ),
        SizedBox(
          height: DimensionConstants.d30.h,
        ),
        Row(
          children: <Widget>[
            ImageView(
              path: ImageConstants.mailerIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
              color: ColorConstants.colorBlack,
            ),
            SizedBox(
              width: DimensionConstants.d16.w,
            ),
            Text("johnsmith@gmail.com").regularText(
              context,
              DimensionConstants.d14.sp,
              TextAlign.left,
            ),
          ],
        ),
        SizedBox(
          height: DimensionConstants.d30.h,
        ),
        Row(
          children: <Widget>[
            ImageView(
              path: ImageConstants.locationIcon,
              height: DimensionConstants.d24.h,
              width: DimensionConstants.d24.w,
              color: ColorConstants.colorBlack,
            ),
            SizedBox(
              width: DimensionConstants.d16.w,
            ),
            Text("88 Bloor St E. Toronto ONM4W3G9").regularText(
              context,
              DimensionConstants.d14.sp,
              TextAlign.left,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget projectNameWidget(BuildContext context) {
  return Row(
    children: <Widget>[
      Container(
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d40.w,
        decoration: BoxDecoration(
          color: ColorConstants.schedule5,
          borderRadius: BorderRadius.circular(DimensionConstants.d20.r),
        ),
        child: Center(
          child: Text("MS").boldText(
              context, DimensionConstants.d16.sp, TextAlign.center,
              color: ColorConstants.colorWhite),
        ),
      ),
      SizedBox(
        width: DimensionConstants.d10.w,
      ),
      Text("Momentum Smart Project").boldText(
          context, DimensionConstants.d16.sp, TextAlign.left,
          color: ColorConstants.colorBlack),
      Expanded(child: Container()),
      GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  DialogHelper.removeProjectDialog(
                    context,
                    cancel: () {},
                    delete: () {},
                  ));
        },
        child: Text("remove".tr()).boldText(
            context, DimensionConstants.d16.sp, TextAlign.left,
            color: ColorConstants.redColorEB5757),
      )
    ],
  );
}

Widget scaleNotesWidget(BuildContext context) {
  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
    child: Container(
      height: DimensionConstants.d186.h,
      decoration: BoxDecoration(
        color: ColorConstants.colorWhite,
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
      ),
      child: ListView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: DimensionConstants.d25.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                child: Row(
                  children: <Widget>[
                    Text("Certifications Name 1").regularText(
                        context, DimensionConstants.d14.sp, TextAlign.left,
                        color: ColorConstants.colorBlack),
                    Expanded(child: Container()),
                    ImageView(
                      path: ImageConstants.arrowIcon,
                      height: DimensionConstants.d10.h,
                      width: DimensionConstants.d8.w,
                      color: ColorConstants.colorBlack,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: DimensionConstants.d20.h,
              ),
              Container(
                height: DimensionConstants.d1.h,
                color: ColorConstants.grayF1F1F1,
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget addPrivateNote(BuildContext context) {
  return Row(
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("private_notes".tr()).boldText(
              context, DimensionConstants.d20.sp, TextAlign.left,
              color: ColorConstants.colorBlack),
          Text("only_you_can_see_these_notes".tr()).regularText(
              context, DimensionConstants.d14.sp, TextAlign.left,
              color: ColorConstants.colorBlack),

        ],
      ),
      Expanded(child: Container()),
      GestureDetector(
        onTap: (){
          Navigator.pushNamed(
              context, RouteConstants.addNotePageManager,arguments: AddNotePageManager(publicOrPrivate: true));
        },
        child: Container(
          height: DimensionConstants.d40.h,
          width: DimensionConstants.d113,
          decoration: BoxDecoration(
            color: ColorConstants.deepBlue,
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: DimensionConstants.d12.w),
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
                Text("add_note".tr()).semiBoldText(
                    context, DimensionConstants.d14.sp, TextAlign.left,
                    color: ColorConstants.colorWhite),
              ],
            ),
          ),
        ),
      )
    ],
  );
}