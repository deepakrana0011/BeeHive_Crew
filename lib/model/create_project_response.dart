class CreateProjectResponse {
  CreateProjectResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CreateProjectResponse.fromJson(Map<String, dynamic> json) => CreateProjectResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
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
    this.roundTimesheets,
    this.sameRate,
    this.projectRate,
    this.status,
    this.id,
    this.createdAt,
    this.v,
  });

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
  String? roundTimesheets;
  String? sameRate;
  List<dynamic>? projectRate;
  int? status;
  String? id;
  DateTime? createdAt;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    roundTimesheets: json["roundTimesheets"],
    sameRate: json["sameRate"],
    projectRate: List<dynamic>.from(json["projectRate"].map((x) => x)),
    status: json["status"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );
}
