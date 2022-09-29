class AddCertificateResponse {
  bool? success;
  String? message;
  Data? data;

  AddCertificateResponse({this.success, this.message, this.data});

  AddCertificateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? certName;
  int? status;
  String? sId;
  String? createdAt;
  String? certImage;
  int? iV;

  Data(
      {this.crewId,
        this.certName,
        this.status,
        this.sId,
        this.createdAt,
        this.certImage,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'];
    certName = json['certName'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    certImage = json['certImage'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['crewId'] = this.crewId;
    data['certName'] = this.certName;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['certImage'] = this.certImage;
    data['__v'] = this.iV;
    return data;
  }
}
