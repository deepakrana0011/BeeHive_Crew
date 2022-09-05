class DashBoardResponseManager {
  bool? success;
  int? data;
  int? crewMembers;
  List<CrewOnProject>? crewOnProject;

  DashBoardResponseManager(
      {this.success,
        this.data,
        this.crewMembers,
        this.crewOnProject});

  DashBoardResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    crewMembers = json['crewMembers'];

    if (json['crewOnProject'] != null) {
      crewOnProject = <CrewOnProject>[];
      json['crewOnProject'].forEach((v) {
        crewOnProject!.add(new CrewOnProject.fromJson(v));
      });
    }
  }


}

class CrewOnProject {
  String? sId;
  ProjectId? projectId;
  List<String>? crewId;
  int? status;
  String? createdAt;
  int? iV;
  String? managerId;

  CrewOnProject(
      {this.sId,
        this.projectId,
        this.crewId,
        this.status,
        this.createdAt,
        this.iV,
        this.managerId});

  CrewOnProject.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectId = json['projectId'] != null
        ? new ProjectId.fromJson(json['projectId'])
        : null;
    crewId = json['crewId'].cast<String>();
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    managerId = json['managerId'];
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


}