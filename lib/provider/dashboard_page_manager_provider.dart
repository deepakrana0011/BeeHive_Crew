import 'package:beehive/provider/base_provider.dart';

class DashBoardPageManagerProvider extends BaseProvider{


  bool checkedInNoProjects = false;

  bool hasCheckInCheckOut = false;
  bool isCheckedIn = false;
  bool noProject = false;
  updateNoProject(){
    noProject = !noProject;
    notifyListeners();

  }


}