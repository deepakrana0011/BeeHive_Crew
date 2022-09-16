class CreateProjectResponseManager {
  bool? success;
  String? message;
  Data? data;

  CreateProjectResponseManager({this.success, this.message, this.data});

  CreateProjectResponseManager.fromJson(Map<String, dynamic> json) {
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
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  List<GetData>? workDays;
  int? status;
  String? sId;
  List<GetData>? breaks;
  String? createdAt;
  int? iV;

  Data({this.projectName, this.address, this.latitude, this.longitude, this.locationRadius, this.workDays, this.status, this.sId, this.breaks, this.createdAt, this.iV});

Data.fromJson(Map<String, dynamic> json) {
projectName = json['projectName'];
address = json['address'];
latitude = json['latitude'];
longitude = json['longitude'];
locationRadius = json['locationRadius'];
if (json['workDays'] != null) {
workDays = <GetData>[];
json['workDays'].forEach((v) { workDays!.add(new GetData.fromJson(v)); });
}
status = json['status'];
sId = json['_id'];
if (json['break'] != null) {
breaks = <GetData>[];
json['break'].forEach((v) { breaks!.add(new GetData.fromJson(v)); });
}
createdAt = json['createdAt'];
iV = json['__v'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['projectName'] = this.projectName;
  data['address'] = this.address;
  data['latitude'] = this.latitude;
  data['longitude'] = this.longitude;
  data['locationRadius'] = this.locationRadius;
  if (this.workDays != null) {
    data['workDays'] = this.workDays!.map((v) => v.toJson()).toList();
  }
  data['status'] = this.status;
  data['_id'] = this.sId;
  if (this.breaks != null) {
    data['break'] = this.breaks!.map((v) => v.toJson()).toList();
  }
  data['createdAt'] = this.createdAt;
  data['__v'] = this.iV;
  return data;
}
}

class GetData {
  String? from;
  String? to;

  GetData({this.from, this.to});

  GetData.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}