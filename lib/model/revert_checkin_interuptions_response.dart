import 'dart:convert';

import 'package:beehive/model/project_timesheet_response.dart';

RevertCheckinInteruptionsResponse revertCheckinInteruptionsResponseFromJson(String str) => RevertCheckinInteruptionsResponse.fromJson(json.decode(str));

String revertCheckinInteruptionsResponseToJson(RevertCheckinInteruptionsResponse data) => json.encode(data.toJson());

class RevertCheckinInteruptionsResponse {
  RevertCheckinInteruptionsResponse({
    this.success,
    this.details,
  });

  bool? success;
  Details? details;

  factory RevertCheckinInteruptionsResponse.fromJson(Map<String, dynamic> json) => RevertCheckinInteruptionsResponse(
    success: json["success"],
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "details": details?.toJson(),
  };
}

class Details {
  Details({
    this.id,
    this.crewId,
    this.assignProjectId,
    this.checkInTime,
    this.hoursDiff,
    this.detailsBreak,
    this.status,
    this.interuption,
    this.ignoredInteruption,
    this.createdAt,
    this.v,
    this.checkOutTime,
  });

  String? id;
  CrewId? crewId;
  AssignProjectId? assignProjectId;
  String? checkInTime;
  int? hoursDiff;
  List<Break>? detailsBreak;
  int? status;
  List<Interuption>? interuption;
  List<Interuption>? ignoredInteruption;
  DateTime? createdAt;
  int? v;
  String? checkOutTime;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["_id"],
    crewId: CrewId.fromJson(json["crewId"]),
    assignProjectId: AssignProjectId.fromJson(json["assignProjectId"]),
    checkInTime: json["checkInTime"],
    hoursDiff: json["hoursDiff"],
    detailsBreak: List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
    status: json["status"],
    interuption: List<Interuption>.from(json["interuption"].map((x) => Interuption.fromJson(x))),
    ignoredInteruption: List<Interuption>.from(json["ignoredInteruption"].map((x) => Interuption.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    checkOutTime: json["checkOutTime"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "crewId": crewId?.toJson(),
    "assignProjectId": assignProjectId?.toJson(),
    "checkInTime": checkInTime,
    "hoursDiff": hoursDiff,
    "break": List<dynamic>.from(detailsBreak!.map((x) => x.toJson())),
    "status": status,
    "interuption": List<dynamic>.from(interuption!.map((x) => x)),
    "ignoredInteruption": List<dynamic>.from(ignoredInteruption!.map((x) => x)),
    "createdAt": createdAt!.toIso8601String(),
    "__v": v,
    "checkOutTime": checkOutTime,
  };
}

class AssignProjectId {
  AssignProjectId({
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
    this.assignProjectIdBreak,
    this.roundTimesheets,
    this.sameRate,
    this.projectRate,
    this.color,
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
  List<Break>? assignProjectIdBreak;
  String? roundTimesheets;
  String? sameRate;
  List<ProjectRate>? projectRate;
  String? color;
  int? status;
  DateTime? createdAt;
  int? v;

  factory AssignProjectId.fromJson(Map<String, dynamic> json) => AssignProjectId(
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
    assignProjectIdBreak: List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
    roundTimesheets: json["roundTimesheets"],
    sameRate: json["sameRate"],
    projectRate: List<ProjectRate>.from(json["projectRate"].map((x) => ProjectRate.fromJson(x))),
    color: json["color"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "managerId": managerId,
    "projectName": projectName,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "locationRadius": locationRadius,
    "crewId": List<dynamic>.from(crewId!.map((x) => x)),
    "workDays": List<dynamic>.from(workDays!.map((x) => x)),
    "hoursFrom": hoursFrom,
    "hoursTo": hoursTo,
    "afterHoursRate": afterHoursRate,
    "break": List<dynamic>.from(assignProjectIdBreak!.map((x) => x.toJson())),
    "roundTimesheets": roundTimesheets,
    "sameRate": sameRate,
    "projectRate": List<dynamic>.from(projectRate!.map((x) => x.toJson())),
    "color": color,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "__v": v,
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

class CrewId {
  CrewId({
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

  factory CrewId.fromJson(Map<String, dynamic> json) => CrewId(
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
