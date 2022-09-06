class CheckInResponseCrew {
  bool? success;
  String? message;
  Data? data;

  CheckInResponseCrew({this.success, this.message, this.data});

  CheckInResponseCrew.fromJson(Map<String, dynamic> json) {
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
  String? crewId;
  String? assignProjectId;
  String? checkInTime;
  int? status;
  String? sId;
  String? createdAt;
  String? lastCheckIn;
  int? iV;

  Data(
      {this.crewId,
        this.assignProjectId,
        this.checkInTime,
        this.status,
        this.sId,
        this.createdAt,
        this.lastCheckIn,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'];
    assignProjectId = json['assignProjectId'];
    checkInTime = json['checkInTime'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    lastCheckIn = json['lastCheckIn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crewId'] = this.crewId;
    data['assignProjectId'] = this.assignProjectId;
    data['checkInTime'] = this.checkInTime;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['lastCheckIn'] = this.lastCheckIn;
    data['__v'] = this.iV;
    return data;
  }
}