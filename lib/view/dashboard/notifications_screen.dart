import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/widget/image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/dialog_helper.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("notifications".tr()).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center),
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.keyboard_backspace, color: Theme.of(context).iconTheme.color, size: 28,)),
      ),
      body: Column(
        children: [
          SizedBox(height: DimensionConstants.d5.h),
          const Divider(color: ColorConstants.colorGreyDrawer, height: 0.0, thickness: 1.5),
          SizedBox(height: DimensionConstants.d8.h),
          invitedNotificationContainer(context, "Benjamin Poole", "Nov 2nd, 2021", "09:23 pm"),
          divider(),
          newMessageNewSiteNotificationContainer(context, "Katharine Wells", "Nov 2nd, 2021", "09:23 pm", "You have recieved a new message from @johnsmith."),
          divider(),
          newMessageNewSiteNotificationContainer(context, "Bertha Ramos", "Nov 2nd, 2021", "09:23 pm", "Hi @johnsmith, new site assigned by your crew manager."),
        ],
      ),
    );
  }

  Widget invitedNotificationContainer(BuildContext context, String userName, String date, String time){
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                DialogHelper.notificationDialog(
                  context,
                  photoFromCamera: () {},
                  photoFromGallery: () {},
                ));;
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d18.w, vertical: DimensionConstants.d24.h),
        child: Row(
          children: [
            SizedBox(
              width: DimensionConstants.d50.w,
              height: DimensionConstants.d50.h,
              child: const ImageView(path: ImageConstants.timeSheetsProfile, fit: BoxFit.cover),
            ),
            SizedBox(width: DimensionConstants.d23.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center),
                SizedBox(height: DimensionConstants.d4.h),
                Row(
                  children: [
                    const Icon(Icons.circle, color: ColorConstants.colorOrangeSienna, size: 16,),
                    SizedBox(width: DimensionConstants.d8.w),
                    Text(date).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
                    SizedBox(width: DimensionConstants.d8.w),
                    const Icon(Icons.circle, color: ColorConstants.colorGray2, size: 8,),
                    SizedBox(width: DimensionConstants.d8.w),
                    Text(time).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
                  ],
                ),
                SizedBox(height: DimensionConstants.d8.h),
                Text("invited_to_join_new_project".tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget newMessageNewSiteNotificationContainer(BuildContext context, String userName, String date, String time, String notificationText){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d18.w, vertical: DimensionConstants.d24.h),
      child: Row(
        children: [
          SizedBox(
            width: DimensionConstants.d50.w,
            height: DimensionConstants.d50.h,
            child: const ImageView(path: ImageConstants.timeSheetsProfile, fit: BoxFit.cover),
          ),
          SizedBox(width: DimensionConstants.d23.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName).semiBoldText(context, DimensionConstants.d14.sp, TextAlign.center),
              SizedBox(height: DimensionConstants.d4.h),
              Row(
                children: [
                  Text(date).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
                  SizedBox(width: DimensionConstants.d8.w),
                  const Icon(Icons.circle, color: ColorConstants.colorC4C4C4, size: 8,),
                  SizedBox(width: DimensionConstants.d8.w),
                  Text(time).regularText(context, DimensionConstants.d14.sp, TextAlign.center),
                ],
              ),
              SizedBox(height: DimensionConstants.d8.h),
              SizedBox(
                width: DimensionConstants.d247.w,
                child:
                Text(notificationText).
                regularText(context, DimensionConstants.d14.sp, TextAlign.left, maxLines: 2, overflow: TextOverflow.ellipsis, color: ColorConstants.colorGray3),

              )
            ],
          )
        ],
      ),
    );
  }


  Widget divider(){
    return Padding(
      padding: EdgeInsets.only(left: DimensionConstants.d20.w, right: DimensionConstants.d28.w),
      child:  const Divider(color: ColorConstants.color5E6272, height: 0.0),
    );
  }
}
