import 'package:beehive/model/create_project_request.dart';

class UpdateCrewMemberRequest {
  UpdateCrewMemberRequest({
    this.sameRate,
    this.crewId,
    this.projectRate,
  });

  String? sameRate;
  List<String>? crewId;
  List<ProjectRate>? projectRate;

  factory UpdateCrewMemberRequest.fromJson(Map<String, dynamic> json) => UpdateCrewMemberRequest(
    sameRate: json["sameRate"],
    crewId: List<String>.from(json["crewId"].map((x) => x)),
    projectRate: List<ProjectRate>.from(json["projectRate"].map((x) => ProjectRate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sameRate": sameRate,
    "crewId": crewId!=null?List<dynamic>.from(crewId!.map((x) => x)):null,
    "projectRate": projectRate!=null?List<dynamic>.from(projectRate!.map((x) => x.toJson())):projectRate,
  };
}

