import 'package:beehive/model/crew_dashboard_response.dart';
import 'package:beehive/model/manager_dashboard_response.dart';

class ProjectDetailResponseManager {
  ProjectDetailResponseManager({
    this.success,
    this.manager,
    this.projectData,
  });

  bool? success;
  Manager? manager;
  ProjectData? projectData;

  factory ProjectDetailResponseManager.fromJson(Map<String, dynamic> json) =>
      ProjectDetailResponseManager(
        success: json["success"],
        manager: Manager.fromJson(json["manager"]),
        projectData: json["projectData"] != null
            ? ProjectData.fromJson(json["projectData"])
            : null,
      );
}

class Manager {
  Manager({
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

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );
}

class ProjectData {
  ProjectData({
    this.projectDataId,
    this.projectName,
    this.roundTimesheets,
    this.status,
    this.checkins,
    this.totalHours,
    this.crews,
    this.address,
    this.latitude,
    this.longitude,
    this.notes,
  });

  String? projectDataId;
  String? projectName;
  String? roundTimesheets;
  int? status;
  String? address;
  double? latitude;
  double? longitude;
  List<CheckInProjectDetailManager>? checkins;
  int? totalHours;
  List<CrewMemberDetail>? crews;
  List<Note>? notes;

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(

        projectDataId: json["id"],
        projectName: json["projectName"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        roundTimesheets: json["roundTimesheets"],
        status: json["status"],
        checkins: json["checkins"]!=null?List<CheckInProjectDetailManager>.from(json["checkins"].map((x) => CheckInProjectDetailManager.fromJson(x))):[],
        totalHours: json["totalHours"],
        crews: json["crews"]!=null?List<CrewMemberDetail>.from(json["crews"].map((x) => CrewMemberDetail.fromJson(x))):[],
        notes: json["notes"]!=null?List<Note>.from(json["notes"].map((x) => Note.fromJson(x))):[],
      );
}

/*class Checkin {
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
  DateTime? checkInTime;
  double? hoursDiff;
  List<Break>? checkinBreak;
  List<Interruption>? interuption;
  DateTime? checkOutTime;
  DateTime? date;

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
        id: json["_id"],
        crewId: json["crewId"],
        checkInTime: DateTime.parse(json["checkInTime"]),
        hoursDiff: double.parse(json["hoursDiff"].toString()),
        checkinBreak: json["break"] != null
            ? List<Break>.from(json["break"].map((x) => Break.fromJson(x)))
            : [],
        interuption: List<Interruption>.from(
            json["interuption"].map((x) => Interruption.fromJson(x))),
        checkOutTime: DateTime.parse(json["checkOutTime"]),
        date: DateTime.parse(json["date"]),
      );
}*/

class Note {
  Note({
    this.id,
    this.assignProjectId,
    this.title,
    this.note,
    this.image,
    this.status,
    this.createdAt,
    this.v,
  });

  String? id;
  String? assignProjectId;
  String? title;
  String? note;
  List<String>? image;
  int? status;
  DateTime? createdAt;
  int? v;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["_id"],
        assignProjectId: json["assignProjectId"],
        title: json["title"],
        note: json["note"],
        image: List<String>.from(json["image"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );
}
