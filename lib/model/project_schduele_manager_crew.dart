import 'dart:math';

import 'package:flutter/material.dart';

class ProjectScheduleManagerCrew {
  bool? success;
  List<Data> data = [];

  ProjectScheduleManagerCrew.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data.add(Data.fromJson(v)); });
    }
  }
}

class Data {
  String? weekId;
  List<ProjectName> projectName = [];

  Data.fromJson(Map<String, dynamic> json) {
    weekId = json['_id'];
    if (json['projectName'] != null) {
      projectName = <ProjectName>[];
      json['projectName'].forEach((v) { projectName.add(ProjectName.fromJson(v)); });
    }
  }

}

class ProjectName {
  String? projectName;
  String? sId;
  Color? color;

  ProjectName({this.projectName, this.sId, this.color});

  ProjectName.fromJson(Map<String, dynamic> json) {
    projectName = json['projectName'];
    sId = json['_id'];
  }

}

