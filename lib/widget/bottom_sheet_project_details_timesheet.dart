
import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/route_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/helper/date_function.dart';
import 'package:beehive/views_manager/projects_manager/crew_profile_page_manager.dart';
import 'package:beehive/views_manager/projects_manager/timesheets_screen_manager.dart';
import 'package:beehive/views_manager/projects_manager/timesheets_screen_project_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/image_constants.dart';
import '../model/project_timesheet_response.dart';
import 'image_view.dart';

bottomSheetProjectDetailsTimeSheet(BuildContext context, int listIndex, {required VoidCallback onTap, required bool timeSheetOrSchedule,    ProjectData? projectData,  Color? projectColor, List<Crew>? crews,
}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DimensionConstants.d30.r),
              topRight: Radius.circular(DimensionConstants.d30.r))),
      context: context,
      builder: (context) {
        return Stack(
          children: [
            SizedBox(
              height: DimensionConstants.d380.h,
              child: Padding(
                padding: EdgeInsets.only(top: DimensionConstants.d40.h),
                child: Container(
                 // height: DimensionConstants.d240.h,
                  width: DimensionConstants.d375.w,
                  decoration: BoxDecoration(
                    color: ColorConstants.colorWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DimensionConstants.d41.r),
                        topRight: Radius.circular(DimensionConstants.d41.r)),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: DimensionConstants.d28.h,
                      ),
                      projectInformation(context, projectData!, projectColor),
                      SizedBox(
                        height: DimensionConstants.d15.h,
                      ),
                      crewOnThisProjectListView(context, timeSheetOrSchedule, projectData, listIndex),
                      SizedBox(
                        height: DimensionConstants.d10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: DimensionConstants.d300.h,
                left: DimensionConstants.d270.w,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const ImageView(
                    path: ImageConstants.crossIcon,
                  ),
                )),
          ],
        );
      });
}

Widget projectInformation(BuildContext context, ProjectData projectData, color){
  return Column(
    children:<Widget> [
      Container(
        height: DimensionConstants.d40.h,
        width: DimensionConstants.d40.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(DimensionConstants.d20.r),
        ),
        child: Center(
          child: Text(projectData.projectName.toString().substring(0,2).toUpperCase()).boldText(context, DimensionConstants.d16.sp, TextAlign.center,color: ColorConstants.colorWhite),
        )
      ),
      SizedBox(height: DimensionConstants.d11.h,),
      Text(projectData.projectName.toString()).boldText(context, DimensionConstants.d18.sp, TextAlign.center,color: ColorConstants.colorBlack,
          maxLines: 1, overflow: TextOverflow.ellipsis),
      SizedBox(height: DimensionConstants.d6.h,),
      Text(DateFunctions.dateTimeWithWeek(DateTime.parse(projectData.date.toString()).toLocal())).boldText(context, DimensionConstants.d16.sp, TextAlign.center,color: ColorConstants.colorBlack),
    ],
  );

}

Widget crewOnThisProjectListView(BuildContext context,bool timeSheetOrSchedule, ProjectData projectData, int listIndex){
  return SizedBox(
    height: DimensionConstants.d180.h,
    child: ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: projectData.checkins.length,
        itemBuilder: (context, index){
      return projectData.checkins[index].crew!.isNotEmpty? userProfile(context,index, timeSheetOrSchedule, projectData.checkins[index].crew![0], projectData):Container();
    }, separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 8,);
    },),
  );
}

Widget userProfile(BuildContext context,int index, bool timeSheetOrSchedule, Crew crewData, ProjectData projectData){
  return GestureDetector(
    onTap: (){
      if(timeSheetOrSchedule == true){
        Navigator.of(context).pop();
       // Navigator.pushNamed(context, RouteConstants.crewPageProfileManager, arguments: CrewProfilePageManager(projectName: projectData.projectName ?? "", crewData: crewData, projectId: projectData.sId ?? "",));
      }else{
        Navigator.of(context).pop();
        Navigator.pushNamed(context, RouteConstants.timeSheetScreenProjectDetails,arguments: TimeSheetsScreenProjectDetails(removeInterruption: false, projectData: projectData, index: index,));
      }

    },
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
        child: Container(
          height: DimensionConstants.d76.h,
          width: DimensionConstants.d343.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
            child: Row(
              children:<Widget> [
              crewData.profileImage == null ?
                  Container(
                    height: DimensionConstants.d50.h,
                    width: DimensionConstants.d50.w,
                    decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                      shape: BoxShape.circle
                    ),
                  )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(DimensionConstants.d50.r),
                    child: SizedBox(
                    height: DimensionConstants.d50.h,
                    width: DimensionConstants.d50.w,
                    child: ImageView(path: (ApiConstantsCrew.BASE_URL_IMAGE + crewData.profileImage.toString()),
                    fit: BoxFit.contain,
                    ),
                ),
                  ),
                SizedBox(width: DimensionConstants.d16.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget> [
                    Text(crewData.name.toString()).boldText(context, DimensionConstants.d16.sp, TextAlign.left,color: ColorConstants.deepBlue),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget> [
                       Text(crewData.speciality ?? "").regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.deepBlue),
                       SizedBox(width: DimensionConstants.d6.w,),
                       Container(height: DimensionConstants.d3.h,width: DimensionConstants.d3.w,
                       decoration: BoxDecoration(
                         color: ColorConstants.deepBlue,
                         borderRadius: BorderRadius.circular(DimensionConstants.d5.r),
                       ),
                       ),
                       SizedBox(width: DimensionConstants.d6.w,),
                       Text("${DateFunctions.minutesToHourString(projectData.checkins[index].hoursDiff!)}" " Hours" ?? "").regularText(context, DimensionConstants.d14.sp, TextAlign.left,color: ColorConstants.deepBlue),
                     ],
                   )
                  ],
                ),
                Expanded(child: Container()),
                ImageView(path: ImageConstants.arrowIcon,
                width: DimensionConstants.d10.w,
                height: DimensionConstants.d14.h,)

              ],
            ),
          ),
        ),
      ),
    ),
  );


}
