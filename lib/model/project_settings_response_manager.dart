class ProjectSettingsResponse {
  bool? success;
  String? message;
  Data? data;

  ProjectSettingsResponse({this.success, this.message, this.data});

  ProjectSettingsResponse.fromJson(Map<String, dynamic> json) {
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
  List<String>? workDays;
  String? hours;
  String? afterHoursRate;
  String? breaks;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.assignProjectId,
        this.workDays,
        this.hours,
        this.afterHoursRate,
        this.breaks,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    assignProjectId = json['assignProjectId'];
    workDays = json['workDays'].cast<String>();
    hours = json['hours'];
    afterHoursRate = json['afterHoursRate'];
    breaks = json['breaks'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignProjectId'] = this.assignProjectId;
    data['workDays'] = this.workDays;
    data['hours'] = this.hours;
    data['afterHoursRate'] = this.afterHoursRate;
    data['breaks'] = this.breaks;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}