import 'dart:convert';

UpdateCheckInOutResponse updateCheckInOutResponseFromJson(String str) => UpdateCheckInOutResponse.fromJson(json.decode(str));

String updateCheckInOutResponseToJson(UpdateCheckInOutResponse data) => json.encode(data.toJson());

class UpdateCheckInOutResponse {
  UpdateCheckInOutResponse({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory UpdateCheckInOutResponse.fromJson(Map<String, dynamic> json) => UpdateCheckInOutResponse(
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
    this.crewId,
    this.assignProjectId,
    this.checkInTime,
    this.hoursDiff,
    this.dataBreak,
    this.status,
    this.interuption,
    this.ignoredInteruption,
    this.createdAt,
    this.v,
    this.checkOutTime,
  });

  String? id;
  String? crewId;
  String? assignProjectId;
  String? checkInTime;
  int? hoursDiff;
  List<Break>? dataBreak;
  int? status;
  List<Interuption>? interuption;
  List<dynamic>? ignoredInteruption;
  DateTime? createdAt;
  int? v;
  String? checkOutTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    crewId: json["crewId"],
    assignProjectId: json["assignProjectId"],
    checkInTime: json["checkInTime"],
    hoursDiff: json["hoursDiff"],
    dataBreak: List<Break>.from(json["break"].map((x) => Break.fromJson(x))),
    status: json["status"],
    interuption: List<Interuption>.from(json["interuption"].map((x) => Interuption.fromJson(x))),
    ignoredInteruption: List<dynamic>.from(json["ignoredInteruption"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    checkOutTime: json["checkOutTime"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "crewId": crewId,
    "assignProjectId": assignProjectId,
    "checkInTime": checkInTime,
    "hoursDiff": hoursDiff,
    "break": List<dynamic>.from(dataBreak!.map((x) => x.toJson())),
    "status": status,
    "interuption": List<dynamic>.from(interuption!.map((x) => x.toJson())),
    "ignoredInteruption": List<dynamic>.from(ignoredInteruption!.map((x) => x)),
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
