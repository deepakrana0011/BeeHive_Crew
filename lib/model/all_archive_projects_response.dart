class AllArchiveProjectsResponse {
  bool? success;
  int? archivedProjects;
  int? crewmembers;
  List<ProjectData> projectData = [];


  AllArchiveProjectsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    archivedProjects = json['archivedProjects'];
    crewmembers = json['crewmembers'];
    if (json['projectData'] != null) {
      projectData = <ProjectData>[];
      json['projectData'].forEach((v) {
        projectData.add(ProjectData.fromJson(v));
      });
    }
  }

}

class ProjectData {
  String? sId;
  String? projectName;
  int? totalHours;
  int? crew;

  ProjectData(
      {this.sId,
        this.projectName,
        this.totalHours,
        this.crew});

  ProjectData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['projectName'];
    totalHours = json['totalHours'];
    crew = json['crew'];
  }

}
