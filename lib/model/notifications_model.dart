import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Notifications>? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        success: json["success"],
        data: List<Notifications>.from(json["data"].map((x) => Notifications.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Notifications {
  Notifications({
    this.id,
    this.type,
    this.assignProjectId,
    this.managerId,
    this.crewId,
    this.message,
    this.status,
    this.createdAt,
    this.v,
    this.acceptFutureInvites
  });

  String? id;
  String? type;
  AssignProjectId? assignProjectId;
  ManagerId? managerId;
  String? crewId;
  String? message;
  int? status;
  DateTime? createdAt;
  int? v;
  int? acceptFutureInvites;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["_id"],
        type: json["type"],
        assignProjectId: AssignProjectId.fromJson(json["assignProjectId"]),
        managerId: ManagerId.fromJson(json["managerId"]),
        crewId: json["crewId"],
        message: json["message"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        acceptFutureInvites: json["acceptFutureInvites"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "assignProjectId": assignProjectId?.toJson(),
        "managerId": managerId?.toJson(),
        "crewId": crewId,
        "message": message,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "acceptFutureInvites": acceptFutureInvites,
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
  List<dynamic>? workDays;
  dynamic? hoursFrom;
  dynamic? hoursTo;
  dynamic? afterHoursRate;
  List<Break>? assignProjectIdBreak;
  String? roundTimesheets;
  String? sameRate;
  List<ProjectRate>? projectRate;
  String? color;
  int? status;
  DateTime? createdAt;
  int? v;

  factory AssignProjectId.fromJson(Map<String, dynamic> json) =>
      AssignProjectId(
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
        assignProjectIdBreak:
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
        "break":
            List<dynamic>.from(assignProjectIdBreak!.map((x) => x.toJson())),
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

class ManagerId {
  ManagerId({
    this.id,
    this.email,
    this.name,
    this.password,
    this.status,
    this.createdAt,
    this.v,
    this.countryCode,
    this.phoneNumber,
    this.address,
    this.company,
    this.customColor,
    this.title,
    this.profileImage,
    this.companyLogo,
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
  String? address;
  String? company;
  String? customColor;
  String? title;
  String? profileImage;
  String? companyLogo;

  factory ManagerId.fromJson(Map<String, dynamic> json) => ManagerId(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        company: json["company"],
        customColor: json["customColor"],
        title: json["title"],
        profileImage: json["profileImage"],
        companyLogo: json["companyLogo"],
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
        "address": address,
        "company": company,
        "customColor": customColor,
        "title": title,
        "profileImage": profileImage,
        "companyLogo": companyLogo,
      };
}
