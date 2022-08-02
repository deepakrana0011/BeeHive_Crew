import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:beehive/helper/common_widgets.dart';
import 'package:beehive/provider/introduction_provider.dart';
import 'package:beehive/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPages extends StatefulWidget {
  const IntroductionPages({Key? key}) : super(key: key);

  @override
  _IntroductionPagesState createState() => _IntroductionPagesState();
}

class _IntroductionPagesState extends State<IntroductionPages> {

@override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  PageController? controller;
  @override
  Widget build(BuildContext context) {

    return BaseView<IntroductionProvider>(
      onModelReady: (provider){
        provider.setUpIntroductionList();
      },
        builder: (context, provider, _){
          return Scaffold(
            backgroundColor: ColorConstants.deepBlue,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: DimensionConstants.d32.w, right: DimensionConstants.d32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: DimensionConstants.d587.h,
                      child: PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: provider.introWidgetsList.length,
                        onPageChanged: (int page) {
                       //   provider.pageChange(page);
                          provider.updateLoadingStatus(true);
                        },
                        controller: controller,
                        itemBuilder: (context, index) {
                          return provider.introWidgetsList[index];
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: controller!,
                      count: provider.introWidgetsList.length,
                      axisDirection: Axis.horizontal,
                      effect: WormEffect(dotColor: Colors.grey,
                          activeDotColor: ColorConstants.primaryColor,
                          dotWidth: DimensionConstants.d8.w,
                          dotHeight: DimensionConstants.d9.h),
                    ),
                    SizedBox(height: DimensionConstants.d113.h),
                    CommonWidgets.signInCreateAccountRow(context)
                  ],
                ),
              ),
            ),
          );
    });
  }
}
