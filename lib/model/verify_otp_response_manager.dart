class VerifyOtpResponseManager {
  bool? success;
  String? message;

  VerifyOtpResponseManager({this.success, this.message});

  VerifyOtpResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

}