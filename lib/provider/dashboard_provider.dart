import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends BaseProvider{

  bool checkedInNoProjects = false;

  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;

  String? checkIn;
  List<String> checkInItems = ["123 Main St., Toronto, ON", "123 Main St1., Toronto, ON", "123 Main St2., Toronto, ON"];


}