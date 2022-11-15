import 'dart:convert';

GetAllCrewOnProject getAllCrewOnProjectFromJson(String str) => GetAllCrewOnProject.fromJson(json.decode(str));

String getAllCrewOnProjectToJson(GetAllCrewOnProject data) => json.encode(data.toJson());

class GetAllCrewOnProject {
  GetAllCrewOnProject({
    this.success,
    this.data,
    this.totalCrews,
  });

  bool? success;
  List<Datum>? data;
  int? totalCrews;

  factory GetAllCrewOnProject.fromJson(Map<String, dynamic> json) => GetAllCrewOnProject(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalCrews: json["totalCrews"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCrews": totalCrews,
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
    this.conCat,
    this.company,
    this.profileImage,
    this.position,
    this.speciality,
    this.checkins,
    this.totalHours,
  });

  String? id;
  String? email;
  String? name;
  dynamic? title;
  dynamic? address;
  String? countryCode;
  int? phoneNumber;
  dynamic? conCat;
  dynamic? company;
  dynamic? profileImage;
  dynamic? position;
  dynamic? speciality;
  List<dynamic>? checkins;
  int? totalHours;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    title: json["title"],
    address: json["address"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
    conCat: json["conCat"],
    company: json["company"],
    profileImage: json["profileImage"],
    position: json["position"],
    speciality: json["speciality"],
    checkins: List<dynamic>.from(json["checkins"].map((x) => x)),
    totalHours: json["totalHours"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "title": title,
    "address": address,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
    "conCat": conCat,
    "company": company,
    "profileImage": profileImage,
    "position": position,
    "speciality": speciality,
    "checkins": List<dynamic>.from(checkins!.map((x) => x)),
    "totalHours": totalHours,
  };
}
