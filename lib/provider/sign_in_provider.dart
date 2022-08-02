import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/material.dart';

class SignInProvider extends BaseProvider{
  TabController? tabController;
  int selectedIndex = 0;

  bool emailContentPadding = false;
  bool passwordContentPadding = false;
  bool emailContentPadding1 = false;
  bool passwordContentPadding1 = false;
  bool passwordVisible = false;
  bool rememberMeValue = false;

  bool tab0 = true;
  bool tab1 = true;

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }
}