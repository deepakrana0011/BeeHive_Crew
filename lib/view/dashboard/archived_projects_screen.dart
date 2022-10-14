

import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/provider/archive_projects_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/projects/project_details_page.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constants.dart';
import '../../helper/common_widgets.dart';

class ArchivedProjectsScreen extends StatelessWidget {
  const ArchivedProjectsScreen({Key? key}) : super(key: key);

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
      body: BaseView<ArchiveProjectsProvider>(
        onModelReady: (provider){
          provider.archiveProjectsCrew(context);
        },
        builder: (context, provider, _){
          return provider.state == ViewState.busy ? const CustomCircularBar() : ( provider.allArchiveProjectsResponse!.projectData.isEmpty ? Center(
            child:  Text("sorry_no_data_found".tr()).mediumText(context, DimensionConstants.d15.sp, TextAlign.left, color: ColorConstants.colorBlack),
          ) :  SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: DimensionConstants.d5.h),
                const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
                SizedBox(height: DimensionConstants.d11.h),
                allArchiveProjects(provider),
                SizedBox(height: DimensionConstants.d20.h,),
                // Padding(
                //   padding:  EdgeInsets.symmetric(
                //       horizontal: DimensionConstants.d16.w),
                //   child: CommonWidgets.commonButton(
                //       context, "create_a_new_project".tr(),
                //       color1: ColorConstants.primaryGradient2Color,
                //       color2: ColorConstants.primaryGradient1Color,
                //       fontSize: DimensionConstants.d14.sp, onBtnTap: () {
                //   },
                //       shadowRequired: true
                //   ),
                // ),

              ],
            ),
          ));
        },
      ),
    );
  }

  Widget allArchiveProjects(ArchiveProjectsProvider provider){
    return ListView.builder(
        itemCount: provider.allArchiveProjectsResponse!.projectData.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index){
          return archivedProjectCard(context, provider.allArchiveProjectsResponse!.projectData[index].projectName.toString()
              , provider.allArchiveProjectsResponse!.projectData[index].totalHours.toString(),
              provider.allArchiveProjectsResponse!.projectData[index].crew.toString(),
              provider.allArchiveProjectsResponse!.projectData[index].sId.toString());
        });
  }

  Widget archivedProjectCard(BuildContext context, String projectName, String totalHours, String crew, String projectId){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RouteConstants.projectDetailsPage,arguments: ProjectDetailsPage(archivedOrProject: true, projectId: projectId,));
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
