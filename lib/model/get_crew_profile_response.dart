class GetCrewProfileResponse {
  bool? success;
  Data? data;
  List<Cert> cert = [];

  GetCrewProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['profile'] != null ? Data.fromJson(json['profile']) : null;
    if (json['cert'] != null) {
      cert = <Cert>[];
      json['cert'].forEach((v) {
        cert.add(Cert.fromJson(v));
      });
    }
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

class Cert {
  String? sId;
  String? managerId;
  String? certName;
  int? status;
  String? createdAt;
  String? certImage;
  int? iV;

  Cert(
      {this.sId,
        this.managerId,
        this.certName,
        this.status,
        this.createdAt,
        this.certImage,
        this.iV});

  Cert.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    managerId = json['managerId'];
    certName = json['certName'];
    status = json['status'];
    createdAt = json['createdAt'];
    certImage = json['certImage'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['managerId'] = this.managerId;
    data['certName'] = this.certName;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['certImage'] = this.certImage;
    data['__v'] = this.iV;
    return data;
  }
}