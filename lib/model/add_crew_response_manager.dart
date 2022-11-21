class AddCrewResponseManager {
  bool? success;
  List<AddCrewData>? data;

  AddCrewResponseManager({this.success, this.data});

  AddCrewResponseManager.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AddCrewData>[];
      json['data'].forEach((v) {
        data!.add(AddCrewData.fromJson(v));
      });
    }
  }


}

class AddCrewData {
  String? id;
  String? email;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  int? verifyCode;
  String? address;
  String? company;
  String? name;
  String? position;
  String? profileImage;
  String? projectRate;
  String? speciality;
  bool isSelected = false;

  AddCrewData(
      {this.id,
        this.email,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.verifyCode,
        this.address,
        this.company,
        this.name,
        this.position,
        this.profileImage,
        this.speciality,this.projectRate});

  AddCrewData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    verifyCode = json['verifyCode'];
    address = json['address'] ?? "";
    company = json['company'];
    name = json['name'];
    position = json['position']??"";
    profileImage = json['profileImage'];
    speciality = json['speciality'];
    projectRate = json['projectRate'];
  }

}