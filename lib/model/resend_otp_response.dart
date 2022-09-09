class ResendOtpResponse {
  bool? success;
  String? message;
  Data? data;

  ResendOtpResponse({this.success, this.message, this.data});

  ResendOtpResponse.fromJson(Map<String, dynamic> json) {
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
  int? verifyToken;

  Data({this.verifyToken});

  Data.fromJson(Map<String, dynamic> json) {
    verifyToken = json['verifyToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verifyToken'] = this.verifyToken;
    return data;
  }
}