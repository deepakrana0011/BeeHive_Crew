class AllProjectsManagerResponse {
  AllProjectsManagerResponse({
    this.success,
    this.activeProject,
    this.crewmembers,
    this.projectData,
  });

  bool? success;
  int? activeProject;
  int? crewmembers;
  List<ProjectDatum>? projectData;

  factory AllProjectsManagerResponse.fromJson(Map<String, dynamic> json) =>
      AllProjectsManagerResponse(
        success: json["success"],
        activeProject: json["activeProject"],
        crewmembers: json["crewmembers"],
        projectData: List<ProjectDatum>.from(
            json["projectData"].map((x) => ProjectDatum.fromJson(x))),
      );
}

class ProjectDatum {
  ProjectDatum({
    this.id,
    this.projectName,
    this.crewId,
    this.checkins,
    this.totalHours,
    this.crew,
  });

  String? id;
  String? projectName;
  List<String>? crewId;
  List<Checkin>? checkins;
  int? totalHours;
  int? crew;

  factory ProjectDatum.fromJson(Map<String, dynamic> json) => ProjectDatum(
        id: json["_id"] ?? 0,
        projectName: json["projectName"] ?? "",
        crewId: json["crewId"] != null
            ? List<String>.from(json["crewId"].map((x) => x))
            : [],
        checkins: json["checkins"] != null
            ? List<Checkin>.from(
                json["checkins"].map((x) => Checkin.fromJson(x)))
            : [],
        totalHours: json["totalHours"],
        crew: json["crew"] ?? 0,
      );
}

class Checkin {
  Checkin({
    this.id,
    this.crewId,
    this.assignProjectId,
    this.hoursDiff,
  });

  String? id;
  String? crewId;
  String? assignProjectId;
  int? hoursDiff;

  factory Checkin.fromJson(Map<String, dynamic> json) => Checkin(
        id: json["_id"] ?? "",
        crewId: json["crewId"] ?? "",
        assignProjectId: json["assignProjectId"] ?? "",
        hoursDiff: json["hoursDiff"] ?? '0',
      );
}
