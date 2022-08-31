class GetOtpResponseManager {
  bool? success;
  String? message;

  GetOtpResponseManager({this.success, this.message});

  GetOtpResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

}