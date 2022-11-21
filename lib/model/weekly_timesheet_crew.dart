import 'package:beehive/model/crew_timesheet_model.dart';

class WeeklyTimeSheetCrew {
  WeeklyTimeSheetCrew({
    this.date,
    this.checkInDataList,
  });

  String? date;
  List<AllCheckin>? checkInDataList;
}
