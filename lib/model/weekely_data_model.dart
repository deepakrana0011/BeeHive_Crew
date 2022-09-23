import 'package:beehive/model/crew_dashboard_response.dart';

class WeekelyDataModel {
  WeekelyDataModel({
    this.date,
    this.checkInDataList,
  });

  String? date;
  List<CheckInProjectDetail>? checkInDataList;
}
