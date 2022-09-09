class ResendOtpByPhoneResponseCrew {
  bool? success;
  String? message;
  Data? data;

  ResendOtpByPhoneResponseCrew({this.success, this.message, this.data});

  ResendOtpByPhoneResponseCrew.fromJson(Map<String, dynamic> json) {
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
  int? verifyCode;
  String? address;
  String? company;
  String? name;
  String? position;
  String? profileImage;
  String? speciality;
  int? phoneNumber;

  Data(
      {this.sId,
        this.email,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.verifyCode,
        this.address,
        this.company,
        this.name,
        this.position,
        this.profileImage,
        this.speciality,
        this.phoneNumber});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    verifyCode = json['verifyCode'];
    address = json['address'];
    company = json['company'];
    name = json['name'];
    position = json['position'];
    profileImage = json['profileImage'];
    speciality = json['speciality'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['verifyCode'] = this.verifyCode;
    data['address'] = this.address;
    data['company'] = this.company;
    data['name'] = this.name;
    data['position'] = this.position;
    data['profileImage'] = this.profileImage;
    data['speciality'] = this.speciality;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}