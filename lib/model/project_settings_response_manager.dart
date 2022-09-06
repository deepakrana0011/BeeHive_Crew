class ProjectSettingsResponseManager {
  bool? success;
  String? message;
  Data? data;

  ProjectSettingsResponseManager({this.success, this.message, this.data});

  ProjectSettingsResponseManager.fromJson(Map<String, dynamic> json) {
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
  List<Hours>? hours;
  String? afterHoursRate;
  List<Breaks>? breaks;
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
    if (json['hours'] != null) {
      hours = <Hours>[];
      json['hours'].forEach((v) {
        hours!.add(new Hours.fromJson(v));
      });
    }

    afterHoursRate = json['afterHoursRate'];
    if (json['breaks'] != null) {
      breaks = <Breaks>[];
      json['breaks'].forEach((v) {
        breaks!.add(new Breaks.fromJson(v));
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
    data['workDays'] = this.workDays;
    if (this.hours != null) {
      data['hours'] = this.hours!.map((v) => v.toJson()).toList();
    }
    data['afterHoursRate'] = this.afterHoursRate;
    if (this.breaks != null) {
      data['breaks'] = this.breaks!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Breaks {
  String? from;
  String? to;
  String? sId;

  Breaks({this.from, this.to, this.sId});

  Breaks.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['_id'] = this.sId;
    return data;
  }
}
class Hours {
  String? from;
  String? to;
  String? sId;

  Hours({this.from, this.to, this.sId});

  Hours.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['_id'] = this.sId;
    return data;
  }
}