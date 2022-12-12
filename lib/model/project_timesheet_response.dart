class ProjectTimeSheetResponse {
  bool? success;
  Manager? manager;
  int? activeProject;
  int? totalHours;
  int? crewmembers;
  List<TimeSheetProjectData> projectData = [];

  ProjectTimeSheetResponse(
      {this.success,
        this.manager,
        this.activeProject,
        this.crewmembers});

  ProjectTimeSheetResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    manager =
    json['manager'] != null ? new Manager.fromJson(json['manager']) : null;
    activeProject = json['activeProject'];
    totalHours = json['totalHours'];
    crewmembers = json['crewmembers'];
    if (json['projectData'] != null) {
      projectData = <TimeSheetProjectData>[];
      json['projectData'].forEach((v) {
        projectData.add(new TimeSheetProjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.manager != null) {
      data['manager'] = this.manager!.toJson();
    }
    data['activeProject'] = this.activeProject;
    data['crewmembers'] = this.crewmembers;
    if (this.projectData != null) {
      data['projectData'] = this.projectData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manager {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;

  Manager(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber});

  Manager.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class TimeSheetProjectData {
  String? sId;
  String? date;
  String? id;
  String? projectName;
  String? color;
  List<String>? crewId;
  int? status;
  List<TimeSheetCheckins> checkins = [];

  TimeSheetProjectData(
      {this.sId,
        this.date,
        this.id,
        this.projectName,
        this.color,
        this.crewId,
        this.status});

  TimeSheetProjectData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    id = json['id'];
    projectName = json['projectName'];
    color = json['color'];
    crewId = json['crewId'].cast<String>();
    status = json['status'];
    if (json['checkins'] != null) {
      checkins = <TimeSheetCheckins>[];
      json['checkins'].forEach((v) {
        checkins.add(TimeSheetCheckins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['id'] = this.id;
    data['projectName'] = this.projectName;
    data['crewId'] = this.crewId;
    data['status'] = this.status;
    if (this.checkins != null) {
      data['checkins'] = this.checkins.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSheetCheckins {
  String? sId;
  String? crewId;
  String? checkInTime;
  int? hoursDiff;
  List<Interuption>? interuption;
  List<Interuption>? ignoredInteruption;
  String? checkOutTime;
  String? date;
  List<Break>? breaks;
  List<Crew>? crew;
  int totalMinutes=0;

  TimeSheetCheckins(
      {this.sId,
        this.crewId,
        this.checkInTime,
        this.hoursDiff,
        this.interuption,
        this.ignoredInteruption,
        this.checkOutTime,
        this.date,
        this.crew,this.breaks});

  TimeSheetCheckins.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    crewId = json['crewId'];
    checkInTime = json['checkInTime'];
    hoursDiff = json['hoursDiff'];
    if (json['interuption'] != null) {
      interuption = <Interuption>[];
      json['interuption'].forEach((v) {
        interuption!.add( Interuption.fromJson(v));
      });
    }
    if (json['ignoredInteruption'] != null) {
      ignoredInteruption = <Interuption>[];
      json['ignoredInteruption'].forEach((v) {
        ignoredInteruption!.add( Interuption.fromJson(v));
      });
    }
    checkOutTime = json['checkOutTime'];
    date = json['date'];
    if (json['break'] != null) {
      breaks = <Break>[];
      json['break'].forEach((v) {
        breaks!.add( Break.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = <Crew>[];
      json['crew'].forEach((v) {
        crew!.add(new Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['crewId'] = this.crewId;
    data['checkInTime'] = this.checkInTime;
    data['hoursDiff'] = this.hoursDiff;
    if (this.interuption != null) {
      data['interuption'] = this.interuption!.map((v) => v.toJson()).toList();
    }
    data['checkOutTime'] = this.checkOutTime;
    data['date'] = this.date;
    if (this.crew != null) {
      data['crew'] = this.crew!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interuption {
  String? startTime;
  String? endTime;
  String? sId;
  bool? selfMadeInterruption = false;
  int? type; //

  Interuption({this.startTime, this.endTime, this.sId});

  Interuption.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['_id'] = this.sId;
    return data;
  }
}

class Crew {
  String? sId;
  String? email;
  String? name;
  String? password;
  int? status;
  String? createdAt;
  int? iV;
  String? countryCode;
  int? phoneNumber;
  String? address;
  String? company;
  String? position;
  String? speciality;
  String? profileImage;

  Crew(
      {this.sId,
        this.email,
        this.name,
        this.password,
        this.status,
        this.createdAt,
        this.iV,
        this.countryCode,
        this.phoneNumber,
        this.address,
        this.company,
        this.position,
        this.speciality,this.profileImage});

  Crew.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    company = json['company'];
    position = json['position'];
    speciality = json['speciality'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['company'] = this.company;
    data['position'] = this.position;
    data['speciality'] = this.speciality;
    return data;
  }
}

class Break {
  Break({
    this.startTime,
    this.interval,
    this.id,
  });

  String? startTime;
  String? interval;
  String? id;

  factory Break.fromJson(Map<String, dynamic> json) => Break(
    startTime: json["startTime"],
    interval: json["interval"],
    id: json["_id"],
  );
}
