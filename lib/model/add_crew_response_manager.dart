class AddCrewResponseManager {
  bool? success;
  List<AddCrewData>? data;

  AddCrewResponseManager({this.success, this.data});

  AddCrewResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AddCrewData>[];
      json['data'].forEach((v) {
        data!.add(AddCrewData.fromJson(v));
      });
    }
  }
}

class AddCrewData {
  String? sId;
  String? email;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;
  int? verifyCode;
  bool isSelected= false;
  AddCrewData(
      {this.sId,
        this.email,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber,
        this.verifyCode});

  AddCrewData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    verifyCode = json['verifyCode'];
  }


}