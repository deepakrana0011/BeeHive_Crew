import 'package:beehive/model/get_profile_response_manager.dart';

class CrewOnThisProjectResponse {
  bool? success;
  Manager? manager;
  ProjectData? projectData;

  CrewOnThisProjectResponse({this.success, this.manager, this.projectData});

  CrewOnThisProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    manager =
    json['manager'] != null ? Manager.fromJson(json['manager']) : null;
    projectData = json['projectData'] != null
        ? ProjectData.fromJson(json['projectData'])
        : null;
  }
}

class Manager {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;

  Manager(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber});

  Manager.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
  }
}

class ProjectData {
  String? sId;
  String? projectName;
  String? roundTimesheets;
  int? status;
  String? createdAt;
  List<Crews>? crews;
  List<ProjectRate>? projectRate;
  String? sameRate;

  ProjectData(
      {this.sId,
        this.projectName,
        this.roundTimesheets,
        this.status,
        this.createdAt,
        this.crews,
        this.projectRate,
        this.sameRate});

  ProjectData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['projectName'];
    roundTimesheets = json['roundTimesheets'];
    status = json['status'];
    createdAt = json['createdAt'];
    if (json['crews'] != null) {
      crews = <Crews>[];
      json['crews'].forEach((v) {
        crews!.add(Crews.fromJson(v));
      });
    }
    if (json['projectRate'] != null) {
      projectRate = <ProjectRate>[];
      json['projectRate'].forEach((v) {
        projectRate!.add(ProjectRate.fromJson(v));
      });
    }
    sameRate = json['sameRate'];
  }
}

class Crews {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;
  List<Cert> certificates = [];
  List<PvtNotes> pvtNotes = [];
  String? projectRate;
  String? address;
  String? company;
  String? position;
  String? speciality;
  String? profileImage;

  Crews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    if (json['certificates'] != null) {
      certificates = <Cert>[];
      json['certificates'].forEach((v) {
        certificates.add(Cert.fromJson(v));
      });
    }
    if (json['pvtNotes'] != null) {
      pvtNotes = <PvtNotes>[];
      json['pvtNotes'].forEach((v) {
        pvtNotes.add(PvtNotes.fromJson(v));
      });
    }
    projectRate = json["sameRate"] ?? json["projectRate"] ?? null;
    address = json['address'];
    company = json['company'];
    position = json['position'];
    speciality = json['speciality'];
    profileImage = json['profileImage'];
  }
}


class PvtNotes {
  String? sId;
  String? managerId;
  String? crewId;
  String? title;
  String? note;
  int? status;
  String? createdAt;
  int? iV;

  PvtNotes(
      {this.sId,
        this.managerId,
        this.crewId,
        this.title,
        this.note,
        this.status,
        this.createdAt,
        this.iV});

  PvtNotes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    managerId = json['managerId'];
    crewId = json['crewId'];
    title = json['title'];
    note = json['note'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }
}

class ProjectRate {
  String? crewId;
  String? price;
  String? sId;

  ProjectRate({this.crewId, this.price, this.sId});

  ProjectRate.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'];
    price = json['price'];
    sId = json['_id'];
  }
}
