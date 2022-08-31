class GetOtpForResetPasswordResponse {
  bool? success;
  String? message;
  Data? data;

  GetOtpForResetPasswordResponse({this.success, this.message, this.data});

  GetOtpForResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  String? email;
  int? forgotOTP;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.email,
        this.forgotOTP,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    forgotOTP = json['forgotOTP'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }


}