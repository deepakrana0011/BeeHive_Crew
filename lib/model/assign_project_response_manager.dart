class AssignProjectResponse {
  bool? success;
  String? message;
  Data? data;
  AssignProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}
class Data {
  String? projectId;
  List<String>? crewId;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;
  Data(
      {this.projectId,
        this.crewId,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    crewId = json['crewId'].cast<String>();
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }



}