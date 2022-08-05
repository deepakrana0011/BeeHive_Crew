

import 'package:beehive/extension/all_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constants.dart';
import '../constants/dimension_constants.dart';


class DialogHelper {


  static getPhotoDialog(
      BuildContext context,
      {required VoidCallback photoFromGallery, required VoidCallback photoFromCamera}) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: DimensionConstants.d10.w,right: DimensionConstants.d10.w,top: DimensionConstants.d560.h),
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(DimensionConstants.d10.r),
      ),
      child: Container(
        height: DimensionConstants.d195.h,
        decoration: BoxDecoration(
            color:  Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite90:ColorConstants.grayD8D8D8,
            borderRadius: BorderRadius.circular(DimensionConstants.d12.r)),
        child: Column(
          children: <Widget>[
           Container(
             height: DimensionConstants.d123.h,
             decoration: BoxDecoration(
               color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorBlack:ColorConstants.colorWhite,
               borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
               border: Border.all(color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:Colors.transparent,width: DimensionConstants.d1.w)
             ),
             child: Column(
               children:<Widget> [
                GestureDetector(
                  onTap: photoFromGallery,
                  child: Container(
                    width: double.maxFinite,
                    color: Colors.transparent,
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.only(top: DimensionConstants.d25.h,bottom: DimensionConstants.d15.h),
                        child: Text("photo_gallery".tr()).regularText(context, DimensionConstants.d18.sp, TextAlign.center,color:Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.blue007AFF, ),
                      ),
                    ),
                  ),
                ),
                 Container(
                   height: DimensionConstants.d1.h,
                   color:  Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.grayD2D2D7,
                 ),
                 GestureDetector(
                   onTap: photoFromCamera ,
                   child: Container(
                     width: double.maxFinite,
                     color: Colors.transparent,
                     child: Center(
                       child: Padding(
                         padding:  EdgeInsets.only(top: DimensionConstants.d15.h,),
                         child: Text("camera".tr()).regularText(context, DimensionConstants.d18.sp, TextAlign.center,color:Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.blue007AFF, ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.maxFinite,
                height: DimensionConstants.d60.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorBlack:ColorConstants.colorWhite,
                    borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
                    border: Border.all(color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:Colors.transparent,width: DimensionConstants.d1.w)
                ),
                child: Padding(
              padding:  EdgeInsets.only(top: DimensionConstants.d20.h,),
        child: Text("cancel".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.center,color:Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.blue007AFF, ),
      ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  static callDialogBox(
      BuildContext context,
      {required VoidCallback photoFromGallery, required VoidCallback photoFromCamera}) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: DimensionConstants.d10.w,right: DimensionConstants.d10.w,top: DimensionConstants.d510.h),
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(DimensionConstants.d10.r),
      ),
      child: Container(
        height: DimensionConstants.d256.h,
        decoration: BoxDecoration(
            color:  Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite90:ColorConstants.grayD8D8D8,
            borderRadius: BorderRadius.circular(DimensionConstants.d12.r)),
        child: Column(
          children: <Widget>[
            Container(
              height: DimensionConstants.d185.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorBlack:ColorConstants.colorWhite,
                  borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
                  border: Border.all(color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:Colors.transparent,width: DimensionConstants.d1.w)
              ),
              child: Column(
                children:<Widget> [
                  GestureDetector(
                    onTap: photoFromGallery,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.only(top: DimensionConstants.d25.h,bottom: DimensionConstants.d15.h),
                          child: Text("Call 416 555 1234").regularText(context, DimensionConstants.d18.sp, TextAlign.center,color:Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.blue007AFF, ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: DimensionConstants.d1.h,
                    color:  Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.grayD2D2D7,
                  ),
                  GestureDetector(
                    onTap: photoFromGallery,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.only(top: DimensionConstants.d20.h,bottom: DimensionConstants.d15.h),
                          child: Text("send_message".tr()).regularText(context, DimensionConstants.d18.sp, TextAlign.center,color:Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.blue007AFF, ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: DimensionConstants.d1.h,
                    color:  Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.grayD2D2D7,
                  ),
                  GestureDetector(
                    onTap: photoFromCamera ,
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.only(top: DimensionConstants.d15.h,),
                          child: Text("add_to_contacts".tr()).regularText(context, DimensionConstants.d18.sp, TextAlign.center,color:Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.blue007AFF, ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.maxFinite,
                height: DimensionConstants.d60.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorBlack:ColorConstants.colorWhite,
                    borderRadius: BorderRadius.circular(DimensionConstants.d10.r),
                    border: Border.all(color: Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:Colors.transparent,width: DimensionConstants.d1.w)
                ),
                child: Padding(
                  padding:  EdgeInsets.only(top: DimensionConstants.d20.h,),
                  child: Text("cancel".tr()).boldText(context, DimensionConstants.d18.sp, TextAlign.center,color:Theme.of(context).brightness == Brightness.dark? ColorConstants.colorWhite:ColorConstants.blue007AFF, ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }





}
