
import 'get_crew_response_time_sheet.dart';

class TimeSheetWeeklyModel {
  TimeSheetWeeklyModel({
    this.date,
    this.projectDataList,
  });

  String? date;
  List<ProjectDatum>? projectDataList;
}
