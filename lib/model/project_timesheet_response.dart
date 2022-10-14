class ProjectTimeSheetResponse {
  bool? success;
  Manager? manager;
  int? activeProject;
  int? crewmembers;
  List<ProjectData>? projectData;

  ProjectTimeSheetResponse(
      {this.success,
        this.manager,
        this.activeProject,
        this.crewmembers,
        this.projectData});

  ProjectTimeSheetResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    manager =
    json['manager'] != null ? new Manager.fromJson(json['manager']) : null;
    activeProject = json['activeProject'];
    crewmembers = json['crewmembers'];
    if (json['projectData'] != null) {
      projectData = <ProjectData>[];
      json['projectData'].forEach((v) {
        projectData!.add(new ProjectData.fromJson(v));
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
      data['projectData'] = this.projectData!.map((v) => v.toJson()).toList();
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

class ProjectData {
  String? sId;
  String? managerId;
  String? projectName;
  String? address;
  double? latitude;
  double? longitude;
  String? locationRadius;
  List<String>? crewId;
  List<String>? workDays;
  String? hoursFrom;
  String? hoursTo;
  String? afterHoursRate;
  List<Breaks>? breaks;
  String? roundTimesheets;
  String? sameRate;
  List<ProjectRate>? projectRate;
  int? status;
  String? createdAt;
  int? iV;
  Checkins? checkins;

  ProjectData(
      {this.sId,
        this.managerId,
        this.projectName,
        this.address,
        this.latitude,
        this.longitude,
        this.locationRadius,
        this.crewId,
        this.workDays,
        this.hoursFrom,
        this.hoursTo,
        this.afterHoursRate,
        this.breaks,
        this.roundTimesheets,
        this.sameRate,
        this.projectRate,
        this.status,
        this.createdAt,
        this.iV,
        this.checkins});

  ProjectData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    managerId = json['managerId'];
    projectName = json['projectName'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationRadius = json['locationRadius'];
    crewId = json['crewId'].cast<String>();
    workDays = json['workDays'].cast<String>();
    hoursFrom = json['hoursFrom'];
    hoursTo = json['hoursTo'];
    afterHoursRate = json['afterHoursRate'];
    if (json['breaks'] != null) {
      breaks = <Breaks>[];
      json['breaks'].forEach((v) {
        breaks!.add(new Breaks.fromJson(v));
      });
    }
    roundTimesheets = json['roundTimesheets'];
    sameRate = json['sameRate'];
    if (json['projectRate'] != null) {
      projectRate = <ProjectRate>[];
      json['projectRate'].forEach((v) {
        projectRate!.add(new ProjectRate.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    checkins = json['checkins'] != null
        ? new Checkins.fromJson(json['checkins'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['managerId'] = this.managerId;
    data['projectName'] = this.projectName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['locationRadius'] = this.locationRadius;
    data['crewId'] = this.crewId;
    data['workDays'] = this.workDays;
    data['hoursFrom'] = this.hoursFrom;
    data['hoursTo'] = this.hoursTo;
    data['afterHoursRate'] = this.afterHoursRate;
    if (this.breaks != null) {
      data['breaks'] = this.breaks!.map((v) => v.toJson()).toList();
    }
    data['roundTimesheets'] = this.roundTimesheets;
    data['sameRate'] = this.sameRate;
    if (this.projectRate != null) {
      data['projectRate'] = this.projectRate!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    if (this.checkins != null) {
      data['checkins'] = this.checkins!.toJson();
    }
    return data;
  }
}

class Breaks {
  String? startTime;
  String? interval;
  String? sId;

  Breaks({this.startTime, this.interval, this.sId});

  Breaks.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    interval = json['interval'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['interval'] = this.interval;
    data['_id'] = this.sId;
    return data;
  }
}

class ProjectRate {
  String? crewId;
  String? price;
  String? sId;

  ProjectRate({this.crewId, this.price, this.sId});

  ProjectRate.fromJson(Map<String, dynamic> json) {
    crewId = json['crewId'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crewId'] = this.crewId;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}

class Checkins {
  String? sId;
  String? crewId;
  String? checkInTime;
  int? hoursDiff;
  List<Interuption>? interuption;
  List<Breaks>? breaks;
  String? checkOutTime;

  Checkins(
      {this.sId,
        this.crewId,
        this.checkInTime,
        this.hoursDiff,
        this.interuption,
        this.breaks,
        this.checkOutTime});

  Checkins.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    crewId = json['crewId'];
    checkInTime = json['checkInTime'];
    hoursDiff = json['hoursDiff'];
    if (json['interuption'] != null) {
      interuption = <Interuption>[];
      json['interuption'].forEach((v) {
        interuption!.add(new Interuption.fromJson(v));
      });
    }
    if (json['breaks'] != null) {
      breaks = <Breaks>[];
      json['breaks'].forEach((v) {
        breaks!.add(new Breaks.fromJson(v));
      });
    }
    checkOutTime = json['checkOutTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['crewId'] = this.crewId;
    data['checkInTime'] = this.checkInTime;
    data['hoursDiff'] = this.hoursDiff;
    if (this.interuption != null) {
      data['interuption'] = this.interuption!.map((v) => v.toJson()).toList();
    }
    if (this.breaks != null) {
      data['breaks'] = this.breaks!.map((v) => v.toJson()).toList();
    }
    data['checkOutTime'] = this.checkOutTime;
    return data;
  }
}

class Interuption {
  String? startTime;
  String? endTime;
  String? sId;

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
