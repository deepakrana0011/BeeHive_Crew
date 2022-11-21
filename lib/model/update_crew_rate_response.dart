import 'dart:convert';

UpdateCrewRateResponse updateCrewRateResponseFromJson(String str) => UpdateCrewRateResponse.fromJson(json.decode(str));

String updateCrewRateResponseToJson(UpdateCrewRateResponse data) => json.encode(data.toJson());

class UpdateCrewRateResponse {
  UpdateCrewRateResponse({
    this.sucess,
    this.message,
  });

  bool? sucess;
  String? message;

  factory UpdateCrewRateResponse.fromJson(Map<String, dynamic> json) => UpdateCrewRateResponse(
    sucess: json["sucess"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "sucess": sucess,
    "message": message,
  };
}
