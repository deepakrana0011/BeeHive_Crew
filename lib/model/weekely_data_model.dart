import 'package:beehive/model/crew_dashboard_response.dart';

class WeekelyDataModelCrew {
  WeekelyDataModelCrew({
    this.date,
    this.checkInDataList,
  });

  String? date;
  List<CheckInProjectDetailCrew>? checkInDataList;
}
