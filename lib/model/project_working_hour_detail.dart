

class ProjectWorkingHourDetail {
  ProjectWorkingHourDetail({
    this.startTime,
    this.endTime,
    this.type,
    this.timeInterval
  });

  String? startTime;
  String? endTime;
  int? timeInterval;
  int? type; //1  working hour, 2-break, 3 interruption

  factory ProjectWorkingHourDetail.fromJson(Map<String, dynamic> json) => ProjectWorkingHourDetail(
    startTime: json["startTime"],
    endTime: json["endTime"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
    "type": type,
  };
}
