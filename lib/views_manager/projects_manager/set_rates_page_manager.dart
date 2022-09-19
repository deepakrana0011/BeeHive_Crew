import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/set_rates_page_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/projects_manager/project_setting_page_manager.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../helper/decoration.dart';
import '../../widget/custom_switcher.dart';

class SetRatesPageManager extends StatelessWidget {
  SetRatesPageManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SetRatesPageManageProvider>(
      onModelReady: (provider) async {
        provider.myController = List.generate(
            provider.createProjectRequest.selectedCrewMember!.length,
            (i) => TextEditingController());
      },
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "set_rates", popFunction: () {
            CommonWidgets.hideKeyboard(context);
            Navigator.pop(context);
          }),
          body: SingleChildScrollView(
              child: provider.state == ViewState.idle
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        notificationSwitcher(
                          context,
                          provider,
                        ),
                        SizedBox(
                          height: DimensionConstants.d14.h,
                        ),
                        provider.isSameRate == true
                            ? rateBoxWidget(context, provider)
                            : Container(),
                        SizedBox(
                          height: provider.isSameRate == true
                              ? DimensionConstants.d30.h
                              : DimensionConstants.d15.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DimensionConstants.d16.w),
                          child: Row(
                            children: <Widget>[
                              Divider(
                                  DimensionConstants.d2.h,
                                  DimensionConstants.d137.w,
                                  ColorConstants.grayF3F3F3),
                              SizedBox(
                                width: DimensionConstants.d25.w,
                              ),
                              const Text("or").boldText(context,
                                  DimensionConstants.d16.sp, TextAlign.center,
                                  color: ColorConstants.gray828282),
                              SizedBox(
                                width: DimensionConstants.d25.w,
                              ),
                              Divider(
                                  DimensionConstants.d2.h,
                                  DimensionConstants.d137.w,
                                  ColorConstants.grayF3F3F3),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: DimensionConstants.d20.h,
                        ),
                        perCrewRates(context, provider.isSameRate, provider,
                            provider.myController!),
                        SizedBox(
                          height: DimensionConstants.d200.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DimensionConstants.d16.w),
                          child: Container(
                            height: DimensionConstants.d50.h,
                            decoration: BoxDecoration(
                              color: ColorConstants.redColorEB5757
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  DimensionConstants.d8.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DimensionConstants.d16.w),
                              child: Row(
                                children: <Widget>[
                                  const ImageView(
                                    path: ImageConstants.warningIcon,
                                  ),
                                  SizedBox(
                                    width: DimensionConstants.d16.w,
                                  ),
                                  Text("warning_text".tr()).regularText(context,
                                      DimensionConstants.d13.sp, TextAlign.left,
                                      color: ColorConstants.colorBlack),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: DimensionConstants.d25.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DimensionConstants.d16.w),
                          child: CommonWidgets.commonButton(
                              context, "next".tr(),
                              color1: ColorConstants.primaryGradient2Color,
                              color2: ColorConstants.primaryGradient1Color,
                              fontSize: DimensionConstants.d14.sp,
                              onBtnTap: () {
                            provider.navigateToNextPage(context);
                          }, shadowRequired: true),
                        ),
                      ],
                    )
                  : const CustomCircularBar()),
        );
      },
    );
  }
}

Widget notificationSwitcher(
  BuildContext context,
  SetRatesPageManageProvider provider,
) {
  return Container(
    height: DimensionConstants.d80.h,
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.colorBlack
          : ColorConstants.colorWhite,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d17.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: DimensionConstants.d24.h,
              ),
              Text("same_rate_for_all_crew".tr()).boldText(
                context,
                DimensionConstants.d16.sp,
                TextAlign.left,
              ),
              SizedBox(
                height: DimensionConstants.d6.h,
              ),
              Text("set_one_rate_that_applies_to_entire_crew".tr()).regularText(
                context,
                DimensionConstants.d14.sp,
                TextAlign.left,
              ),
            ],
          ),
          Expanded(child: Container()),
          CustomSwitch(
            inactiveColor: ColorConstants.grayF2F2F2,
            value: provider.isSameRate,
            onChanged: (value) {
              provider.updateSwitcherStatus(value);
            },
          ),
        ],
      ),
    ),
  );
}

Widget rateBoxWidget(
    BuildContext context, SetRatesPageManageProvider provider) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Container(
      height: DimensionConstants.d42.h,
      width: DimensionConstants.d138.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          border: Border.all(
              color: ColorConstants.grayD2D2D2,
              width: DimensionConstants.d1.w)),
      child: Row(
        children: <Widget>[
          Container(
            height: DimensionConstants.d42.h,
            width: DimensionConstants.d30.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(DimensionConstants.d8.r),
                    topLeft: Radius.circular(DimensionConstants.d8.r))),
            child: Center(
              child: Text("\$").regularText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: ColorConstants.colorBlack),
            ),
          ),
          Container(
            height: DimensionConstants.d42.h,
            width: DimensionConstants.d68.w,
            decoration: const BoxDecoration(
              color: ColorConstants.grayF2F2F2,
            ),
            child: Center(
              child: TextFormField(
                controller: provider.singleRateController,
                cursorColor: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.colorWhite
                    : ColorConstants.colorBlack,
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: ViewDecoration.inputDecorationBoxRate(
                  fieldName: "20.00",
                  radius: DimensionConstants.d8.r,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.grayF3F3F3,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorBlack
                      : ColorConstants.grayF3F3F3,
                  hintTextColor: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack.withOpacity(0.5),
                  hintTextSize: DimensionConstants.d16.sp,
                ),
              ),
            ),
          ),
          Container(
            height: DimensionConstants.d42.h,
            width: DimensionConstants.d30.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(DimensionConstants.d8.r),
                    topRight: Radius.circular(DimensionConstants.d8.r))),
            child: Center(
              child: Text("  / hr").regularText(
                  context, DimensionConstants.d14.sp, TextAlign.left,
                  color: ColorConstants.colorBlack),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget Divider(double height, double width, Color color) {
  return Container(
    height: height,
    width: width,
    color: color,
  );
}

Widget perCrewRates(
    BuildContext context,
    bool isSameRate,
    SetRatesPageManageProvider provider,
    List<TextEditingController> myController) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Container(
      height: DimensionConstants.d100.h,
      width: DimensionConstants.d400.w,
      child: ListView.builder(
          itemCount: provider.createProjectRequest.selectedCrewMember!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: DimensionConstants.d5.h),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(provider.createProjectRequest
                                  .selectedCrewMember![index].name ??
                              "")
                          .boldText(context, DimensionConstants.d16.sp,
                              TextAlign.left,
                              color: isSameRate == false
                                  ? ColorConstants.colorBlack
                                  : ColorConstants.gray828282),
                      if (provider.createProjectRequest
                          .selectedCrewMember![index].position!.isNotEmpty)
                        Text(provider.createProjectRequest
                                .selectedCrewMember![index].position!)
                            .regularText(context, DimensionConstants.d16.sp,
                                TextAlign.left,
                                color: isSameRate == false
                                    ? ColorConstants.colorBlack
                                    : ColorConstants.gray828282),
                    ],
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: DimensionConstants.d42.h,
                    width: DimensionConstants.d138.w,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(DimensionConstants.d8.r),
                        border: Border.all(
                            color: ColorConstants.grayD2D2D2,
                            width: DimensionConstants.d1.w)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: DimensionConstants.d42.h,
                          width: DimensionConstants.d30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(DimensionConstants.d8.r),
                                  topLeft: Radius.circular(
                                      DimensionConstants.d8.r))),
                          child: Center(
                            child: Text("\$").regularText(context,
                                DimensionConstants.d14.sp, TextAlign.left,
                                color: isSameRate == false
                                    ? ColorConstants.colorBlack
                                    : ColorConstants.gray828282),
                          ),
                        ),
                        Container(
                          height: DimensionConstants.d42.h,
                          width: DimensionConstants.d68.w,
                          decoration: const BoxDecoration(
                            color: ColorConstants.grayF2F2F2,
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: myController[index],
                              readOnly: isSameRate == false ? false : true,
                              cursorColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstants.colorWhite
                                  : ColorConstants.colorBlack,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: ViewDecoration.textFieldStyle(
                                  DimensionConstants.d16.sp,
                                  FontWeight.w400,
                                  isSameRate == true
                                      ? ColorConstants.colorBlack
                                          .withOpacity(0.5)
                                      : ColorConstants.colorBlack),
                              decoration: ViewDecoration.inputDecorationBoxRate(
                                fieldName: "20.00",
                                radius: DimensionConstants.d8.r,
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.grayF3F3F3,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorConstants.colorBlack
                                    : ColorConstants.grayF3F3F3,
                                hintTextColor:
                                    ColorConstants.colorBlack.withOpacity(0.5),
                                hintTextSize: DimensionConstants.d16.sp,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: DimensionConstants.d42.h,
                          width: DimensionConstants.d30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight:
                                      Radius.circular(DimensionConstants.d8.r),
                                  topRight: Radius.circular(
                                      DimensionConstants.d8.r))),
                          child: Center(
                            child: Text("  / hr").regularText(context,
                                DimensionConstants.d14.sp, TextAlign.left,
                                color: isSameRate == false
                                    ? ColorConstants.colorBlack
                                    : ColorConstants.gray828282),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    ),
  );
}
