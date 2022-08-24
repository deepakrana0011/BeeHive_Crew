class ResetPasswordResponseCrew {
  bool? success;
  String? message;
  Data? data;

  ResetPasswordResponseCrew({this.success, this.message, this.data});

  ResetPasswordResponseCrew.fromJson(Map<String, dynamic> json) {
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
  String? email;
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
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    verifyCode = json['verifyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['verifyCode'] = this.verifyCode;
    return data;
  }
}