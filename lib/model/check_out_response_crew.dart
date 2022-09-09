class CheckOutApiResponseCrew {
  bool? success;
  String? message;
  Data? data;

  CheckOutApiResponseCrew({this.success, this.message, this.data});

  CheckOutApiResponseCrew.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? crewId;
  String? assignProjectId;
  String? checkInTime;
  int? status;
  String? createdAt;
  String? lastCheckIn;
  int? iV;
  String? checkOutTime;

  Data(
      {this.sId,
        this.crewId,
        this.assignProjectId,
        this.checkInTime,
        this.status,
        this.createdAt,
        this.lastCheckIn,
        this.iV,
        this.checkOutTime});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    crewId = json['crewId'];
    assignProjectId = json['assignProjectId'];
    checkInTime = json['checkInTime'];
    status = json['status'];
    createdAt = json['createdAt'];
    lastCheckIn = json['lastCheckIn'];
    iV = json['__v'];
    checkOutTime = json['checkOutTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['crewId'] = this.crewId;
    data['assignProjectId'] = this.assignProjectId;
    data['checkInTime'] = this.checkInTime;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['lastCheckIn'] = this.lastCheckIn;
    data['__v'] = this.iV;
    data['checkOutTime'] = this.checkOutTime;
    return data;
  }
}