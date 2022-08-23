class EmailVerificationResponseManager {
  bool? success;
  String? message;
  Data? data;

  EmailVerificationResponseManager({this.success, this.message, this.data});

  EmailVerificationResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;
  int? verifyCode;

  Data(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber,
        this.verifyCode});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    verifyCode = json['verifyCode'];
  }


}