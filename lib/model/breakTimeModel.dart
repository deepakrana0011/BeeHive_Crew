class BreakTimeModel {
  BreakTimeModel({
    this.breakIntervalTime,
    this.breakStartTime,
  });

  String? breakIntervalTime;
  String? breakStartTime;

  factory BreakTimeModel.fromJson(Map<String, dynamic> json) => BreakTimeModel(
        breakIntervalTime: json["breakIntervalTime"],
        breakStartTime: json["breakStartTime"],
      );

  Map<String, dynamic> toJson() => {
        "breakIntervalTime": breakIntervalTime,
        "breakStartTime": breakStartTime,
      };
}
