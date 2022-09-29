class GetManagerProfileResponse {
  bool? success;
  Data? data;
  List<Cert> cert = [];

  GetManagerProfileResponse({this.success, this.data});

  GetManagerProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['profile'] != null ? Data.fromJson(json['profile']) : null;
    if (json['cert'] != null) {
      cert = <Cert>[];
      json['cert'].forEach((v) {
        cert.add(Cert.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
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
  String? address;
  String? company;
  dynamic customColor;
  String? profileImage;
  String? title;
  String? companyLogo;

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
        this.verifyCode,
        this.address,
        this.company,
        this.customColor,
        this.profileImage,
        this.title,
        this.companyLogo});

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
    address = json['address'];
    company = json['company'];
    customColor = json['customColor'];
    profileImage = json['profileImage'];
    title = json['title'];
    companyLogo = json['companyLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['verifyCode'] = this.verifyCode;
    data['address'] = this.address;
    data['company'] = this.company;
    data['customColor'] = this.customColor;
    data['profileImage'] = this.profileImage;
    data['title'] = this.title;
    data['companyLogo'] = this.companyLogo;
    return data;
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