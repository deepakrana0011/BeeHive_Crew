class ProjectSettingsBreakRequestManager {
  String? from;
  String? to;

  ProjectSettingsBreakRequestManager({this.from, this.to});

  ProjectSettingsBreakRequestManager.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}