import 'dart:io';

import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/model/all_archive_projects_response.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ArchiveProjectsProvider extends BaseProvider{

  AllArchiveProjectsResponse? allArchiveProjectsResponse;

  Future<void> archiveProjectsCrew(BuildContext context) async {
    setState(ViewState.busy);
    try{
      var model = await api.archiveProjectsCrew(context);
      if(model.success == true){
        allArchiveProjectsResponse = model;
      }
      setState(ViewState.idle);
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }
}