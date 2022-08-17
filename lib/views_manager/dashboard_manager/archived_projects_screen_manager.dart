

import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/view/projects/project_details_page.dart';
import 'package:beehive/views_manager/projects_manager/archived_project_details_manager.dart';
import 'package:beehive/views_manager/projects_manager/project_details_manager.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../helper/common_widgets.dart';

class ArchivedProjectsScreenManager extends StatelessWidget {
  const ArchivedProjectsScreenManager({Key? key}) : super(key: key);

  get ommonWidgets => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("archived_projects".tr()).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center),
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.keyboard_backspace, color: Theme.of(context).iconTheme.color, size: 28,)),
        actions: [
          ImageView(path: ImageConstants.searchIcon, color: Theme.of(context).iconTheme.color,
          height: DimensionConstants.d24.h,
            width: DimensionConstants.d24.w,
          ),
          SizedBox(width: DimensionConstants.d20.w)
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: DimensionConstants.d5.h),
          const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
          SizedBox(height: DimensionConstants.d11.h),
          archivedProjectCard(context, "Momentum Digital", "200", "3"),
          archivedProjectCard(context, "Momentum Smart House Project", "1200", "5"),
          archivedProjectCard(context, "Momentum Smart House Project", "543", "3"),
          SizedBox(height: DimensionConstants.d128.h,),

        ],
      ),
    );
  }

  Widget archivedProjectCard(BuildContext context, String projectName, String totalHours, String crew){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RouteConstants.archivedProjectDetailsManager,arguments: ArchivedProjectDetailsManager(archivedOrProject: true, fromProject: false,));
      },
      child: Container(
        margin: EdgeInsets.only(left: DimensionConstants.d16.w, right: DimensionConstants.d16.w, top: DimensionConstants.d16.h),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorConstants.colorWhite90, width: 1.5),
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Column(
            children: [
              SizedBox(height: DimensionConstants.d18.h),
              Padding(
                padding: EdgeInsets.only(left: DimensionConstants.d16.w, right: DimensionConstants.d16.w, bottom: DimensionConstants.d15.h),
                child: Row(
                  children: [
                    const ImageView(path: ImageConstants.archivedFolderIcon),
                    SizedBox(width: DimensionConstants.d8.w),
                   SizedBox(
                     width: DimensionConstants.d210.w,
                     child:  Text(projectName).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.left, color: ColorConstants.colorGray3, maxLines: 1, overflow: TextOverflow.ellipsis)
                   ),
                     Expanded(child: Align(
                      alignment: Alignment.centerRight,
                        child: ImageView(path: ImageConstants.nextIconIos, color: (Theme.of(context).brightness == Brightness.dark ? ColorConstants.colorWhite : ColorConstants.colorBlack))))
                  ],
                ),
              ),
              const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
              SizedBox(height: DimensionConstants.d16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(totalHours).semiBoldText(context, DimensionConstants.d20.sp, TextAlign.left, color: ColorConstants.colorGray3),
                      SizedBox(height: DimensionConstants.d4.h),
                      Text("total_hours".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left, color: ColorConstants.colorGray3)
                    ],
                  ),
                  Column(
                    children: [
                      Text(crew).semiBoldText(context, DimensionConstants.d20.sp, TextAlign.left, color: ColorConstants.colorGray3),
                      SizedBox(height: DimensionConstants.d4.h),
                      Text("crew".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.left, color: ColorConstants.colorGray3)
                    ],
                  )
                ],
              ),
              SizedBox(height: DimensionConstants.d15.h),
            ],
          ),
        ),
      ),
    );
  }
}
