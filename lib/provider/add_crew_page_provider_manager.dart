import 'dart:io';

import 'package:beehive/model/add_crew_response_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class AddCrewPageManagerProvider extends BaseProvider{
  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share("Beehive Network",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  List<AddCrewData> crewList = [];

  List<AddCrewData> selectedCrew = [];

  addSelectedCrewToTheList(int index){
  AddCrewData addCrewData = AddCrewData();
    if (crewList[index].isSelected == true) {
      addCrewData.sId = crewList[index].sId;
      selectedCrew.add(addCrewData);
      notifyListeners();
    } else {
      selectedCrew.removeWhere((element) =>
      crewList[index].sId == element.sId);
      notifyListeners();
    }


  }

  updateValue(int index) {
    crewList[index].isSelected = !crewList[index].isSelected;
    notifyListeners();
  }



  Future getCrewList(BuildContext context,) async {
    setState(ViewState.busy);
    try {
      var model = await api.getCrewList(context);
      if (model.success == true) {
        crewList.clear();
        crewList.addAll(model.data!);
        setState(ViewState.idle);
      } else {
        setState(ViewState.idle);

      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }




}