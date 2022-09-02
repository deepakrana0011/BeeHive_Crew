class SetRateForCrewResponse {
  bool? success;
  String? message;
  Data? data;

  SetRateForCrewResponse({this.success, this.message, this.data});

  SetRateForCrewResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? assignProjectId;
  String? sameRate;
  List<ProjectRate>? projectRate;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.assignProjectId,
        this.sameRate,
        this.projectRate,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    assignProjectId = json['assignProjectId'];
    sameRate = json['sameRate'];
    if (json['projectRate'] != null) {
      projectRate = <ProjectRate>[];
      json['projectRate'].forEach((v) {
        projectRate!.add(new ProjectRate.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignProjectId'] = this.assignProjectId;
    data['sameRate'] = this.sameRate;
    if (this.projectRate != null) {
      data['projectRate'] = this.projectRate!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crewId'] = this.crewId;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}