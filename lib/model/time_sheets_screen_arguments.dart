import 'package:beehive/model/crew_timesheet_model.dart';

class TimeSheetsScreenArguments{
  String? name;
  String? profileImage;
  AllCheckin? allCheckIn;

  TimeSheetsScreenArguments(this.name, this.profileImage, this.allCheckIn);
}