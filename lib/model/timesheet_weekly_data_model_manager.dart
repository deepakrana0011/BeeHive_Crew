import 'package:beehive/model/project_timesheet_response.dart';

class TimeSheetWeeklyDataModelManager {
  TimeSheetWeeklyDataModelManager({
    this.date,
    this.projectDataList,
  });

  String? date;
  List<TimeSheetProjectData>? projectDataList;
}
