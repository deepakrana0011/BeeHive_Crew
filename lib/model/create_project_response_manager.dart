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

}

class Data {
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.projectName,
        this.address,
        this.latitude,
        this.longitude,
        this.locationRadius,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    projectName = json['projectName'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationRadius = json['locationRadius'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

}