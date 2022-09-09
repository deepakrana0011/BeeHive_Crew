class DashBoardResponseManager {
  bool? success;
  Manager? manager;
  int? activeProject;
  int? crewMembers;
  List<CrewOnProject>? crewOnProject;

  DashBoardResponseManager(
      {this.success,
        this.manager,
        this.activeProject,
        this.crewMembers,
        this.crewOnProject});

  DashBoardResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    manager =
    json['Manager'] != null ? new Manager.fromJson(json['Manager']) : null;
    activeProject = json['activeProject'];
    crewMembers = json['crewMembers'];
    if (json['crewOnProject'] != null) {
      crewOnProject = <CrewOnProject>[];
      json['crewOnProject'].forEach((v) {
        crewOnProject!.add(new CrewOnProject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.manager != null) {
      data['Manager'] = this.manager!.toJson();
    }
    data['activeProject'] = this.activeProject;
    data['crewMembers'] = this.crewMembers;
    if (this.crewOnProject != null) {
      data['crewOnProject'] =
          this.crewOnProject!.map((v) => v.toJson()).toList();
    }
    return data;
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
  int? verifyCode;
  String? address;
  String? company;
  String? customColor;
  String? profileImage;
  String? title;
  String? companyLogo;

  Manager(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber,
        this.verifyCode,
        this.address,
        this.company,
        this.customColor,
        this.profileImage,
        this.title,
        this.companyLogo});

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
    verifyCode = json['verifyCode'];
    address = json['address'];
    company = json['company'];
    customColor = json['customColor'];
    profileImage = json['profileImage'];
    title = json['title'];
    companyLogo = json['companyLogo'];
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
    data['address'] = this.address;
    data['company'] = this.company;
    data['customColor'] = this.customColor;
    data['profileImage'] = this.profileImage;
    data['title'] = this.title;
    data['companyLogo'] = this.companyLogo;
    return data;
  }
}

class CrewOnProject {
  String? sId;
  ProjectId? projectId;
  String? managerId;
  List<String>? crewId;
  int? status;
  String? createdAt;
  int? iV;

  CrewOnProject(
      {this.sId,
        this.projectId,
        this.managerId,
        this.crewId,
        this.status,
        this.createdAt,
        this.iV});

  CrewOnProject.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectId = json['projectId'] != null
        ? new ProjectId.fromJson(json['projectId'])
        : null;
    managerId = json['managerId'];
    crewId = json['crewId'].cast<String>();
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.projectId != null) {
      data['projectId'] = this.projectId!.toJson();
    }
    data['managerId'] = this.managerId;
    data['crewId'] = this.crewId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProjectId {
  String? sId;
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  int? status;
  String? createdAt;
  int? iV;

  ProjectId(
      {this.sId,
        this.projectName,
        this.address,
        this.latitude,
        this.longitude,
        this.locationRadius,
        this.status,
        this.createdAt,
        this.iV});

  ProjectId.fromJson(Map<String, dynamic> json) {
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