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


}

class Datum {
  Datum({
    this.id,
    this.totalHours,
  });

  Id? id;
  int? totalHours;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: Id.fromJson(json["_id"]),
    totalHours: json["totalHours"],
  );

}

class Id {
  Id({
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
    this.position,
    this.profileImage,
    this.speciality,
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
  String? position;
  String? profileImage;
  String? speciality;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
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
    position: json["position"],
    profileImage: json["profileImage"],
    speciality: json["speciality"],
  );

}
