class AddNoteManagerResponse {
  bool? success;
  String? message;
  List<Data>? data;

  AddNoteManagerResponse({this.success, this.message, this.data});

  AddNoteManagerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? assignProjectId;
  String? title;
  String? note;
  List<String>? image;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.assignProjectId,
        this.title,
        this.note,
        this.image,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    assignProjectId = json['assignProjectId'];
    title = json['title'];
    note = json['note'];
    image = json['image'].cast<String>();
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignProjectId'] = this.assignProjectId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['image'] = this.image;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}