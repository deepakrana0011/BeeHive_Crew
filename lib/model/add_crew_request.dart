class AddCrewRequest {
  List<String>? crewId;

  AddCrewRequest({this.crewId});

  AddCrewRequest.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crewId'] = this.crewId;
    return data;
  }
}
