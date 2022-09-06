class DashBoardPageResponseCrew {
  bool? success;
  List<MyProject>? myProject;
  User? user;

  DashBoardPageResponseCrew({this.success, this.myProject, this.user});

  DashBoardPageResponseCrew.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['myProject'] != null) {
      myProject = <MyProject>[];
      json['myProject'].forEach((v) {
        myProject!.add(new MyProject.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.myProject != null) {
      data['myProject'] = this.myProject!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class MyProject {
  String? sId;
  ProjectId? projectId;
  String? managerId;
  List<String>? crewId;
  int? status;
  String? createdAt;
  int? iV;

  MyProject(
      {this.sId,
        this.projectId,
        this.managerId,
        this.crewId,
        this.status,
        this.createdAt,
        this.iV});

  MyProject.fromJson(Map<String, dynamic> json) {
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

class User {
  String? sId;
  String? email;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  int? verifyCode;
  String? address;
  String? company;
  String? name;
  String? position;
  String? profileImage;
  String? speciality;

  User(
      {this.sId,
        this.email,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.verifyCode,
        this.address,
        this.company,
        this.name,
        this.position,
        this.profileImage,
        this.speciality});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
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