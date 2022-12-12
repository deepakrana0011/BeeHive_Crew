import 'package:beehive/extension/all_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/dimension_constants.dart';

class PrivacyPolicyScreen extends StatelessWidget{
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       elevation: 0.0,
       centerTitle: true,
       title: Text("privacy_policy".tr())
           .semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center),
       leading: GestureDetector(
           onTap: () {
             Navigator.of(context).pop();
           },
           child: Icon(
             Icons.keyboard_backspace,
             color: Theme.of(context).iconTheme.color,
             size: 28,
           )),
     ),
   );
  }

}