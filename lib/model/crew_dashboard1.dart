import 'dart:ffi';

class CrewDashboardResponse1 {
  bool? success;
  Data? data;
  int? activeProjects;
  List<MyProjects>? myProject;
  List<LastCheckIn>? lastCheckIn;
  List<AllCheckIns>? allCheckIns;
  int? todayTotalWorkedHours;
  int? weeklyHours;
  List<Today>? today;

  CrewDashboardResponse1.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    activeProjects = json['activeProjects'];
    if (json['myProjects'] != null) {
      myProject = <MyProjects>[];
      json['myProjects'].forEach((v) {
        myProject!.add(MyProjects.fromJson(v));
      });
    }
    if (json['lastCheckIn'] != null) {
      lastCheckIn = <LastCheckIn>[];
      json['lastCheckIn'].forEach((v) {
        lastCheckIn!.add(LastCheckIn.fromJson(v));
      });
    }
    if (json['allCheckIns'] != null) {
      allCheckIns = <AllCheckIns>[];
      json['allCheckIns'].forEach((v) {
        allCheckIns!.add(AllCheckIns.fromJson(v));
      });
    }
    todayTotalWorkedHours = json['todayTotalWorkedHours'];
    weeklyHours = json['weeklyHours'];
    if (json['today'] != null) {
      today = <Today>[];
      json['today'].forEach((v)
      {today!.add(Today.fromJson(v)); });
    }
  }

}
class Today  {
  String? sId;
  ProjectId? projectId;
  String? managerId;
  String? crewId;
  int? status;
  String? hoursDiff;
  String? createdAt;
  int? iV;

  Today.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectId = json['assignProjectId'] != null
        ?  ProjectId.fromJson(json['assignProjectId'])
        : null;
    managerId = json['managerId'];
    crewId = json['crewId'];
    status = json['status'];
    hoursDiff = json['hoursDiff'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }
}

class Data {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  int? verifyCode;

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    verifyCode = json['verifyCode'];
  }
}

class MyProjects {
  String? sId;
  ProjectId? projectId;
  String? managerId;
  List<String>? crewId;
  int? status;
  String? hoursDiff;
  String? createdAt;
  int? iV;

  MyProjects.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectId = json['projectId'] != null
        ? new ProjectId.fromJson(json['projectId'])
        : null;
    managerId = json['managerId'];
    crewId = json['crewId'].cast<String>();
    status = json['status'];
    hoursDiff = json['hoursDiff'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }
}

class ProjectId {
  String? sId;
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  List<String>? workDays;
  int? status;
  List<Breaks>? breaks;
  String? createdAt;
  int? iV;
  String? totalWorkingHours;
  String? afterHoursRate;
  String? hoursFrom;
  String? hoursTo;
  String? roundTimesheets;

  ProjectId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['projectName'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationRadius = json['locationRadius'];
    workDays = json['workDays'].cast<String>();
    status = json['status'];
    if (json['break'] != null) {
      breaks = <Breaks>[];
      json['break'].forEach((v) {
        breaks!.add(Breaks.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    iV = json['__v'];
    totalWorkingHours = json['TotalWorkingHours'];
    afterHoursRate = json['afterHoursRate'];
    hoursFrom = json['hoursFrom'];
    hoursTo = json['hoursTo'];
    roundTimesheets = json['roundTimesheets'];
  }
}

class Breaks {
  String? from;
  String? to;
  String? sId;

  Breaks.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    sId = json['_id'];
  }
}

class LastCheckIn {
  String? sId;
  String? checkInTime;

  LastCheckIn({this.sId, this.checkInTime});

  LastCheckIn.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    checkInTime = json['checkInTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['checkInTime'] = this.checkInTime;
    return data;
  }
}

class AllCheckIns {
  String? sId;
  String? crewId;
  AssignProjectId? assignProjectId;
  String? checkInTime;
  int? status;
  String? totalWorkingHours;
  String? createdAt;
  int? iV;
  String? checkOutTime;
  String? hoursDiff;

  AllCheckIns(
      {this.sId,
      this.crewId,
      this.assignProjectId,
      this.checkInTime,
      this.status,
      this.totalWorkingHours,
      this.createdAt,
      this.iV,
      this.checkOutTime,
      this.hoursDiff});

  AllCheckIns.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    crewId = json['crewId'];
    assignProjectId = json['assignProjectId'] != null
        ? new AssignProjectId.fromJson(json['assignProjectId'])
        : null;
    checkInTime = json['checkInTime'];
    status = json['status'];
    totalWorkingHours = json['TotalWorkingHours'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    checkOutTime = json['checkOutTime'];
    hoursDiff = json['hoursDiff'];
  }
}

class AssignProjectId {
  String? sId;
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  List<String>? workDays;
  int? status;
  List<ProjectIdBreaks>? projectIdBreak;
  String? createdAt;
  int? iV;
  String? afterHoursRate;
  String? hoursFrom;
  String? hoursTo;
  String? roundTimesheets;
  String? totalWorkingHours;

  AssignProjectId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectName = json['projectName'];
    address = json['address'];
    latitude = json['latitude'] ?? '';
    longitude = json['longitude']??'';
    locationRadius = json['locationRadius'];
    workDays = json['workDays'].cast<String>();
    status = json['status'];
    if (json['break'] != null) {
      projectIdBreak = <ProjectIdBreaks>[];
      json['break'].forEach((v) {
        projectIdBreak!.add(ProjectIdBreaks.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    iV = json['__v'];
    afterHoursRate = json['afterHoursRate'];
    hoursFrom = json['hoursFrom'];
    hoursTo = json['hoursTo'];
    roundTimesheets = json['roundTimesheets'];
    totalWorkingHours = json['TotalWorkingHours'];
  }
}

class ProjectIdBreaks {
  String? from;
  String? to;
  String? sId;

  ProjectIdBreaks.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    sId = json['_id'];
  }
}
