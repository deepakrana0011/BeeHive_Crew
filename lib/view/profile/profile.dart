import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/provider/profile_page_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/common_widgets.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilePageProvider>(
        onModelReady: (provider){
          provider.getCrewProfile(context);
        },
        builder: (context,provider,_){
          return Scaffold(
            body: SingleChildScrollView(
              child:provider.state == ViewState.idle? Column(
                children: <Widget>[
                  profileWidget(context, () {
                    Navigator.pushNamed(context, RouteConstants.editProfilePage).then((value) {
                      provider.getCrewProfile(context);
                    });
                  },provider),
                  SizedBox(
                    height: DimensionConstants.d38.h,
                  ),
                  profileDetailsWidget(context, ImageConstants.companyIcon, provider.getObj!.data!.company == null?"xyz Company":provider.getObj!.data!.company!, false),
                  SizedBox(
                    height: DimensionConstants.d38.h,
                  ),
                  profileDetailsWidget(
                      context, ImageConstants.callerIcon, provider.getObj!.data!.phoneNumber == null?"123-555-2514":provider.getObj!.data!.phoneNumber!.toString(), false),
                  SizedBox(
                    height: DimensionConstants.d38.h,
                  ),
                  profileDetailsWidget(context, ImageConstants.mailerIcon, provider.getObj!.data!.email == null?"johnsmith@gmail.comxxx":provider.getObj!.data!.email!, false),
                  SizedBox(
                    height: DimensionConstants.d38.h,
                  ),
                  profileDetailsWidget(context, ImageConstants.locationIcon, provider.getObj!.data!.address == null?"88 Bloor St E. Toronto ONM4W3G9":provider.getObj!.data!.address!, false),
                  SizedBox(
                    height: DimensionConstants.d38.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConstants.changePasswordPage);
                      },
                      child: profileDetailsWidget(context, ImageConstants.lockIcon,
                          "change_password".tr(), true)),
                  SizedBox(
                    height: DimensionConstants.d50.h,
                  ),
                  certificationAndAddButtonWidget(context),
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                  scaleNotesWidget(context),
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
                    child: CommonWidgets.commonButton(
                        context, "upgrade_to_crew_manager".tr(),
                        color1: ColorConstants.blueGradient2Color,
                        color2: ColorConstants.blueGradient1Color,
                        fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                      Navigator.pushNamed(context, RouteConstants.upgradePage);
                    }),
                  ),
                  SizedBox(
                    height: DimensionConstants.d40.h,
                  ),
                ],
              ):Padding(
                padding: EdgeInsets.only(top: DimensionConstants.d300.h),
                child: const Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,)),
              ),
            ),
          );



        });
  }
}

Widget profileWidget(BuildContext context, VoidCallback onTapOnEditButton, ProfilePageProvider provider) {
  return Stack(
    children: <Widget>[
      Container(
        height: DimensionConstants.d350.h,
        decoration: BoxDecoration(
            color: ColorConstants.deepBlue,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(DimensionConstants.d40.r),
                bottomRight: Radius.circular(DimensionConstants.d40.r))),
      ),
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
          left: DimensionConstants.d110.w,
          top: DimensionConstants.d58.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: DimensionConstants.d150.h,
                width: DimensionConstants.d150.w,
                decoration: BoxDecoration(
                  color: ColorConstants.colorWhite,
                  borderRadius: BorderRadius.circular(DimensionConstants.d75.r)
                ),
                child: Padding(
                  padding:  const EdgeInsets.all(DimensionConstants.d3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DimensionConstants.d75.r),
                    child: ImageView(
                      path: provider.getObj!.data!.profileImage ==null ? ImageConstants.personIcon: "http://3.235.151.126:8081/"+provider.getObj!.data!.profileImage!,
                      height: DimensionConstants.d150.h,
                      width: DimensionConstants.d150.w,
                      radius: DimensionConstants.d75.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DimensionConstants.d20.h,
              ),
               Text(provider.getObj!.data!.name == null?"Namexxx":provider.getObj!.data!.name!).boldText(
                  context, DimensionConstants.d30.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
              SizedBox(
                height: DimensionConstants.d8.h,
              ),
              Text(provider.getObj!.data!.position == null?"Positionxx".tr():provider.getObj!.data!.position!).semiBoldText(
                  context, DimensionConstants.d20.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
              SizedBox(
                height: DimensionConstants.d4.h,
              ),
              Text(provider.getObj!.data!.speciality == null?"Specialityxx":provider.getObj!.data!.speciality!).regularText(
                  context, DimensionConstants.d14.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
            ],
          ))
    ],
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
          Text(text).regularText(
            context,
            DimensionConstants.d14.sp,
            TextAlign.left,
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

Widget certificationAndAddButtonWidget(BuildContext context) {
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
          onTap: (){
            Navigator.pushNamed(context, RouteConstants.certificationPage);
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
              padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
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

Widget scaleNotesWidget(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d12.w),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstants.d8.r)),
      child: Container(
        height: DimensionConstants.d186.h,
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
          itemCount: 3,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: DimensionConstants.d25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d16.w),
                  child: Row(
                    children: <Widget>[
                      Text("Certifications Name 1").regularText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: Theme.of(context).brightness == Brightness.dark
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
            );
          },
        ),
      ),
    ),
  );
}
