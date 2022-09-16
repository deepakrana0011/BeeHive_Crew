class WeeklyCheckInResponse {
  bool? success;
  List<Weekly>? weekly;
  WeeklyCheckInResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['weekly'] != null) {
      weekly = <Weekly>[];
      json['weekly'].forEach((v) {
        weekly!.add( Weekly.fromJson(v));
      });
    }
  }
}

class Weekly {
  String? sId;
  String? crewId;
  String? assignProjectId;
  String? checkInTime;
  String? hoursDiff;
  int? status;
  String? totalWorkingHours;
  String? createdAt;
  int? iV;
  String? checkOutTime;
  Weekly.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    crewId = json['crewId'];
    assignProjectId = json['assignProjectId'];
    checkInTime = json['checkInTime'];
    hoursDiff = json['hoursDiff'];
    status = json['status'];
    totalWorkingHours = json['TotalWorkingHours'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    checkOutTime = json['checkOutTime'];
  }
}