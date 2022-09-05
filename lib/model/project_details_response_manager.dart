class ProjectDetailsResponseManager {
  bool? success;
  Data? data;
  String? totalHoursToDate;
  Crew? crew;

  ProjectDetailsResponseManager(
      {this.success, this.data, this.totalHoursToDate, this.crew});

  ProjectDetailsResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    totalHoursToDate = json['totalHoursToDate'];
    crew = json['crew'] != null ? new Crew.fromJson(json['crew']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['totalHoursToDate'] = this.totalHoursToDate;
    if (this.crew != null) {
      data['crew'] = this.crew!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  int? status;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.projectName,
        this.address,
        this.latitude,
        this.longitude,
        this.locationRadius,
        this.status,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['projectName'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationRadius = json['locationRadius'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['projectName'] = this.projectName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['locationRadius'] = this.locationRadius;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Crew {
  String? sId;
  String? projectId;
  ManagerId? managerId;
  List<CrewIdProject>? crewId;
  int? status;
  String? createdAt;
  int? iV;

  Crew(
      {this.sId,
        this.projectId,
        this.managerId,
        this.crewId,
        this.status,
        this.createdAt,
        this.iV});

  Crew.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectId = json['projectId'];
    managerId = json['managerId'] != null
        ? new ManagerId.fromJson(json['managerId'])
        : null;
    if (json['crewId'] != null) {
      crewId = <CrewIdProject>[];
      json['crewId'].forEach((v) {
        crewId!.add(new CrewIdProject.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['projectId'] = this.projectId;
    if (this.managerId != null) {
      data['managerId'] = this.managerId!.toJson();
    }
    if (this.crewId != null) {
      data['crewId'] = this.crewId!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ManagerId {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;
  int? verifyCode;

  ManagerId(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber,
        this.verifyCode});

  ManagerId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    verifyCode = json['verifyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['verifyCode'] = this.verifyCode;
    return data;
  }
}

class CrewIdProject {
  String? sId;
  String? email;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;
  int? verifyCode;
  String? address;
  String? company;
  String? name;
  String? position;
  String? profileImage;
  String? speciality;

  CrewIdProject(
      {this.sId,
        this.email,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber,
        this.verifyCode,
        this.address,
        this.company,
        this.name,
        this.position,
        this.profileImage,
        this.speciality});

  CrewIdProject.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    verifyCode = json['verifyCode'];
    address = json['address'];
    company = json['company'];
    name = json['name'];
    position = json['position'];
    profileImage = json['profileImage'];
    speciality = json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['verifyCode'] = this.verifyCode;
    data['address'] = this.address;
    data['company'] = this.company;
    data['name'] = this.name;
    data['position'] = this.position;
    data['profileImage'] = this.profileImage;
    data['speciality'] = this.speciality;
    return data;
  }
}