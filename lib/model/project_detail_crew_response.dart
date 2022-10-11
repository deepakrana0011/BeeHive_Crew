import 'package:beehive/model/manager_dashboard_response.dart';

import 'crew_dashboard_response.dart';

class ProjectDetailCrewResponse {
  ProjectDetailCrewResponse({
    this.success,
    this.projectData,
  });

  bool? success;
  ProjectData? projectData;

  factory ProjectDetailCrewResponse.fromJson(Map<String, dynamic> json) =>
      ProjectDetailCrewResponse(
        success: json["success"],
        projectData: ProjectData.fromJson(json["projectData"]),
      );
}

class ProjectData {
  ProjectData({
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
    this.projectDataBreak,
    this.roundTimesheets,
    this.sameRate,
    this.projectRate,
    this.checkins,
    this.manager,
    this.crews,
    this.notes,
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
  List<Break>? projectDataBreak;
  String? roundTimesheets;
  String? sameRate;
  List<ProjectRate>? projectRate;
  List<CheckInProjectDetailManager>? checkins = [];
  Manager? manager;
  List<CrewMemberDetail>? crews;
  List<Note>? notes;

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
        id: json["_id"],
        managerId: json["managerId"],
        projectName: json["projectName"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        locationRadius: json["locationRadius"],
        crewId: List<String>.from(json["crewId"].map((x) => x)),
        workDays: List<String>.from(json["workDays"].map((x) => x)),
        hoursFrom: json["hoursFrom"],
        hoursTo: json["hoursTo"],
        afterHoursRate: json["afterHoursRate"],
        projectDataBreak:
            List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
        roundTimesheets: json["roundTimesheets"],
        sameRate: json["sameRate"],
        projectRate: List<ProjectRate>.from(
            json["projectRate"].map((x) => ProjectRate.fromJson(x))),
        checkins: json["checkins"]!=null?List<CheckInProjectDetailManager>.from(json["checkins"]
            .map((x) => CheckInProjectDetailManager.fromJson(x))):[],
        manager: Manager.fromJson(json["manager"]),
        crews: List<CrewMemberDetail>.from(
            json["crews"].map((x) => CrewMemberDetail.fromJson(x))),
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
      );
}

class Manager {
  Manager({
    this.id,
    this.email,
    this.name,
    this.password,
    this.countryCode,
    this.phoneNumber,
    this.profileImage
  });

  String? id;
  String? email;
  String? name;
  String? password;
  String? countryCode;
  int? phoneNumber;
  String? profileImage;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        profileImage: json["profileImage"]
      );
}

class Note {
  Note({this.id, this.assignProjectId, this.title, this.note, this.image});

  String? id;
  String? assignProjectId;
  String? title;
  String? note;
  List<String>? image;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
      id: json["_id"],
      assignProjectId: json["assignProjectId"],
      title: json["title"],
      note: json["note"],
      image: List<String>.from(json["image"].map((x) => x)));
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
}
