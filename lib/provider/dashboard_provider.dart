import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends BaseProvider{

  bool checkedInNoProjects = false;

  TabController? controller;
  int selectedIndex = 0;
}