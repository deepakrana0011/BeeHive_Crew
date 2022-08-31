class ResetPasswordByPhoneResponse {
  bool? success;
  String? message;
  Data? data;

  ResetPasswordByPhoneResponse({this.success, this.message, this.data});

  ResetPasswordByPhoneResponse.fromJson(Map<String, dynamic> json) {
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
  int? phoneNumber;
  int? forgotOTP;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.phoneNumber,
        this.forgotOTP,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    forgotOTP = json['forgotOTP'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['forgotOTP'] = this.forgotOTP;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}