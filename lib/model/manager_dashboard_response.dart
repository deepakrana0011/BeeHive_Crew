class ManagerDashboardResponse {
  ManagerDashboardResponse({
    this.success,
    this.manager,
    this.activeProject,
    this.crewmembers,
    this.projectData,
  });

  bool? success;
  Manager? manager;
  int? activeProject;
  int? crewmembers;
  List<ProjectDatum>? projectData;

  factory ManagerDashboardResponse.fromJson(Map<String, dynamic> json) =>
      ManagerDashboardResponse(
        success: json["success"],
        manager: json["manager"]!=null?Manager.fromJson(json["manager"]):null,
        activeProject: json["activeProject"],
        crewmembers: json["crewmembers"],
        projectData: List<ProjectDatum>.from(
            json["projectData"].map((x) => ProjectDatum.fromJson(x))),
      );

/*Map<String, dynamic> toJson() => {
    "success": success,
    "manager": manager!.toJson(),
    "activeProject": activeProject,
    "crewmembers": crewmembers,
    "projectData": List<dynamic>.from(projectData.map((x) => x.toJson())),
  };*/
}

class Manager {
  Manager({
    this.id,
    this.companyLogo,
    this.profileImage,
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
  String? companyLogo;
  String? profileImage;
  int? status;
  DateTime? createdAt;
  int? v;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["_id"],
        email: json["email"],
        companyLogo: json["companyLogo"] ?? "",
        profileImage: json["profileImage"] ?? "",
        name: json["name"],
        password: json["password"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "password": password,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "__v": v,
      };
}

class ProjectDatum {
  ProjectDatum({
    this.id,
    this.date,
    this.projectDatumId,
    this.projectName,
    this.crewId,
    this.roundTimesheets,
    this.status,
    this.checkins,
  });

  String? id;
  DateTime? date;
  String? projectDatumId;
  String? projectName;
  List<String>? crewId;
  String? roundTimesheets;
  int? status;
  List<Checkin>? checkins;

  factory ProjectDatum.fromJson(Map<String, dynamic> json) => ProjectDatum(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        projectDatumId: json["id"],
        projectName: json["projectName"],
        crewId: List<String>.from(json["crewId"].map((x) => x)),
        roundTimesheets: json["roundTimesheets"],
        status: json["status"],
        checkins: List<Checkin>.from(
            json["checkins"].map((x) => Checkin.fromJson(x))),
      );

/*Map<String, dynamic> toJson() => {
    "_id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "id": projectDatumId,
    "projectName": projectName,
    "crewId": List<dynamic>.from(crewId.map((x) => x)),
    "roundTimesheets": roundTimesheets,
    "status": status,
    "checkins": List<dynamic>.from(checkins.map((x) => x.toJson())),
  };*/
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
  List<Interuption>? interuption;
  DateTime? checkOutTime;
  DateTime? date;

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
        id: json["_id"],
        crewId: json["crewId"],
        checkInTime: DateTime.parse(json["checkInTime"]),
        hoursDiff: json["hoursDiff"],
        checkinBreak:
            List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
        interuption: List<Interuption>.from(
            json["interuption"].map((x) => Interuption.fromJson(x))),
        checkOutTime: DateTime.parse(json["checkOutTime"]),
        date: DateTime.parse(json["date"]),
      );

/*Map<String, dynamic> toJson() => {
    "_id": id,
    "crewId": crewId,
    "checkInTime": checkInTime.toIso8601String(),
    "hoursDiff": hoursDiff,
    "break": List<dynamic>.from(checkinBreak.map((x) => x.toJson())),
    "interuption": List<dynamic>.from(interuption.map((x) => x.toJson())),
    "checkOutTime": checkOutTime.toIso8601String(),
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };*/
}

class Break {
  Break({
    this.startTime,
    this.interval,
    this.id,
  });

  DateTime? startTime;
  DateTime? interval;
  String? id;

  factory Break.fromJson(Map<String, dynamic> json) => Break(
        startTime: DateTime.parse(json["startTime"]),
        interval: DateTime.parse(json["interval"]),
        id: json["_id"],
      );

/*Map<String, dynamic> toJson() => {
    "startTime": startTime.toIso8601String(),
    "interval": interval.toIso8601String(),
    "_id": id,
  };*/
}

class Interuption {
  Interuption({
    this.startTime,
    this.endTime,
    this.id,
  });

  DateTime? startTime;
  DateTime? endTime;
  String? id;

  factory Interuption.fromJson(Map<String, dynamic> json) => Interuption(
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        id: json["_id"],
      );

/*Map<String, dynamic> toJson() => {
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "_id": id,
  };*/
}
