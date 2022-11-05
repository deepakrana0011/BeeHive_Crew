import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/bottom_bar_Manager_provider.dart';
import 'package:beehive/provider/profile_page_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/views_manager/profile_manager/edit_profile_page_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../helper/common_widgets.dart';

class ProfilePageManager extends StatelessWidget {
  const ProfilePageManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomBarProvider = Provider.of<BottomBarManagerProvider>(context,listen: false);
    return BaseView<ProfilePageManagerProvider>(
        onModelReady: (provider){
          provider.getManagerProfile(context).then((value) {
            bottomBarProvider.updateDrawerData(value!.data!.name!, value.data?.profileImage, value.data?.companyLogo, value.data!.customColor!);
          });
        },
        builder: (context,provider,_){
          return Scaffold(
            body: SingleChildScrollView(
              child: provider.state ==ViewState.idle ?
                  provider.profileResponse?.data == null ? Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height*0.8,
                      child: Text("no_data_found".tr()).boldText(
                          context, DimensionConstants.d16.sp, TextAlign.left,
                          color: ColorConstants.colorBlack),
                    )
                  ):
             (Column(
                children: <Widget>[
                  profileWidget(context, provider, onTapOnEditButton: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePageManager())).then((value) {
                     provider.getManagerProfile(context).then((value) {
                       bottomBarProvider.updateDrawerData(value!.data!.name!, value.data!.profileImage!, value.data!.companyLogo!, value.data!.customColor!);
                     });
                   });
                  }
                 ),
                  (provider.profileResponse!.data!.company == null || provider.profileResponse!.data!.company == "") ? Container() :
                  SizedBox(height: DimensionConstants.d38.h,),
                  (provider.profileResponse!.data!.company == null || provider.profileResponse!.data!.company == "") ? Container() :
                  profileDetailsWidget(context, ImageConstants.companyIcon, provider.profileResponse!.data!.company!, false),
                  (provider.profileResponse!.data!.phoneNumber == null || provider.profileResponse!.data!.phoneNumber == "")? Container() :
                  SizedBox(height: DimensionConstants.d38.h,),
                  (provider.profileResponse!.data!.phoneNumber == null || provider.profileResponse!.data!.phoneNumber == "")? Container() :
                  profileDetailsWidget(context, ImageConstants.callerIcon, provider.profileResponse!.data!.phoneNumber.toString(), false),
                  (provider.profileResponse!.data!.email == null || provider.profileResponse!.data!.email == "")? Container() :
                  SizedBox(height: DimensionConstants.d38.h,),
                  (provider.profileResponse!.data!.email == null || provider.profileResponse!.data!.email == "")? Container() :
                  profileDetailsWidget(context, ImageConstants.mailerIcon, provider.profileResponse!.data!.email!, false),
                  (provider.profileResponse!.data!.address == null || provider.profileResponse!.data!.address == "")? Container() :
                  SizedBox(height: DimensionConstants.d38.h,),
                  (provider.profileResponse!.data!.address == null || provider.profileResponse!.data!.address == "")? Container() :
                  profileDetailsWidget(context, ImageConstants.locationIcon, provider.profileResponse!.data!.address!, false),
                  SizedBox(height: DimensionConstants.d38.h,),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConstants.changePasswordPageManager);
                      },
                      child: profileDetailsWidget(context, ImageConstants.lockIcon,
                          "change_password".tr(), true)),
                  SizedBox(
                    height: DimensionConstants.d50.h,
                  ),
                  certificationAndAddButtonWidget(context, provider),
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                provider.profileResponse!.cert.isEmpty ? Container() :  scaleNotesWidget(context, provider),
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                  SizedBox(
                    height: DimensionConstants.d80.h,
                  ),
                ],
              )): Padding(
                padding:  EdgeInsets.only(top: DimensionConstants.d260.h),
                child: Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,),),
              ),
            ),
          );
        });
  }
}

Widget profileWidget(BuildContext context, ProfilePageManagerProvider provider, {VoidCallback? onTapOnEditButton}) {
  return Container(
    height: DimensionConstants.d359.h,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: provider.profileResponse!.data!.customColor == null ? provider.currentColor.toColor() :
        Color(int.parse(provider.profileResponse!.data!.customColor.toString())),
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
            color: ColorConstants.colorWhite.withOpacity(0.3),
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
                  border: Border.all(
                      color: ColorConstants.colorWhite,
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
        Padding(
          padding: EdgeInsets.only(
              top: DimensionConstants.d50.h, left: DimensionConstants.d95.w),
          child: Container(
            height: DimensionConstants.d160.h,
            width: DimensionConstants.d160.w,
            decoration: BoxDecoration(
                color: ColorConstants.colorWhite,
                borderRadius: BorderRadius.circular(DimensionConstants.d80.r)),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DimensionConstants.d75.r),
                child: provider.profileResponse!.data!.profileImage== null ?
                Container(
                  height: DimensionConstants.d150.h,
                  width: DimensionConstants.d150.w,
                  color: ColorConstants.primaryColor,) : ImageView(
                  path: ApiConstantsCrew.BASE_URL_IMAGE+provider.profileResponse!.data!.profileImage!,
                  height: DimensionConstants.d150.h,
                  width: DimensionConstants.d150.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              top: DimensionConstants.d220.h, left: DimensionConstants.d10.w, right: DimensionConstants.d10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(provider.profileResponse!.data!.name == null? "":provider.profileResponse!.data!.name!).boldText(
                  context, DimensionConstants.d30.sp, TextAlign.center,
                  color: ColorConstants.colorWhite, maxLines: 1, overflow: TextOverflow.ellipsis),
              SizedBox(
                height: DimensionConstants.d5.h,
              ),
              Text(provider.profileResponse!.data!.company == null?"":provider.profileResponse!.data!.company!).boldText(
                  context, DimensionConstants.d18.sp, TextAlign.center,
                  color: ColorConstants.colorWhite, maxLines: 1, overflow: TextOverflow.ellipsis),
              SizedBox(
                height: DimensionConstants.d14.h,
              ),
              Container(
                height: DimensionConstants.d27.h,
                width: DimensionConstants.d158.w,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorConstants.deepBlue,
                      width: DimensionConstants.d1.w),
                  color: ColorConstants.deepBlue,
                  borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionConstants.d10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       ImageView(
                        path: ImageConstants.crewIcon,
                        height: DimensionConstants.d17.h,
                         width: DimensionConstants.d19.w,
                         fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: DimensionConstants.d6.w,
                      ),
                      Text("crew_manager".tr()).semiBoldText(
                          context, DimensionConstants.d14.sp, TextAlign.left,
                          color: ColorConstants.colorWhite),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: DimensionConstants.d125.h,
            left: DimensionConstants.d205.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DimensionConstants.d41.r),
              child: ImageView(
                path:provider.profileResponse!.data!.companyLogo==null? ImageConstants.brandIocn:ApiConstantsCrew.BASE_URL_IMAGE+provider.profileResponse!.data!.companyLogo!,
                height: DimensionConstants.d82.h,
                width: DimensionConstants.d82.w,
                fit: BoxFit.cover,
              ),
            )),
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
                context,
                DimensionConstants.d14.sp,
                TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis
            ),
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

Widget certificationAndAddButtonWidget(BuildContext context, ProfilePageManagerProvider provider) {
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
            Navigator.pushNamed(
                context, RouteConstants.certificationPageManager).then((value) {
                  provider.getManagerProfile(context);
            });
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


Widget scaleNotesWidget(BuildContext context, ProfilePageManagerProvider provider) {
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
          itemCount: provider.profileResponse!.cert.length,
        //  physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RouteConstants.showCertificationManagerPage, arguments: provider.profileResponse!.cert[index]);
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: DimensionConstants.d25.h,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstants.d16.w),
                    child: Row(
                      children: <Widget>[
                       Expanded(child:  Text(provider.profileResponse!.cert[index].certName.toString()).regularText(
                           context, DimensionConstants.d14.sp, TextAlign.left,
                           color: Theme.of(context).brightness == Brightness.dark
                               ? ColorConstants.colorWhite
                               : ColorConstants.colorBlack, maxLines: 1, overflow: TextOverflow.ellipsis),),
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
/*Stack(
    children: <Widget>[
      Container(
        height: DimensionConstants.d350.h,
        decoration: BoxDecoration(
            color: ColorConstants.blueGradient1Color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(DimensionConstants.d40.r),
                bottomRight: Radius.circular(DimensionConstants.d40.r))),
      ),
      Padding(
        padding: EdgeInsets.only(left: DimensionConstants.d67.w),
        child: ImageView(
          path: ImageConstants.profileBackground,
          height: DimensionConstants.d273.h,
          color: ColorConstants.colorWhite.withOpacity(0.2),
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
          left: DimensionConstants.d120.w,
          top: DimensionConstants.d58.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ImageView(
                path: ImageConstants.personIcon,
                height: DimensionConstants.d150.h,
                width: DimensionConstants.d150.w,
              ),
              SizedBox(
                height: DimensionConstants.d20.h,
              ),
              const Text("John Smith").boldText(
                  context, DimensionConstants.d30.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
              SizedBox(
                height: DimensionConstants.d8.h,
              ),
              Text("Construction ltd.").boldText(
                  context, DimensionConstants.d18.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
              SizedBox(
                height: DimensionConstants.d4.h,
              ),
              Text("Framing & Finishing").regularText(
                  context, DimensionConstants.d14.sp, TextAlign.center,
                  color: ColorConstants.colorWhite),
            ],
          ))
    ],
  );*/
