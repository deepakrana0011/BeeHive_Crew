class GetCrewProfileResponse {
  bool? success;
  Data? data;
  GetCrewProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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