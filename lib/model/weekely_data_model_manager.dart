import 'package:beehive/model/manager_dashboard_response.dart';

class WeekelyDataModelManager {
  WeekelyDataModelManager({
    this.date,
    this.checkInDataList,
  });

  String? date;
  String? projectName;
  String? color;
  List<CheckInProjectDetailManager>? checkInDataList;
}
