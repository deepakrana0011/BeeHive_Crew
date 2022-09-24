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
  List<ProjectDetail>? projectData;

  factory ManagerDashboardResponse.fromJson(Map<String, dynamic> json) =>
      ManagerDashboardResponse(
        success: json["success"],
        manager: Manager.fromJson(json["manager"]),
        activeProject: json["activeProject"],
        crewmembers: json["crewmembers"],
        projectData: List<ProjectDetail>.from(
            json["projectData"].map((x) => ProjectDetail.fromJson(x))),
      );
}

class Manager {
  Manager({
    this.id,
    this.email,
    this.name,
    this.password,
    this.status,
    this.profileImage,
    this.companyLogo,
    this.createdAt,
    this.v,
    this.countryCode,
    this.phoneNumber,
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
  String? countryCode;
  int? phoneNumber;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        profileImage: json["profileImage"] ?? "",
        companyLogo: json["companyLogo"]??"",
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
      );
}

class ProjectDetail {
  ProjectDetail({
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
  List<CheckInProjectDetailManager>? checkins;

  factory ProjectDetail.fromJson(Map<String, dynamic> json) => ProjectDetail(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        projectDatumId: json["id"],
        projectName: json["projectName"],
        crewId: List<String>.from(json["crewId"].map((x) => x)),
        roundTimesheets: json["roundTimesheets"],
        status: json["status"],
        checkins: List<CheckInProjectDetailManager>.from(
            json["checkins"].map((x) => CheckInProjectDetailManager.fromJson(x))),
      );
}

class CheckInProjectDetailManager {
  CheckInProjectDetailManager({
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

  factory CheckInProjectDetailManager.fromJson(Map<String, dynamic> json) => CheckInProjectDetailManager(
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

  factory Interuption.fromJson(Map<String, dynamic> json) => Interuption(
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
        "_id": id,
      };
}
