class SignUpResponse {
  bool? success;
  String? message;
  Data? data;
  String? token;

  SignUpResponse({this.success, this.message, this.data, this.token});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['Token'];
  }


}

class Data {
  String? email;
  String? password;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.email,
        this.password,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }


}