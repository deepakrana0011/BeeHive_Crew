import 'package:beehive/model/project_days_list_model.dart';
import 'package:beehive/provider/base_provider.dart';

class ProjectSettingsManagerProvider extends BaseProvider{

  List<String> daysName = ["SU","M","TU","W","TH","F","SA"];

  List<DaysModel> weekDays = [];

  updateColor(int index){
    weekDays[index].selected = !weekDays[index].selected;
    notifyListeners();
  }

  addModelToList(){
    for(int i = 0; i < daysName.length;i++){
      DaysModel daysModel = DaysModel();
      daysModel.day = daysName[i];
      daysModel.selected = false;
      weekDays.add(daysModel);
      notifyListeners();
    }
  }
  bool status = false;
  void updateSwitcherStatus(bool value) {
    status = value;
    notifyListeners();
  }



}