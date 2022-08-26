class UpdateCrewProfileResponse {
  bool? success;
  String? message;
  Data? data;

  UpdateCrewProfileResponse({this.success, this.message, this.data});

  UpdateCrewProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? address;
  String? company;
  String? position;
  String? profileImage;
  String? speciality;
  String? name;

  Data(
      {this.sId,
        this.email,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber,
        this.verifyCode,
        this.address,
        this.company,
        this.position,
        this.profileImage,
        this.speciality,
        this.name});

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
    address = json['address'];
    company = json['company'];
    position = json['position'];
    profileImage = json['profileImage'];
    speciality = json['speciality'];
    name = json['name'];
  }


}