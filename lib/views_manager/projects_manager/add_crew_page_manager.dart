import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/crew_on_this_project_response.dart';
import 'package:beehive/model/manager_dashboard_response.dart';
import 'package:beehive/provider/add_crew_page_provider_manager.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/projects_manager/crew_mamber_add_by_manager.dart';
import 'package:beehive/views_manager/projects_manager/set_rates_page_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/decoration.dart';

class AddCrewPageManager extends StatelessWidget {
  List<Crews>? crewList;
  String? projectId;

  AddCrewPageManager({Key? key,this.crewList,this.projectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddCrewPageManagerProvider>(
      onModelReady: (provider) {
        provider.alreadyMemberList=crewList;
        provider.projectId=projectId;
        provider.getCrewList(context);
      },
      builder: (context, provider, _) {
        return Scaffold(
          appBar: CommonWidgets.appBarWithTitleAndAction(context,
              title: "add_crew", popFunction: () {
            CommonWidgets.hideKeyboard(context);
            Navigator.pop(context);
          }),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: DimensionConstants.d16.h,
                  ),
                  searchBarWidget(),
                  SizedBox(
                    height: DimensionConstants.d13.h,
                  ),
                  shareWidget(context, provider),
                  SizedBox(
                    height: DimensionConstants.d13.h,
                  ),
                  crewWidget(context, provider),
                  SizedBox(
                    height: DimensionConstants.d30.h,
                  ),
                  provider.state == ViewState.idle
                      ? CommonWidgets.commonButton(context, "next".tr(),
                          color1: ColorConstants.primaryGradient2Color,
                          color2: ColorConstants.primaryGradient1Color,
                          fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                          provider.navigateToNextPage(context);
                        }, shadowRequired: true)
                      : const Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.primaryGradient2Color,
                          ),
                        ),
                  SizedBox(
                    height: DimensionConstants.d50.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget searchBarWidget() {
  return Container(
    height: DimensionConstants.d45.h,
    decoration: BoxDecoration(
      color: ColorConstants.grayF2F2F2,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Row(
        children: <Widget>[
          ImageView(
            path: ImageConstants.searchIcon,
            height: DimensionConstants.d24.h,
            width: DimensionConstants.d24.w,
          ),
          SizedBox(
            height: DimensionConstants.d45.h,
            width: DimensionConstants.d287.w,
            child: TextFormField(
              cursorColor: ColorConstants.colorBlack,
              maxLines: 1,
              decoration: ViewDecoration.inputDecorationBox(
                fieldName: "search_for_name_city_or_trade".tr(),
                radius: DimensionConstants.d8.r,
                fillColor: ColorConstants.grayF2F2F2,
                color: ColorConstants.grayF3F3F3,
                hintTextColor: ColorConstants.colorBlack,
                hintTextSize: DimensionConstants.d16.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget shareWidget(BuildContext context, AddCrewPageManagerProvider provider) {
  return Row(
    children: <Widget>[
      Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: GestureDetector(
          onTap: () {
            provider.onShare(context);
          },
          child: Container(
            height: DimensionConstants.d50.h,
            width: DimensionConstants.d284.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
              child: Row(
                children: <Widget>[
                  const ImageView(
                    path: ImageConstants.messageIcon,
                  ),
                  SizedBox(
                    width: DimensionConstants.d14.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("send_invite".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.left,
                          color: ColorConstants.deepBlue),
                      Text("invite_a_new_crew_member".tr()).regularText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: ColorConstants.deepBlue),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Expanded(child: Container()),
      Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.crewMemberAddByManager,
                    arguments: CrewMemberAddByManager(projectId: "1"))
                .then((value) {
              provider.getCrewList(context);
            });
          },
          child: Container(
            height: DimensionConstants.d50.h,
            width: DimensionConstants.d50.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
            child: const Center(
              child: ImageView(
                path: ImageConstants.addCrewIcon,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

Widget crewWidget(
  BuildContext context,
  AddCrewPageManagerProvider provider,
) {
  return Container(
    height: DimensionConstants.d420.h,
    width: double.infinity,
    child: ListView.builder(
      itemCount: provider.crewList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: DimensionConstants.d8.h),
          child: Container(
            height: DimensionConstants.d60.h,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(DimensionConstants.d30.r),
                  child: ImageView(
                    path: provider.crewList[index].profileImage != null
                        ? "${ApiConstantsCrew.BASE_URL_IMAGE}"
                            "${provider.crewList[index].profileImage}"
                        : ImageConstants.emptyImageIcon,
                    height: DimensionConstants.d60.h,
                    width: DimensionConstants.d60.w,
                    radius: DimensionConstants.d30.r,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: DimensionConstants.d16.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(provider.crewList[index].name.toString()).boldText(
                          context, DimensionConstants.d14.sp, TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: ColorConstants.deepBlue),
                      if (provider.crewList[index].position!.isNotEmpty)
                        Text(provider.crewList[index].position!).regularText(
                            context, DimensionConstants.d14.sp, TextAlign.center,
                            color: ColorConstants.deepBlue),
                      if (provider.crewList[index].address!.isNotEmpty)
                        Text(provider.crewList[index].address.toString())
                            .regularText(context, DimensionConstants.d14.sp,
                                TextAlign.center,
                                color: ColorConstants.deepBlue),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      provider.updateValue(index);
                      provider.addSelectedCrewToTheList(index);
                    },
                    child: ImageView(
                      path: provider.crewList[index].isSelected == false
                          ? ImageConstants.blankIcon
                          : ImageConstants.selectedIcon,
                    )),
              ],
            ),
          ),
        );
      },
    ),
  );
}
