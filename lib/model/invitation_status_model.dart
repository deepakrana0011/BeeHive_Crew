import 'dart:convert';

InvitationStatusModel invitationStatusModelFromJson(String str) =>
    InvitationStatusModel.fromJson(json.decode(str));

String invitationStatusModelToJson(InvitationStatusModel data) =>
    json.encode(data.toJson());

class InvitationStatusModel {
  InvitationStatusModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory InvitationStatusModel.fromJson(Map<String, dynamic> json) =>
      InvitationStatusModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
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
    this.dataBreak,
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
  List<dynamic>? workDays;
  dynamic? hoursFrom;
  dynamic? hoursTo;
  dynamic? afterHoursRate;
  List<Break>? dataBreak;
  String? roundTimesheets;
  String? sameRate;
  List<ProjectRate>? projectRate;
  String? color;
  int? status;
  DateTime? createdAt;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        managerId: json["managerId"],
        projectName: json["projectName"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        locationRadius: json["locationRadius"],
        crewId: List<String>.from(json["crewId"].map((x) => x)),
        workDays: List<dynamic>.from(json["workDays"].map((x) => x)),
        hoursFrom: json["hoursFrom"],
        hoursTo: json["hoursTo"],
        afterHoursRate: json["afterHoursRate"],
        dataBreak:
            List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
        roundTimesheets: json["roundTimesheets"],
        sameRate: json["sameRate"],
        projectRate: List<ProjectRate>.from(
            json["projectRate"].map((x) => ProjectRate.fromJson(x))),
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
        "break": List<dynamic>.from(dataBreak!.map((x) => x.toJson())),
        "roundTimesheets": roundTimesheets,
        "sameRate": sameRate,
        "projectRate": List<dynamic>.from(projectRate!.map((x) => x.toJson())),
        "color": color,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
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
