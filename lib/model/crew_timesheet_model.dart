import 'dart:convert';

CrewTimeSheetModel crewTimeSheetModelFromJson(String str) => CrewTimeSheetModel.fromJson(json.decode(str));

String crewTimeSheetModelToJson(CrewTimeSheetModel data) => json.encode(data.toJson());

class CrewTimeSheetModel {
  CrewTimeSheetModel({
    this.success,
    this.crew,
    this.projects,
    this.totalProjectHours,
    this.allCheckin,
  });

  bool? success;
  Crew? crew;
  int? projects;
  int? totalProjectHours;
  List<AllCheckin>? allCheckin;

  factory CrewTimeSheetModel.fromJson(Map<String, dynamic> json) => CrewTimeSheetModel(
    success: json["success"],
    crew: Crew.fromJson(json["crew"]),
    projects: json["projects"],
    totalProjectHours: json["totalProjectHours"],
    allCheckin: List<AllCheckin>.from(json["allCheckin"].map((x) => AllCheckin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "crew": crew?.toJson(),
    "projects": projects,
    "totalProjectHours": totalProjectHours,
    "allCheckin": List<dynamic>.from(allCheckin!.map((x) => x.toJson())),
  };
}

class AllCheckin {
  AllCheckin({
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
  AssignProjectId? assignProjectId;
  String? checkInTime;
  int? hoursDiff;
  List<Break>? allCheckinBreak;
  int? status;
  List<Interuption>? interuption;
  DateTime? createdAt;
  int? v;
  String? checkOutTime;

  factory AllCheckin.fromJson(Map<String, dynamic> json) => AllCheckin(
    id: json["_id"],
    crewId: json["crewId"],
    assignProjectId: AssignProjectId.fromJson(json["assignProjectId"]),
    checkInTime: json["checkInTime"],
    hoursDiff: json["hoursDiff"],
    allCheckinBreak: List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
    status: json["status"],
    interuption: List<Interuption>.from(json["interuption"].map((x) => Interuption.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    checkOutTime: json["checkOutTime"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "crewId": crewId,
    "assignProjectId": assignProjectId?.toJson(),
    "checkInTime": checkInTime,
    "hoursDiff": hoursDiff,
    "break": List<dynamic>.from(allCheckinBreak!.map((x) => x.toJson())),
    "status": status,
    "interuption": List<dynamic>.from(interuption!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "checkOutTime": checkOutTime,
  };
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

class AssignProjectId {
  AssignProjectId({
    this.id,
    this.projectName,
    this.color,
    this.sameRate,
    this.projectRate,
    this.date,
  });

  String? id;
  String? projectName;
  String? color;
  String? sameRate;
  List<ProjectRate>? projectRate;
  DateTime? date;

  factory AssignProjectId.fromJson(Map<String, dynamic> json) => AssignProjectId(
    id: json["_id"],
    projectName: json["projectName"],
    color: json["color"],
    sameRate: json["sameRate"],
    projectRate: List<ProjectRate>.from(json["projectRate"].map((x) => ProjectRate.fromJson(x))),
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "projectName": projectName,
    "color": color,
    "sameRate": sameRate,
    "projectRate": List<dynamic>.from(projectRate!.map((x) => x.toJson())),
    "date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
  };
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

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
    "_id": id,
  };
}

class Crew {
  Crew({
    this.id,
    this.email,
    this.name,
    this.password,
    this.status,
    this.createdAt,
    this.v,
    this.countryCode,
    this.phoneNumber,
  });

  String? id;
  String? email;
  String? name;
  String? password;
  int? status;
  DateTime? createdAt;
  int? v;
  String? countryCode;
  int? phoneNumber;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    password: json["password"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "password": password,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
  };
}
