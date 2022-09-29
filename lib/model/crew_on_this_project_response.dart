class CrewOnThisProjectResponse {
  bool? success;
  Manager? manager;
  ProjectData? projectData;

  CrewOnThisProjectResponse({this.success, this.manager, this.projectData});

  CrewOnThisProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    manager =
    json['manager'] != null ? Manager.fromJson(json['manager']) : null;
    projectData = json['projectData'] != null
        ? ProjectData.fromJson(json['projectData'])
        : null;
  }
}

class Manager {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;

  Manager(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber});

  Manager.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
  }
}

class ProjectData {
  String? sId;
  String? projectName;
  String? roundTimesheets;
  int? status;
  String? createdAt;
  List<Crews>? crews;
  List<ProjectRate>? projectRate;
  String? sameRate;

  ProjectData(
      {this.sId,
        this.projectName,
        this.roundTimesheets,
        this.status,
        this.createdAt,
        this.crews,
        this.projectRate,
        this.sameRate});

  ProjectData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['projectName'];
    roundTimesheets = json['roundTimesheets'];
    status = json['status'];
    createdAt = json['createdAt'];
    if (json['crews'] != null) {
      crews = <Crews>[];
      json['crews'].forEach((v) {
        crews!.add(Crews.fromJson(v));
      });
    }
    if (json['projectRate'] != null) {
      projectRate = <ProjectRate>[];
      json['projectRate'].forEach((v) {
        projectRate!.add(ProjectRate.fromJson(v));
      });
    }
    sameRate = json['sameRate'];
  }
}

class Crews {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? projectRate;
  String? countryCode;
  int? phoneNumber;
  String? profileImage;
  String? position;

  Crews(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.projectRate,
        this.countryCode,
        this.phoneNumber,
      this.profileImage});

  Crews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    projectRate = json['projectRate'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    if(json.containsKey("profileImage")){
      profileImage = json['profileImage'];
    }
    if(json.containsKey("position")){
      position = json['position'];
    }
  }
}

class ProjectRate {
  String? crewId;
  String? price;
  String? sId;

  ProjectRate({this.crewId, this.price, this.sId});

  ProjectRate.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'];
    price = json['price'];
    sId = json['_id'];
  }
}
