class CheckBoxModelCrew {
  String? projectId;
  String? projectName;

  CheckBoxModelCrew({this.projectId, this.projectName});

  CheckBoxModelCrew.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    projectName = json['projectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['projectName'] = this.projectName;
    return data;
  }
}