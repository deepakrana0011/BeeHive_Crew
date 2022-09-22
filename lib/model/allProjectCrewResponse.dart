class AllProjectCrewResponse {
  AllProjectCrewResponse({
    this.success,
    this.activeProjects,
  });

  bool? success;
  List<ProjectDetail>? activeProjects;

  factory AllProjectCrewResponse.fromJson(Map<String, dynamic> json) => AllProjectCrewResponse(
    success: json["success"],
    activeProjects: List<ProjectDetail>.from(json["activeProjects"].map((x) => ProjectDetail.fromJson(x))),
  );

  /*Map<String, dynamic> toJson() => {
    "success": success,
    "activeProjects": List<dynamic>.from(activeProjects.map((x) => x.toJson())),
  };*/
}

class ProjectDetail {
  ProjectDetail({
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
    this.activeProjectBreak,
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
  List<Break>? activeProjectBreak;
  String? roundTimesheets;
  String? sameRate;
  List<dynamic>? projectRate;
  int? status;
  DateTime? createdAt;
  int? v;

  factory ProjectDetail.fromJson(Map<String, dynamic> json) => ProjectDetail(
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
    activeProjectBreak: List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
    roundTimesheets: json["roundTimesheets"],
    sameRate: json["sameRate"],
    projectRate: List<dynamic>.from(json["projectRate"].map((x) => x)),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  /*Map<String, dynamic> toJson() => {
    "_id": id,
    "managerId": managerId,
    "projectName": projectName,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "locationRadius": locationRadius,
    "crewId": List<dynamic>.from(crewId.map((x) => x)),
    "workDays": List<dynamic>.from(workDays.map((x) => x)),
    "hoursFrom": hoursFrom,
    "hoursTo": hoursTo,
    "afterHoursRate": afterHoursRate,
    "break": List<dynamic>.from(activeProjectBreak.map((x) => x.toJson())),
    "roundTimesheets": roundTimesheets,
    "sameRate": sameRate,
    "projectRate": List<dynamic>.from(projectRate.map((x) => x)),
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };*/
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
