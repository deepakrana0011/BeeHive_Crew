import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class GetCrewResponseTimeSheet {
  GetCrewResponseTimeSheet({
    this.success,
    this.crew,
    this.activeProject,
    this.projectData,
  });

  bool? success;
  List<Crew>? crew;
  int? activeProject;
  List<ProjectDatum>? projectData;

  factory GetCrewResponseTimeSheet.fromJson(Map<String, dynamic> json) =>
      GetCrewResponseTimeSheet(
        success: json["success"],
        crew: List<Crew>.from(json['crew'].map((x) => Crew.fromJson(x))),
        activeProject: json["activeProject"],
        projectData: List<ProjectDatum>.from(
            json["projectData"].map((x) => ProjectDatum.fromJson(x))),
      );
}

class Crew {
  Crew(
      {this.id,
      this.email,
      this.name,
      this.password,
      this.status,
      this.createdAt,
      this.v,
      this.countryCode,
      this.phoneNumber,
      this.address,
      this.company,
      this.position,
      this.profileImage,
      this.speciality,
      this.projectRate,
      this.certificationList});

  String? id;
  String? email;
  String? name;
  String? password;
  int? status;
  DateTime? createdAt;
  int? v;
  String? countryCode;
  int? phoneNumber;
  String? address;
  String? company;
  String? position;
  String? profileImage;
  String? speciality;
  String? projectRate;
  List<Certs>? certificationList;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        company: json["company"],
        position: json["position"],
        profileImage: json["profileImage"],
        speciality: json["speciality"],
        projectRate: json["projectRate"],
        // certificationList: json['certs'] != null? List<Certs>.from(json['certs'].map((x) => Certs.fromJson(x))): []
      );
}

class ProjectDatum {
  ProjectDatum(
      {this.id,
      this.date,
      this.projectDatumId,
      this.projectName,
      this.crewId,
      this.checkins,
      this.color});

  String? id;
  DateTime? date;
  String? projectDatumId;
  String? projectName;
  List<String>? crewId;
  List<Checkin>? checkins;
  String? color;

  factory ProjectDatum.fromJson(Map<String, dynamic> json) => ProjectDatum(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        projectDatumId: json["id"],
        projectName: json["projectName"],
        color: json["color"],
        crewId: json["crewId"]==null?[]:List<String>.from(json["crewId"].map((x) => x)),
        checkins: List<Checkin>.from(json["checkins"].map((x) => Checkin.fromJson(x))),
      );
}

class Checkin {
  Checkin({
    this.id,
    this.crewId,
    this.checkInTime,
    this.hoursDiff,
    this.checkinBreak,
    this.interuption,
    this.checkOutTime,
    this.date,
  });

  String? id;
  String? crewId;
  String? checkInTime;
  int? hoursDiff;
  List<Break>? checkinBreak;
  List<Interuption>? interuption;
  String? checkOutTime;
  DateTime? date;

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
        id: json["_id"],
        crewId: json["crewId"],
        checkInTime: json["checkInTime"],
        hoursDiff: json["hoursDiff"],
        checkinBreak:
            List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
        interuption: List<Interuption>.from(
            json["interuption"].map((x) => Interuption.fromJson(x))),
        checkOutTime: json["checkOutTime"],
        date: DateTime.parse(json["date"]),
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

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "interval": interval,
        "_id": id,
      };
}

class Interuption {
  Interuption({
    this.startTime,
    this.endTime,
    this.id,
  });

  String? startTime;
  String? endTime;
  String? id;
  bool? selfMadeInterruption = false;
  int? type; //  1 actual working hour, 2- interrption 3 break

  factory Interuption.fromJson(Map<String, dynamic> json) => Interuption(
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["_id"],
      );
}

class Certs {
  String? id;
  String? crewId;
  String? certName;
  String? certImage;
  List<PvtNotes>? privateNote;

  Certs(
      {this.crewId, this.privateNote, this.id, this.certImage, this.certName});

  factory Certs.fromJson(Map<String, dynamic> json) => Certs(
      id: json['id'],
      crewId: json['crewId'],
      certName: json['certName'],
      certImage: json['certImage'],
      privateNote: List<PvtNotes>.from(
          json['pvtNotes'].map((x) => PvtNotes.fromJson(x))));
}

class PvtNotes {
  String? id;
  String? managerId;
  String? crewId;
  String? title;
  String? note;
  int? status;
  String? sid;

  PvtNotes(
      {this.id,
      this.crewId,
      this.sid,
      this.status,
      this.note,
      this.title,
      this.managerId});

  factory PvtNotes.fromJson(Map<String, dynamic> json) => PvtNotes(
        id: json['id'],
        managerId: json['managerId'],
        crewId: json['crewId'],
        title: json['title'],
        note: json['note'],
        status: json['status'],
        sid: json['_id'],
      );
}
