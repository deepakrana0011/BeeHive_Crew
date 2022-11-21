import 'dart:convert';

TimesheetCrewDetails timesheetCrewDetailsFromJson(String str) => TimesheetCrewDetails.fromJson(json.decode(str));

String timesheetCrewDetailsToJson(TimesheetCrewDetails data) => json.encode(data.toJson());

class TimesheetCrewDetails {
  TimesheetCrewDetails({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory TimesheetCrewDetails.fromJson(Map<String, dynamic> json) => TimesheetCrewDetails(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.email,
    this.name,
    this.title,
    this.address,
    this.countryCode,
    this.phoneNumber,
    this.projectRate,
    this.sameRate,
    this.company,
    this.profileImage,
    this.position,
    this.speciality,
    this.crewProjects,
    this.certs,
    this.pvtNotes,
  });

  String? id;
  String? email;
  String? name;
  dynamic? title;
  String? address;
  String? countryCode;
  int? phoneNumber;
  String? projectRate;
  String? sameRate;
  String? company;
  String? profileImage;
  String? position;
  String? speciality;
  List<CrewProject>? crewProjects;
  List<Cert>? certs;
  List<PvtNote>? pvtNotes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    title: json["title"],
    address: json["address"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
    projectRate: json["projectRate"],
    sameRate: json["sameRate"],
    company: json["company"],
    profileImage: json["profileImage"],
    position: json["position"],
    speciality: json["speciality"],
    crewProjects: List<CrewProject>.from(json["crewProjects"].map((x) => CrewProject.fromJson(x))),
    certs: List<Cert>.from(json["certs"].map((x) => Cert.fromJson(x))),
    pvtNotes: List<PvtNote>.from(json["pvtNotes"].map((x) => PvtNote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "title": title,
    "address": address,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
    "projectRate": projectRate,
    "sameRate": sameRate,
    "company": company,
    "profileImage": profileImage,
    "position": position,
    "speciality": speciality,
    "crewProjects": List<dynamic>.from(crewProjects!.map((x) => x.toJson())),
    "certs": List<dynamic>.from(certs!.map((x) => x.toJson())),
    "pvtNotes": List<dynamic>.from(pvtNotes!.map((x) => x.toJson())),
  };
}

class Cert {
  Cert({
    this.id,
    this.crewId,
    this.certName,
    this.status,
    this.createdAt,
    this.certImage,
    this.v,
  });

  String? id;
  String? crewId;
  String? certName;
  int? status;
  DateTime? createdAt;
  String? certImage;
  int? v;

  factory Cert.fromJson(Map<String, dynamic> json) => Cert(
    id: json["_id"],
    crewId: json["crewId"],
    certName: json["certName"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    certImage: json["certImage"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "crewId": crewId,
    "certName": certName,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "certImage": certImage,
    "__v": v,
  };
}

class CrewProject {
  CrewProject({
    this.id,
    this.projectName,
    this.color,
  });

  String? id;
  String? projectName;
  String? color;

  factory CrewProject.fromJson(Map<String, dynamic> json) => CrewProject(
    id: json["_id"],
    projectName: json["projectName"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "projectName": projectName,
    "color": color,
  };
}

class PvtNote {
  PvtNote({
    this.id,
    this.managerId,
    this.crewId,
    this.title,
    this.note,
    this.status,
    this.createdAt,
    this.v,
  });

  String? id;
  String? managerId;
  String? crewId;
  String? title;
  String? note;
  int? status;
  DateTime? createdAt;
  int? v;

  factory PvtNote.fromJson(Map<String, dynamic> json) => PvtNote(
    id: json["_id"],
    managerId: json["managerId"],
    crewId: json["crewId"],
    title: json["title"],
    note: json["note"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "managerId": managerId,
    "crewId": crewId,
    "title": title,
    "note": note,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}
