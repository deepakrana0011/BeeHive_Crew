import 'package:beehive/model/add_crew_response_manager.dart';

class CreateProjectRequest {
  CreateProjectRequest({
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
    this.breakList,
    this.roundTimesheets,
    this.sameRate,
    this.color,
    this.projectRate,
  });

  String? projectName;
  String? address;
  String? latitude;
  String? longitude;
  String? locationRadius;
  List<String>? crewId;
  List<AddCrewData>? selectedCrewMember;
  List<String>? workDays;
  String? hoursFrom;
  String? hoursTo;
  String? afterHoursRate;
  List<Break>? breakList;
  String? roundTimesheets;
  String? sameRate;
  String? color;
  List<ProjectRate>? projectRate;

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      CreateProjectRequest(
        projectName: json["projectName"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        locationRadius: json["locationRadius"],
        crewId: List<String>.from(json["crewId"].map((x) => x)),
        workDays: List<String>.from(json["workDays"].map((x) => x)),
        hoursFrom: json["hoursFrom"],
        hoursTo: json["hoursTo"],
        afterHoursRate: json["afterHoursRate"],
        breakList: json["break"] != null
            ? List<Break>.from(json["break"].map((x) => Break.fromJson(x)))
            : [],
        roundTimesheets: json["roundTimesheets"],
        sameRate: json["sameRate"],
        color: json["color"],
        projectRate: json["projectRate"] != null
            ? List<ProjectRate>.from(
                json["projectRate"].map((x) => ProjectRate.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "projectName": projectName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "locationRadius": locationRadius,
        "crewId":
            crewId != null ? List<dynamic>.from(crewId!.map((x) => x)) : [],
        "workDays": List<dynamic>.from(workDays!.map((x) => x)),
        "hoursFrom": hoursFrom,
        "hoursTo": hoursTo,
        "afterHoursRate": afterHoursRate,
        "break": List<dynamic>.from(breakList!.map((x) => x.toJson())),
        "roundTimesheets": roundTimesheets,
        "sameRate": sameRate,
        "color": color,
        "projectRate": projectRate != null
            ? List<dynamic>.from(projectRate!.map((x) => x.toJson()))
            : [],
      };

  clearCreateProjectRequest() {
    projectName = '';
    address = '';
    latitude = '';
    longitude = '';
    locationRadius = '';
    crewId = [];
    selectedCrewMember = [];
    workDays = [];
    hoursFrom = '';
    hoursTo = '';
    afterHoursRate = '';
    breakList = [];
    roundTimesheets = '';
    sameRate = '';
    projectRate = [];
  }
}

class Break {
  Break({
    this.startTime,
    this.interval,
  });

  String? startTime;
  String? interval;

  factory Break.fromJson(Map<String, dynamic> json) => Break(
        startTime: json["startTime"],
        interval: json["interval"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "interval": interval,
      };
}

class ProjectRate {
  ProjectRate({
    this.crewId,
    this.price,
  });

  String? crewId;
  String? price;

  factory ProjectRate.fromJson(Map<String, dynamic> json) => ProjectRate(
        crewId: json["crewId"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "crewId": crewId,
        "price": price,
      };
}
