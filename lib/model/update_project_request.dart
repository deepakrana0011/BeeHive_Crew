class UpdateProjectRequest {
  String? hoursFrom;
  String? hoursTo;
  String? afterHoursRate;
  List<Break>? breaks;
  String? roundTimesheets;

  UpdateProjectRequest({this.hoursFrom, this.hoursTo, this.afterHoursRate, this.breaks, this.roundTimesheets});


Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hoursFrom'] = hoursFrom;
  data['hoursTo'] = hoursTo;
  data['afterHoursRate'] = afterHoursRate;
  if (breaks != null) {
    data['break'] = breaks!.map((v) => v.toJson()).toList();
}
  data['roundTimesheets'] = roundTimesheets;
  return data;
}
}

class Break {
  String? startTime;
  String? interval;

  Break({this.startTime, this.interval});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startTime'] = startTime;
    data['interval'] = interval;
    return data;
  }
}
