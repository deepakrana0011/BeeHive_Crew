import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/profile_page_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../helper/common_widgets.dart';
import '../../provider/bottom_bar_provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomBarProvider =
        Provider.of<BottomBarProvider>(context, listen: false);
    return BaseView<ProfilePageProvider>(onModelReady: (provider) {
      provider.getCrewProfile(context);
    }, builder: (context, provider, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: provider.state == ViewState.idle
              ? provider.getObj?.data == null
                  ? Center(
                      child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Text("no_data_found".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.left,
                          color: ColorConstants.colorBlack),
                    ))
                  : (Column(
                      children: <Widget>[
                        profileWidget(context, () {
                          Navigator.pushNamed(
                                  context, RouteConstants.editProfilePage)
                              .then((value) {
                            provider.getCrewProfile(context).then((value) {
                              bottomBarProvider.updateDrawerData(
                                  value!.data!.name!,
                                  value.data!.profileImage!);
                            });
                          });
                        }, provider),
                        (provider.getObj!.data!.company == null ||
                                provider.getObj!.data!.company == "")
                            ? Container()
                            : SizedBox(
                                height: DimensionConstants.d38.h,
                              ),
                        (provider.getObj!.data!.company == null ||
                                provider.getObj!.data!.company == "")
                            ? Container()
                            : profileDetailsWidget(
                                context,
                                ImageConstants.companyIcon,
                                provider.getObj!.data!.company!,
                                false),
                        (provider.getObj!.data!.phoneNumber == null ||
                                provider.getObj!.data!.phoneNumber == "")
                            ? Container()
                            : SizedBox(
                                height: DimensionConstants.d38.h,
                              ),
                        (provider.getObj!.data!.phoneNumber == null ||
                                provider.getObj!.data!.phoneNumber == "")
                            ? Container()
                            : profileDetailsWidget(
                                context,
                                ImageConstants.callerIcon,
                                provider.getObj!.data!.phoneNumber!.toString(),
                                false),
                        (provider.getObj!.data!.email == null ||
                                provider.getObj!.data!.email == "")
                            ? Container()
                            : SizedBox(
                                height: DimensionConstants.d38.h,
                              ),
                        (provider.getObj!.data!.email == null ||
                                provider.getObj!.data!.email == "")
                            ? Container()
                            : profileDetailsWidget(
                                context,
                                ImageConstants.mailerIcon,
                                provider.getObj!.data!.email!,
                                false),
                        (provider.getObj!.data!.address == null ||
                                provider.getObj!.data!.address == "")
                            ? Container()
                            : SizedBox(
                                height: DimensionConstants.d38.h,
                              ),
                        (provider.getObj!.data!.address == null ||
                                provider.getObj!.data!.address == "")
                            ? Container()
                            : profileDetailsWidget(
                                context,
                                ImageConstants.locationIcon,
                                provider.getObj!.data!.address!,
                                false),
                        SizedBox(
                          height: DimensionConstants.d38.h,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConstants.changePasswordPage);
                            },
                            child: profileDetailsWidget(
                                context,
                                ImageConstants.lockIcon,
                                "change_password".tr(),
                                true)),
                        SizedBox(
                          height: DimensionConstants.d50.h,
                        ),
                        certificationAndAddButtonWidget(context, provider),
                        SizedBox(
                          height: DimensionConstants.d25.h,
                        ),
                        provider.getObj!.cert.isEmpty
                            ? Container()
                            : scaleNotesWidget(context, provider),
                        SizedBox(
                          height: DimensionConstants.d25.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DimensionConstants.d16.w),
                          child: CommonWidgets.commonButton(
                              context, "upgrade_to_crew_manager".tr(),
                              color1: ColorConstants.blueGradient2Color,
                              color2: ColorConstants.blueGradient1Color,
                              fontSize: DimensionConstants.d14.sp,
                              onBtnTap: () {
                            Navigator.pushNamed(
                                context, RouteConstants.upgradePage);
                          }),
                        ),
                        SizedBox(
                          height: DimensionConstants.d40.h,
                        ),
                      ],
                    ))
              : Padding(
                  padding: EdgeInsets.only(top: DimensionConstants.d300.h),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: ColorConstants.primaryGradient2Color,
                  )),
                ),
        ),
      );
    });
  }
}

Widget profileWidget(BuildContext context, VoidCallback onTapOnEditButton,
    ProfilePageProvider provider) {
  return Container(
    height: DimensionConstants.d350.h,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: ColorConstants.deepBlue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(DimensionConstants.d40.r),
            bottomRight: Radius.circular(DimensionConstants.d40.r))),
    child: Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: DimensionConstants.d67.w),
          child: ImageView(
            path: ImageConstants.profileBackground,
            height: DimensionConstants.d273.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: DimensionConstants.d260.w, top: DimensionConstants.d16.h),
          child: GestureDetector(
            onTap: onTapOnEditButton,
            child: Container(
              height: DimensionConstants.d40.h,
              width: DimensionConstants.d89.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                  border: Theme.of(context).brightness == Brightness.dark
                      ? Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : ColorConstants.colorWhite,
                          width: DimensionConstants.d1.w)
                      : Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : ColorConstants.colorWhite,
                          width: DimensionConstants.d1.w)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d12.w),
                child: Row(
                  children: <Widget>[
                    const ImageView(
                      path: ImageConstants.penIcon,
                    ),
                    SizedBox(
                      width: DimensionConstants.d4.w,
                    ),
                    Text("edit".tr()).boldText(
                        context, DimensionConstants.d16.sp, TextAlign.left,
                        color: ColorConstants.colorWhite),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            left: DimensionConstants.d18.w,
            right: DimensionConstants.d18.w,
            top: DimensionConstants.d58.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: ColorConstants.colorWhite,
                  radius: DimensionConstants.d75.r,
                  child: Padding(
                    padding: const EdgeInsets.all(DimensionConstants.d5),
                    child: provider.getObj!.data!.profileImage == null
                        ? CircleAvatar(
                            radius: DimensionConstants.d75.r,
                            backgroundColor: ColorConstants.grayF2F2F2,
                            child: const Padding(
                              padding: EdgeInsets.all(DimensionConstants.d16),
                              child: ImageView(
                                path: ImageConstants.icAvatar,
                              ),
                            ),
                          )
                        : ImageView(
                            circleCrop: true,
                            width: DimensionConstants.d150.w,
                            height: DimensionConstants.d150.w,
                            fit: BoxFit.cover,
                            color: ColorConstants.colorWhite,
                            radius: DimensionConstants.d75.r,
                            path: ApiConstantsCrew.BASE_URL_IMAGE +
                                provider.getObj!.data!.profileImage!,
                          ),
                  ),
                ),
                SizedBox(
                  height: DimensionConstants.d20.h,
                ),
                Text(provider.getObj!.data!.name == null
                        ? ""
                        : provider.getObj!.data!.name!)
                    .boldText(
                        context, DimensionConstants.d30.sp, TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: ColorConstants.colorWhite),
                SizedBox(
                  height: DimensionConstants.d8.h,
                ),
                Text(provider.getObj!.data!.position == null
                        ? ""
                        : provider.getObj!.data!.position!)
                    .semiBoldText(
                        context, DimensionConstants.d20.sp, TextAlign.center,
                        color: ColorConstants.colorWhite),
                SizedBox(
                  height: DimensionConstants.d4.h,
                ),
                Text(provider.getObj!.data!.speciality == null
                        ? ""
                        : provider.getObj!.data!.speciality!)
                    .regularText(
                        context, DimensionConstants.d14.sp, TextAlign.center,
                        color: ColorConstants.colorWhite),
              ],
            ))
      ],
    ),
  );
}

Widget profileDetailsWidget(
    BuildContext context, String image, String text, bool arrowTrueOrFalse) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
    child: Container(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          ImageView(
            path: image,
            height: DimensionConstants.d24.h,
            width: DimensionConstants.d24.w,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack,
          ),
          SizedBox(
            width: DimensionConstants.d16.w,
          ),
          SizedBox(
            width: DimensionConstants.d275.w,
            child: Text(text).regularText(
                context, DimensionConstants.d14.sp, TextAlign.left,
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Expanded(child: Container()),
          arrowTrueOrFalse == true
              ? ImageView(
                  path: ImageConstants.arrowIcon,
                  width: DimensionConstants.d5.w,
                  height: DimensionConstants.d10.h,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : ColorConstants.colorBlack,
                )
              : Container(),
        ],
      ),
    ),
  );
}

Widget certificationAndAddButtonWidget(
    BuildContext context, ProfilePageProvider provider) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d17.w),
    child: Row(
      children: <Widget>[
        Text("certifications".tr()).boldText(
            context, DimensionConstants.d20.sp, TextAlign.left,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.colorWhite
                : ColorConstants.colorBlack),
        Expanded(child: Container()),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.certificationPage)
                .then((value) {
              provider.getCrewProfile(context);
            });
            ;
          },
          child: Container(
            height: DimensionConstants.d40.h,
            width: DimensionConstants.d89,
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
              padding:
                  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
              child: Row(
                children: <Widget>[
                  ImageView(
                    path: ImageConstants.addNotesIcon,
                    height: DimensionConstants.d16.h,
                    width: DimensionConstants.d16.w,
                  ),
                  SizedBox(
                    width: DimensionConstants.d6.w,
                  ),
                  Text("add".tr()).semiBoldText(
                      context, DimensionConstants.d14.sp, TextAlign.left,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorConstants.colorWhite
                          : ColorConstants.colorWhite),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget scaleNotesWidget(BuildContext context, ProfilePageProvider provider) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d12.w),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
      child: Container(
        /* height: DimensionConstants.d186.h,*/
        decoration: BoxDecoration(
          border: Theme.of(context).brightness == Brightness.dark
              ? Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.colorWhite
                      : Colors.transparent,
                  width: DimensionConstants.d1.w)
              : null,
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorConstants.colorBlack
              : ColorConstants.colorWhite,
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: provider.getObj!.cert.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.pushNamed(
                    context, RouteConstants.showCertificationCrewPage,
                    arguments: provider.getObj!.cert[index]);
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstants.d16.w),
                    child: Row(
                      children: <Widget>[
                        Text(provider.getObj!.cert[index].certName ?? "")
                            .regularText(context, DimensionConstants.d14.sp,
                                TextAlign.left,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorConstants.colorWhite
                                    : ColorConstants.colorBlack),
                        Expanded(child: Container()),
                        ImageView(
                          path: ImageConstants.arrowIcon,
                          height: DimensionConstants.d10.h,
                          width: DimensionConstants.d8.w,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ColorConstants.colorWhite
                              : ColorConstants.colorBlack,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: DimensionConstants.d20.h,
                  ),
                  Container(
                    height: DimensionConstants.d1.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.grayF1F1F1,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}
