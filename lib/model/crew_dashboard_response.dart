import 'dart:math';

import 'package:flutter/material.dart';

class CrewDashboardResponse {
  CrewDashboardResponse({
    this.success,
    this.crew,
    this.projects,
    this.allCheckin,
    this.userCheckin,
  });

  bool? success;
  CrewDetail? crew;
  int? projects;
  List<CheckInProjectDetail>? allCheckin;
  CheckInProjectDetail? userCheckin;

  factory CrewDashboardResponse.fromJson(Map<String, dynamic> json) =>
      CrewDashboardResponse(
        success: json["success"],
        crew: CrewDetail.fromJson(json["crew"]),
        projects: json["projects"],
        allCheckin: json["allCheckin"] != null
            ? List<CheckInProjectDetail>.from(
                json["allCheckin"].map((x) => CheckInProjectDetail.fromJson(x)))
            : [],
        userCheckin: json["userCheckin"] != null
            ? CheckInProjectDetail.fromJson(json["userCheckin"])
            : null,
      );
}

class CheckInProjectDetail {
  CheckInProjectDetail({
    this.id,
    this.crewId,
    this.assignProjectId,
    this.checkInTime,
    this.hoursDiff,
    this.allCheckinBreak,
    this.status,
    this.interuption,
    this.createdAt,
    this.v,
    this.checkOutTime,
  });

  String? id;
  String? crewId;
  AllCheckinAssignProjectId? assignProjectId;
  String? checkInTime;
  int? hoursDiff;
  List<Break>? allCheckinBreak;
  int? status;
  List<Interruption>? interuption;
  DateTime? createdAt;
  int? v;
  String? checkOutTime;
  Color color= Colors.primaries[Random().nextInt(Colors.primaries.length)];


  factory CheckInProjectDetail.fromJson(Map<String, dynamic> json) =>
      CheckInProjectDetail(
        id: json["_id"],
        crewId: json["crewId"],
        assignProjectId:
            AllCheckinAssignProjectId.fromJson(json["assignProjectId"]),
        checkInTime: json["checkInTime"],
        hoursDiff: json["hoursDiff"],
        allCheckinBreak: json["break"] != null
            ? List<Break>.from(json["break"].map((x) => Break.fromJson(x)))
            : [],
        status: json["status"],
        interuption: json["interuption"] != null
            ? List<Interruption>.from(
                json["interuption"].map((x) => Interruption.fromJson(x)))
            : [],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        checkOutTime: "2022-09-22 19:34",
      );
}

class Break {
  Break({
    this.startTime,
    this.interval,
    this.id,
  });

  String? startTime;
  String? interval;
  String? id;

  factory Break.fromJson(Map<String, dynamic> json) => Break(
        startTime: json["startTime"],
        interval: json["interval"],
        id: json["_id"],
      );
}

class Interruption {
  Interruption({
    this.startTime,
    this.endTime,
    this.id,
  });

  String? startTime;
  String? endTime;
  String? id;
  bool? selfMadeInterruption=false;
  int ? type;  //  1 actual working hour, 2- interrption 3 break

  factory Interruption.fromJson(Map<String, dynamic> json) => Interruption(
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["_id"],
      );
}

class CrewDetail {
  CrewDetail({
    this.id,
    this.email,
    this.name,
    this.password,
    this.status,
    this.createdAt,
    this.v,
  });

  String? id;
  String? email;
  String? name;
  String? password;
  int? status;
  DateTime? createdAt;
  int? v;

  factory CrewDetail.fromJson(Map<String, dynamic> json) => CrewDetail(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );
}

class ProjectRate {
  ProjectRate({
    this.crewId,
    this.price,
    this.id,
  });

  String? crewId;
  String? price;
  String? id;

  factory ProjectRate.fromJson(Map<String, dynamic> json) => ProjectRate(
        crewId: json["crewId"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "crewId": crewId,
        "price": price,
        "_id": id,
      };
}

class AllCheckinAssignProjectId {
  AllCheckinAssignProjectId({
    this.id,
    this.managerId,
    this.projectName,
    this.address,
    this.latitude,
    this.longitude,
    this.locationRadius,
    this.crewId,
    this.workDays,
    this.hoursFrom,
    this.hoursTo,
    this.afterHoursRate,
    this.assignProjectIdBreak,
    this.roundTimesheets,
    this.sameRate,
    this.projectRate,
    this.status,
    this.createdAt,
    this.v,
  });

  String? id;
  String? managerId;
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  List<String>? crewId;
  List<String>? workDays;
  String? hoursFrom;
  String? hoursTo;
  String? afterHoursRate;
  List<Break>? assignProjectIdBreak;
  String? roundTimesheets;
  String? sameRate;
  List<ProjectRate>? projectRate;
  int? status;
  DateTime? createdAt;
  int? v;

  factory AllCheckinAssignProjectId.fromJson(Map<String, dynamic> json) =>
      AllCheckinAssignProjectId(
        id: json["_id"],
        managerId: json["managerId"] ?? null,
        projectName: json["projectName"] ?? null,
        address: json["address"] ?? null,
        latitude: json["latitude"] ?? null,
        longitude: json["longitude"] ?? null,
        locationRadius: json["locationRadius"] ?? null,
        crewId: json["crewId"] != null
            ? List<String>.from(json["crewId"].map((x) => x))
            : [],
        workDays: json["workDays"] != null
            ? List<String>.from(json["workDays"].map((x) => x))
            : [],
        hoursFrom: json["hoursFrom"] ?? null,
        hoursTo: json["hoursTo"] ?? null,
        afterHoursRate: json["afterHoursRate"] ?? null,
        assignProjectIdBreak: json["break"] != null
            ? List<Break>.from(json["break"].map((x) => Break.fromJson(x)))
            : [],
        roundTimesheets: json["roundTimesheets"] ?? null,
        sameRate: json["sameRate"] ?? null,
        projectRate: json["projectRate"] != null
            ? List<ProjectRate>.from(
                json["projectRate"].map((x) => ProjectRate.fromJson(x)))
            : [],
        status: json["status"] ?? null,
      );
}
