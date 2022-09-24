import 'dart:math';

import 'package:flutter/material.dart';

class AllCheckoutProjectCrewResponse {
  AllCheckoutProjectCrewResponse({
    this.success,
    this.activeProject,
    this.projectData,
  });

  bool? success;
  int? activeProject;
  List<ProjectDetail>? projectData;

  factory AllCheckoutProjectCrewResponse.fromJson(Map<String, dynamic> json) =>
      AllCheckoutProjectCrewResponse(
        success: json["success"],
        activeProject: json["activeProject"],
        projectData: List<ProjectDetail>.from(
            json["projectData"].map((x) => ProjectDetail.fromJson(x))),
      );
}

class ProjectDetail {
  ProjectDetail({
    this.id,
    this.projectName,
    this.crewId,
    this.checkins,
    this.totalHours,
  });

  String? id;
  String? projectName;
  List<String>? crewId;
  List<Checkin>? checkins;
  double? totalHours;
  Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  factory ProjectDetail.fromJson(Map<String, dynamic> json) => ProjectDetail(
        id: json["_id"],
        projectName: json["projectName"],
        crewId: List<String>.from(json["crewId"].map((x) => x)),
        checkins: List<Checkin>.from(
            json["checkins"].map((x) => Checkin.fromJson(x))),
        totalHours: double.parse(json["totalHours"].toString()??"0.0"),
      );
}

class Checkin {
  Checkin({
    this.id,
    this.crewId,
    this.assignProjectId,
    this.checkInTime,
    this.hoursDiff,
    this.checkOutTime,
  });

  String? id;
  String? crewId;
  String? assignProjectId;
  String? checkInTime;
  int? hoursDiff;
  String? checkOutTime;

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
        id: json["_id"],
        crewId: json["crewId"],
        assignProjectId: json["assignProjectId"],
        checkInTime: json["checkInTime"],
        hoursDiff: json["hoursDiff"],
        checkOutTime: json["checkOutTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "crewId": crewId,
        "assignProjectId": assignProjectId,
        "checkInTime": checkInTime,
        "hoursDiff": hoursDiff,
        "checkOutTime": checkOutTime,
      };
}
