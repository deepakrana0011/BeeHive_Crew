

import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/view/projects/project_details_page.dart';
import 'package:beehive/views_manager/bottom_bar_manager/bottom_navigation_bar_manager.dart';
import 'package:beehive/views_manager/projects_manager/archived_project_details_manager.dart';
import 'package:beehive/views_manager/projects_manager/project_details_manager.dart';
import 'package:beehive/widget/custom_circular_bar.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../helper/common_widgets.dart';
import '../../provider/bottom_bar_Manager_provider.dart';

class ArchivedProjectsScreenManager extends StatefulWidget {
  const ArchivedProjectsScreenManager({Key? key}) : super(key: key);

  @override
  State<ArchivedProjectsScreenManager> createState() => _ArchivedProjectsScreenManagerState();
}

class _ArchivedProjectsScreenManagerState extends State<ArchivedProjectsScreenManager> {
  get ommonWidgets => null;



  @override
  Widget build(BuildContext context) {
 final dashBoardProvider = Provider.of<BottomBarManagerProvider>(context, listen: false);
    return BaseView<BottomBarManagerProvider>(onModelReady: (provider){
      provider.allArchiveProjects(context);
    }, builder: (context,provider,_){
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text("archived_projects".tr()).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center),
          leading: GestureDetector(
              onTap: (){
               Navigator.pushNamed(context, RouteConstants.bottomBarManager,arguments: BottomBarManager(fromBottomNav: 1, pageIndex: 0));
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
        body: provider.state == ViewState.busy ? const CustomCircularBar() : ( provider.allArchiveProjectsResponse!.projectData.isEmpty ? Center(
          child:  Text("sorry_no_data_found".tr()).mediumText(context, DimensionConstants.d15.sp, TextAlign.left, color: ColorConstants.colorBlack),
        ) :  SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: DimensionConstants.d5.h),
              const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
              SizedBox(height: DimensionConstants.d11.h),
              allArchiveProjects(dashBoardProvider, provider),
              SizedBox(height: DimensionConstants.d128.h,),
            ],
          ),
        )),
      );
    });
  }

  Widget allArchiveProjects( BottomBarManagerProvider dashBoardProvider, provider){
    return ListView.builder(
      itemCount: provider.allArchiveProjectsResponse!.projectData.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index){
      return archivedProjectCard(context, provider.allArchiveProjectsResponse!.projectData[index].projectName.toString()
          , provider.allArchiveProjectsResponse!.projectData[index].totalHours.toString(),
          provider.allArchiveProjectsResponse!.projectData[index].crew.toString(),
          provider.allArchiveProjectsResponse!.projectData[index].sId.toString()
          ,dashBoardProvider, provider);
    });
  }

  Widget archivedProjectCard(BuildContext context, String projectName, String totalHours, String crew, String projectId,BottomBarManagerProvider dashBoardProvider, provider){
    return GestureDetector(
      onTap: (){
        dashBoardProvider.onItemTapped(1);
        dashBoardProvider.updateNavigationValue(5, projectId: projectId, archiveProject: true);
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
