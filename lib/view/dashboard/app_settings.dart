import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/locator.dart';
import 'package:beehive/provider/app_settings_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSettings extends StatelessWidget {
  AppSettings({Key? key}) : super(key: key);

  AppSettingsProvider provider = locator<AppSettingsProvider>();

  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("app_settings".tr())
            .semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.keyboard_backspace,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            )),
      ),
      body: BaseView<AppSettingsProvider>(
        onModelReady: (provider) {
          this.provider = provider;
        },
        builder: (context, provider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: DimensionConstants.d5.h),
              const Divider(
                  color: ColorConstants.colorGreyDrawer,
                  height: 0.0,
                  thickness: 1.5),
              SizedBox(height: DimensionConstants.d16.h),
              unitsRow(context, "units".tr(), "metric_km".tr()),
              SizedBox(height: DimensionConstants.d10.h),
              timeRow(context, "time".tr(), "am_pm".tr()),
              SizedBox(height: DimensionConstants.d10.h),
              languageRow(context, "language".tr(), "english".tr()),
              SizedBox(height: DimensionConstants.d24.h),
              fontSize(context),
              SizedBox(height: DimensionConstants.d34.h),
              const Divider(
                  color: ColorConstants.colorGreyDrawer,
                  height: 0.0,
                  thickness: 1.5),
              SizedBox(height: DimensionConstants.d32.h),
              Expanded(child: aboutAndSaveBtnColumn(context)),
            ],
          );
        },
      ),
    );
  }

  Widget unitsRow(BuildContext context, String txt1, String txt2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Row(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(txt1)
                .boldText(context, DimensionConstants.d16.sp, TextAlign.center),
          )),
          Container(
            width: MediaQuery.of(context).size.width*.60,
            height: DimensionConstants.d45.h,
            decoration: BoxDecoration(
                color: ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                child: DropdownButton(
                  menuMaxHeight: DimensionConstants.d400.h,
                  icon: Padding(
                    padding: EdgeInsets.only(
                        right: DimensionConstants.d16.w,
                        top: DimensionConstants.d10.h,
                        bottom: DimensionConstants.d10.h),
                    child: ImageView(
                      path: ImageConstants.downArrowIcon,
                      width: DimensionConstants.d16.w,
                      height: DimensionConstants.d16.h,
                    ),
                  ),
                  hint: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: const Text("None").regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center),
                  ),
                  //  menuMaxHeight: DimensionConstants.d414.h,
                  value: provider.units,
                  items: provider.unitsList.map((vehicleName) {
                    return DropdownMenuItem(
                        onTap: () {},
                        value: vehicleName,
                        child: Padding(
                            padding:
                            EdgeInsets.only(left: DimensionConstants.d10.w),
                            child: Text(vehicleName.toString()).regularText(
                                context,
                                DimensionConstants.d14.sp, TextAlign.center)));
                  }).toList(),
                  onChanged: (String? value) {
                    provider.onSelectedUnits(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeRow(BuildContext context, String txt1, String txt2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Row(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(txt1)
                .boldText(context, DimensionConstants.d16.sp, TextAlign.center),
          )),
          Container(
            width: MediaQuery.of(context).size.width*.60,
            height: DimensionConstants.d45.h,
            decoration: BoxDecoration(
                color: ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                child: DropdownButton(
                  menuMaxHeight: DimensionConstants.d400.h,
                  icon: Padding(
                    padding: EdgeInsets.only(
                        right: DimensionConstants.d16.w,
                        top: DimensionConstants.d10.h,
                        bottom: DimensionConstants.d10.h),
                    child: ImageView(
                      path: ImageConstants.downArrowIcon,
                      width: DimensionConstants.d16.w,
                      height: DimensionConstants.d16.h,
                    ),
                  ),
                  hint: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: const Text("None").regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center),
                  ),
                  //  menuMaxHeight: DimensionConstants.d414.h,
                  value: provider.time,
                  items: provider.timesList.map((vehicleName) {
                    return DropdownMenuItem(
                        onTap: () {},
                        value: vehicleName,
                        child: Padding(
                            padding:
                            EdgeInsets.only(left: DimensionConstants.d10.w),
                            child: Text(vehicleName.toString()).regularText(
                                context,
                                DimensionConstants.d14.sp, TextAlign.center)));
                  }).toList(),
                  onChanged: (String? value) {
                    provider.onSelectedTime(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget languageRow(BuildContext context, String txt1, String txt2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Row(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(txt1)
                .boldText(context, DimensionConstants.d16.sp, TextAlign.center),
          )),
          Container(
            width: MediaQuery.of(context).size.width*.60,
            height: DimensionConstants.d45.h,
            decoration: BoxDecoration(
                color: ColorConstants.grayF2F2F2,
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                child: DropdownButton(
                  menuMaxHeight: DimensionConstants.d400.h,
                  icon: Padding(
                    padding: EdgeInsets.only(
                        right: DimensionConstants.d16.w,
                        top: DimensionConstants.d10.h,
                        bottom: DimensionConstants.d10.h),
                    child: ImageView(
                      path: ImageConstants.downArrowIcon,
                      width: DimensionConstants.d16.w,
                      height: DimensionConstants.d16.h,
                    ),
                  ),
                  hint: Padding(
                    padding: EdgeInsets.only(left: DimensionConstants.d10.w),
                    child: const Text("None").regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center),
                  ),
                  //  menuMaxHeight: DimensionConstants.d414.h,
                  value: provider.language,
                  items: provider.languagesList.map((vehicleName) {
                    return DropdownMenuItem(
                        onTap: () {},
                        value: vehicleName,
                        child: Padding(
                            padding:
                            EdgeInsets.only(left: DimensionConstants.d10.w),
                            child: Text(vehicleName.toString()).regularText(
                                context,
                                DimensionConstants.d14.sp, TextAlign.center)));
                  }).toList(),
                  onChanged: (String? value) {
                   provider.onSelectedLanguage(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fontSize(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("font_size".tr())
              .boldText(context, DimensionConstants.d16.sp, TextAlign.center),
          SizedBox(height: DimensionConstants.d16.h),
          SizedBox(
            height: DimensionConstants.d45.h,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: provider.fontSizeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      provider.selectedIndex = index;
                      provider.updateLoadingStatus(true);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: DimensionConstants.d8.w),
                      alignment: Alignment.center,
                      height: DimensionConstants.d45.h,
                      width: DimensionConstants.d108.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorBlack
                              : ColorConstants.colorLightGreyF2,
                          border: Border.all(
                              color: provider.selectedIndex == index
                                  ? (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorConstants.primaryColor
                                      : ColorConstants.colorBlack)
                                  : ColorConstants.colorLightGreyF2,
                              width: 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(DimensionConstants.d8.r))),
                      child: Text(provider.fontSizeList[index]).mediumText(
                          context, DimensionConstants.d15.sp, TextAlign.center),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget aboutAndSaveBtnColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DimensionConstants.d16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("about".tr())
              .boldText(context, DimensionConstants.d16.sp, TextAlign.center),
          SizedBox(height: DimensionConstants.d22.h),
          policyTermsDataRow(context, "privacy_policy".tr()),
          SizedBox(height: DimensionConstants.d22.h),
          policyTermsDataRow(context, "terms_of_use".tr()),
          SizedBox(height: DimensionConstants.d22.h),
          policyTermsDataRow(context, "data_and_app_tracking".tr()),
          const Spacer(),
          CommonWidgets.commonButton(context, "save", shadowRequired: true),
          SizedBox(
            height: DimensionConstants.d88.h,
          )
        ],
      ),
    );
  }

  Widget policyTermsDataRow(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title)
            .regularText(context, DimensionConstants.d14.sp, TextAlign.center),
        ImageView(
          path: ImageConstants.forwardArrowIcon,
          color: Theme.of(context).iconTheme.color,
        )
      ],
    );
  }
}
