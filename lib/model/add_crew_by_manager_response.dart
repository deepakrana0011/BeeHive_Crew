class AddCrewByManagerResponse {
  bool? success;
  String? message;
  Data? data;

  AddCrewByManagerResponse({this.success, this.message, this.data});

  AddCrewByManagerResponse.fromJson(Map<String, dynamic> json) {
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
  String? projectId;
  String? managerId;
 // List<Null>? crewId;
  String? name;
  String? title;
  String? speciality;
  String? company;
  int? phoneNumber;
  String? email;
  String? address;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.projectId,
        this.managerId,
       // this.crewId,
        this.name,
        this.title,
        this.speciality,
        this.company,
        this.phoneNumber,
        this.email,
        this.address,
        this.status,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    managerId = json['managerId'];
    /*if (json['crewId'] != null) {
      crewId = <Null>[];
      json['crewId'].forEach((v) {
        crewId!.add(new Null.fromJson(v));
      });
    }*/
    name = json['name'];
    title = json['title'];
    speciality = json['speciality'];
    company = json['company'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['managerId'] = this.managerId;
   /* if (this.crewId != null) {
      data['crewId'] = this.crewId!.map((v) => v.toJson()).toList();
    }*/
    data['name'] = this.name;
    data['title'] = this.title;
    data['speciality'] = this.speciality;
    data['company'] = this.company;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}