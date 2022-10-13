class UpdateProjectResponse {
  bool? success;
  String? message;
  Data? data;

  UpdateProjectResponse({this.success, this.message, this.data});

  UpdateProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? sId;
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
  List<Break>? breaks;
  String? roundTimesheets;
  String? sameRate;
  List<ProjectRate>? projectRate;
  int? status;
  String? createdAt;
  int? iV;

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    managerId = json['managerId'];
    projectName = json['projectName'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationRadius = json['locationRadius'];
    crewId = json['crewId'].cast<String>();
    workDays = json['workDays'].cast<String>();
    hoursFrom = json['hoursFrom'];
    hoursTo = json['hoursTo'];
    afterHoursRate = json['afterHoursRate'];
    if (json['break'] != null) {
      breaks = <Break>[];
      json['break'].forEach((v) {
        breaks!.add(new Break.fromJson(v));
      });
    }
    roundTimesheets = json['roundTimesheets'];
    sameRate = json['sameRate'];
    if (json['projectRate'] != null) {
      projectRate = <ProjectRate>[];
      json['projectRate'].forEach((v) {
        projectRate!.add(new ProjectRate.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }
}

class Break {
  String? startTime;
  String? interval;
  String? sId;

  Break({this.startTime, this.interval, this.sId});

  Break.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    interval = json['interval'];
    sId = json['_id'];
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
