class PrivateNoteResponseManager {
  bool? success;
  String? message;
  Data? data;

  PrivateNoteResponseManager({this.success, this.message, this.data});

  PrivateNoteResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? managerId;
  String? crewId;
  String? title;
  String? note;
  int? status;
  String? createdAt;
  String? sId;
  int? iV;

  Data(
      {this.managerId,
        this.crewId,
        this.title,
        this.note,
        this.status,
        this.createdAt,
        this.sId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    managerId = json['managerId'];
    crewId = json['crewId'];
    title = json['title'];
    note = json['note'];
    status = json['status'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    iV = json['__v'];
  }
}
