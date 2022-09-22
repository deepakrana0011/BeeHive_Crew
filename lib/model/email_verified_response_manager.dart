// To parse this JSON data, do
//
//     final otpVerificationResponse = otpVerificationResponseFromJson(jsonString);

import 'dart:convert';

OtpVerificationResponse otpVerificationResponseFromJson(String str) =>
    OtpVerificationResponse.fromJson(json.decode(str));

String otpVerificationResponseToJson(OtpVerificationResponse data) =>
    json.encode(data.toJson());

class OtpVerificationResponse {
  OtpVerificationResponse({this.success, this.message, this.data, this.token});

  bool? success;
  String? message;
  String? token;

  UserDetail? data;

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerificationResponse(
        success: json["success"],
        message: json["message"],
        token: json["Token"],
        data: json["data"] != null ? UserDetail.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserDetail {
  UserDetail({
    this.id,
    this.email,
    this.name,
    this.password,
    this.status,
    this.createdAt,
    this.v,
    this.verifyCode,
  });

  String? id;
  String? email;
  String? name;
  String? password;
  int? status;
  DateTime? createdAt;
  int? v;
  int? verifyCode;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        verifyCode: json["verifyCode"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "password": password,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "__v": v,
        "verifyCode": verifyCode,
      };
}
