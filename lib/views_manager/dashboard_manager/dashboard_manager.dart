import 'package:beehive/enum/enum.dart';
import 'package:beehive/extension/all_extensions.dart';
import 'package:beehive/provider/dashboard_page_manager_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:beehive/widget/custom_tab_bar.dart';
import 'package:beehive/widget/custom_tab_bar_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../../constants/dimension_constants.dart';
import '../../locator.dart';
import '../../provider/bottom_bar_provider.dart';



class DashBoardPageManager extends StatefulWidget {
  const DashBoardPageManager({Key? key}) : super(key: key);

  @override
  _DashBoardPageManagerState createState() => _DashBoardPageManagerState();
}

class _DashBoardPageManagerState extends State<DashBoardPageManager> with TickerProviderStateMixin {

  DashBoardPageManagerProvider provider = locator<DashBoardPageManagerProvider>();

  @override
  Widget build(BuildContext context) {
    return BaseView<DashBoardPageManagerProvider>(
        onModelReady: (provider) {
          this.provider = provider;
          provider.dashBoardApi(context,);
        },
        builder: (context, provider, _) {
          return Scaffold(
            body:provider.state == ViewState.idle? Column(
              children:<Widget> [
                activeProjectWidget(context,provider),
                CustomTabBarManager()
              ],
            ):Center(child: CircularProgressIndicator(color: ColorConstants.primaryGradient2Color,),),

          );
        });
  }
}

Widget activeProjectWidget(BuildContext context, DashBoardPageManagerProvider provider){
  return Container(
    height: DimensionConstants.d151.h,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [ColorConstants.blueGradient1Color,ColorConstants.blueGradient2Color])
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: DimensionConstants.d16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          SizedBox(height: DimensionConstants.d16.h,),
          const Text("Hey John,\nwhat’s buzzing?").boldText(context, DimensionConstants.d18.sp, TextAlign.left,color: ColorConstants.colorWhite),
          SizedBox(height: DimensionConstants.d10.h,),
          Row(
            children:<Widget> [
              crewAndActiveProject(context,provider.responseManager!.data.toString(),"active_projects"),
              Expanded(child: Container()),
              crewAndActiveProject(context,provider.responseManager!.crewMembers.toString(),"crew_members"),
            ],
          ),

        ],
      ),
    ),
  );
}
Widget crewAndActiveProject(BuildContext context,String number,String tabName){
  return Container(
    height: DimensionConstants.d65.h,
    width: DimensionConstants.d169.w,
    decoration: BoxDecoration(
      color: ColorConstants.deepBlue,
      borderRadius: BorderRadius.circular(DimensionConstants.d8.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
        Text(number).semiBoldText(context, DimensionConstants.d22.sp, TextAlign.center,color: ColorConstants.colorWhite),
        Text(tabName.tr()).regularText(context, DimensionConstants.d14.sp, TextAlign.center,color: ColorConstants.colorWhite),
      ],
    ),
  );


}

