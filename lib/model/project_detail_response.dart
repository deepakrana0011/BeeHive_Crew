import 'package:beehive/model/crew_dashboard_response.dart';

class ProjectDetailResponseManager {
  ProjectDetailResponseManager({
    this.success,
    this.manager,
    this.projectData,
  });

  bool? success;
  Manager? manager;
  ProjectData? projectData;

  factory ProjectDetailResponseManager.fromJson(Map<String, dynamic> json) => ProjectDetailResponseManager(
    success: json["success"],
    manager: Manager.fromJson(json["manager"]),
    projectData: ProjectData.fromJson(json["projectData"]),
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
    this.id,
    this.date,
    this.projectDataId,
    this.projectName,
    this.roundTimesheets,
    this.status,
    this.checkins,
    this.totalHours,
    this.crews,
    this.notes,
  });

  String? id;
  DateTime? date;
  String? projectDataId;
  String? projectName;
  String? roundTimesheets;
  int? status;
  List<Checkin>? checkins;
  int? totalHours;
  List<Manager>? crews;
  List<Note>? notes;

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
    id: json["_id"],
    date: DateTime.parse(json["date"]),
    projectDataId: json["id"],
    projectName: json["projectName"],
    roundTimesheets: json["roundTimesheets"],
    status: json["status"],
    checkins: List<Checkin>.from(json["checkins"].map((x) => Checkin.fromJson(x))),
    totalHours: json["totalHours"],
    crews: List<Manager>.from(json["crews"].map((x) => Manager.fromJson(x))),
    notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
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
  DateTime? checkInTime;
  int? hoursDiff;
  List<Break>? checkinBreak;
  List<Interruption>? interuption;
  DateTime? checkOutTime;
  DateTime? date;

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
    id: json["_id"],
    crewId: json["crewId"],
    checkInTime: DateTime.parse(json["checkInTime"]),
    hoursDiff: json["hoursDiff"],
    checkinBreak: json["break"]!=null?List<Break>.from(json["break"].map((x) => Break.fromJson(x))):[],
    interuption: List<Interruption>.from(json["interuption"].map((x) => Interruption.fromJson(x))),
    checkOutTime: DateTime.parse(json["checkOutTime"]),
    date: DateTime.parse(json["date"]),
  );
}

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
