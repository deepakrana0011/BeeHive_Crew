import 'package:beehive/model/crew_dashboard_response.dart';
import 'package:beehive/model/manager_dashboard_response.dart';

class WeekelyDataModelManager {
  WeekelyDataModelManager({
    this.date,
    this.checkInDataList,
  });

  String? date;
  String? projectName;
  List<CheckInProjectDetailManager>? checkInDataList;
}
