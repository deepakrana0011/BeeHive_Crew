import 'package:beehive/Constants/color_constants.dart';
import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/model/get_crew_profile_response.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowCertificateCrewPage extends StatelessWidget {
  ShowCertificateCrewPage({Key? key, required this.certificationData}) : super(key: key);
  Cert certificationData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBarWithTitleAndAction(context,
          title: "certification".tr(),
          actionButtonRequired: false,
          popFunction: () {
            CommonWidgets.hideKeyboard(context);
            Navigator.pop(context);
          }),
      body: SafeArea(
        child:  certificationData == null ? Center(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height*0.8,
              child: Text("no_data_found".tr()).boldText(
                  context, DimensionConstants.d16.sp, TextAlign.left,
                  color: ColorConstants.colorBlack),
            )
        ): SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: DimensionConstants.d26.h,
                ),
                Text("certification_name".tr()).boldText(
                    context, DimensionConstants.d16.sp, TextAlign.left,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d16.h,
                ),
                Text(certificationData.certName.toString()).regularText(
                    context, DimensionConstants.d16.sp, TextAlign.left,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? ColorConstants.colorWhite
                        : ColorConstants.colorBlack),
                SizedBox(
                  height: DimensionConstants.d26.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: DimensionConstants.d500.h,
                  child:CachedNetworkImage(
                    imageUrl: ApiConstantsCrew.BASE_URL_IMAGE + certificationData!.certImage.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, _) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorConstants.primaryGradient2Color,
                        ),
                      );
                    },
                    errorWidget: (context, _, __) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorConstants.primaryGradient2Color,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
