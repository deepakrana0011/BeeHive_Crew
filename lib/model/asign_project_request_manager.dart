class AssignProjectRequest {
  String? projectId;
  List<String>? crewId;

  AssignProjectRequest({this.projectId, this.crewId});

  AssignProjectRequest.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    crewId = json['crewId'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['crewId'] = this.crewId;
    return data;
  }
}