class CrewDashboardResponse {
  CrewDashboardResponse({
    this.success,
    this.data,
    this.activeProjects,
    this.myProjects,
    this.lastCheckIn,
    this.todayTotalWorkedHours,
    this.weeklyHours,
    this.biWeekHours,
    this.allCheckIns,
    this.today,
  });

  bool? success;
  Data? data;
  int? activeProjects;
  List<MyProject>? myProjects;
  List<LastCheckIn>? lastCheckIn;
  int? todayTotalWorkedHours;
  int? weeklyHours;
  int? biWeekHours;
  List<AllCheckIn>? allCheckIns;
  List<AllCheckIn>? today;

  factory CrewDashboardResponse.fromJson(Map<String, dynamic> json) => CrewDashboardResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    activeProjects: json["activeProjects"],
    myProjects: List<MyProject>.from(json["myProjects"].map((x) => MyProject.fromJson(x))),
    lastCheckIn: List<LastCheckIn>.from(json["lastCheckIn"].map((x) => LastCheckIn.fromJson(x))),
    todayTotalWorkedHours: json["todayTotalWorkedHours"],
    weeklyHours: json["weeklyHours"],
    biWeekHours: json["biWeekHours"],
    allCheckIns: List<AllCheckIn>.from(json["allCheckIns"].map((x) => AllCheckIn.fromJson(x))),
    today: List<AllCheckIn>.from(json["today"].map((x) => AllCheckIn.fromJson(x))),
  );

  /*Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "activeProjects": activeProjects,
    "myProjects": List<dynamic>.from(myProjects.map((x) => x.toJson())),
    "lastCheckIn": List<dynamic>.from(lastCheckIn.map((x) => x.toJson())),
    "todayTotalWorkedHours": todayTotalWorkedHours,
    "weeklyHours": weeklyHours,
    "biWeekHours": biWeekHours,
    "allCheckIns": List<dynamic>.from(allCheckIns.map((x) => x.toJson())),
    "today": List<dynamic>.from(today.map((x) => x.toJson())),
  };*/
}

class AllCheckIn {
  AllCheckIn({
    this.id,
    this.crewId,
    this.assignProjectId,
    this.checkInTime,
    this.hoursDiff,
    this.status,
    this.totalWorkingHours,
    this.createdAt,
    this.v,
    this.checkOutTime,
  });

  String? id;
  String? crewId;
  ProjectId? assignProjectId;
  DateTime? checkInTime;
  String? hoursDiff;
  int? status;
  String? totalWorkingHours;
  DateTime? createdAt;
  int? v;
  DateTime? checkOutTime;

  factory AllCheckIn.fromJson(Map<String, dynamic> json) => AllCheckIn(
    id: json["_id"],
    crewId: json["crewId"],
    assignProjectId: ProjectId.fromJson(json["assignProjectId"]),
    checkInTime: DateTime.parse(json["checkInTime"]),
    hoursDiff: json["hoursDiff"],
    status: json["status"],
    totalWorkingHours: json["TotalWorkingHours"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    checkOutTime: DateTime.parse(json["checkOutTime"]),
  );

 /* Map<String, dynamic> toJson() => {
    "_id": id,
    "crewId": crewId,
    "assignProjectId": assignProjectId.toJson(),
    "checkInTime": checkInTime.toIso8601String(),
    "hoursDiff": hoursDiff,
    "status": status,
    "TotalWorkingHours": totalWorkingHours,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "checkOutTime": checkOutTime.toIso8601String(),
  };*/
}

class ProjectId {
  ProjectId({
    this.id,
    this.projectName,
    this.address,
    this.latitude,
    this.longitude,
    this.locationRadius,
    this.workDays,
    this.status,
    this.projectIdBreak,
    this.createdAt,
    this.v,
    this.afterHoursRate,
    this.hoursFrom,
    this.hoursTo,
    this.roundTimesheets,
    this.totalWorkingHours,
  });

  String? id;
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  List<String>? workDays;
  int? status;
  List<Break>? projectIdBreak;
  DateTime? createdAt;
  int? v;
  String? afterHoursRate;
  DateTime? hoursFrom;
  DateTime? hoursTo;
  String? roundTimesheets;
  String? totalWorkingHours;

  factory ProjectId.fromJson(Map<String, dynamic> json) => ProjectId(
    id: json["_id"],
    projectName: json["projectName"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    locationRadius: json["locationRadius"],
    workDays: List<String>.from(json["workDays"].map((x) => x)),
    status: json["status"],
    projectIdBreak: List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    afterHoursRate: json["afterHoursRate"],
    hoursFrom: DateTime.parse(json["hoursFrom"]),
    hoursTo: DateTime.parse(json["hoursTo"]),
    roundTimesheets: json["roundTimesheets"],
    totalWorkingHours: json["TotalWorkingHours"],
  );

/*Map<String, dynamic> toJson() => {
    "_id": id,
    "projectName": projectName,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "locationRadius": locationRadius,
    "workDays": List<dynamic>.from(workDays.map((x) => x)),
    "status": status,
    "break": List<dynamic>.from(projectIdBreak.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "afterHoursRate": afterHoursRate,
    "hoursFrom": hoursFrom.toIso8601String(),
    "hoursTo": hoursTo.toIso8601String(),
    "roundTimesheets": roundTimesheets,
    "TotalWorkingHours": totalWorkingHours,
  };*/
}

class Break {
  Break({
    this.from,
    this.to,
    this.id,
  });

  DateTime? from;
  DateTime? to;
  String? id;

  factory Break.fromJson(Map<String, dynamic> json) => Break(
    from: DateTime.parse(json["from"]),
    to: DateTime.parse(json["to"]),
    id: json["_id"],
  );

  /*Map<String, dynamic> toJson() => {
    "from": from.toIso8601String(),
    "to": to.toIso8601String(),
    "_id": id,
  };*/
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    password: json["password"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  /*Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "password": password,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };*/
}

class LastCheckIn {
  LastCheckIn({
    this.id,
    this.checkInTime,
  });

  String? id;
  DateTime? checkInTime;

  factory LastCheckIn.fromJson(Map<String, dynamic> json) => LastCheckIn(
    id: json["_id"],
    checkInTime: DateTime.parse(json["checkInTime"]),
  );

  /*Map<String, dynamic> toJson() => {
    "_id": id,
    "checkInTime": checkInTime.toIso8601String(),
  };*/
}

class MyProject {
  MyProject({
    this.id,
    this.projectId,
    this.managerId,
    this.crewId,
    this.totalWorkingHours,
    this.status,
    this.createdAt,
    this.v,
  });

  String? id;
  ProjectId? projectId;
  String? managerId;
  List<String>? crewId;
  String? totalWorkingHours;
  int? status;
  DateTime? createdAt;
  int? v;

  factory MyProject.fromJson(Map<String, dynamic> json) => MyProject(
    id: json["_id"],
    projectId: ProjectId.fromJson(json["projectId"]),
    managerId: json["managerId"],
    crewId: List<String>.from(json["crewId"].map((x) => x)),
    totalWorkingHours: json["TotalWorkingHours"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  /*Map<String, dynamic> toJson() => {
    "_id": id,
    "projectId": projectId.toJson(),
    "managerId": managerId,
    "crewId": List<dynamic>.from(crewId.map((x) => x)),
    "TotalWorkingHours": totalWorkingHours,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };*/
}
