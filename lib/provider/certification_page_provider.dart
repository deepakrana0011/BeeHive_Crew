import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/enum/enum.dart';
import 'package:beehive/helper/dialog_helper.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/services/fetch_data_expection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CertificationPageProvider extends BaseProvider {
  String certificateImage = " ";

  removePhoto(){
    certificateImage = " ";
    notifyListeners();

  }

  Future selectCertificate(BuildContext context, int modes) async {
    final picker = ImagePicker();
    if (modes == 1) {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        addImage(pickedImage);
      }
    } else {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        addImage(pickedImage);
      }
    }
  }
  addImage(XFile image) {
    certificateImage = image.path.toString();
    notifyListeners();
  }

  /// add crew certificates

  Future<bool> addCertificate(BuildContext context, String certImage, String certName) async {
    setState(ViewState.busy);
    try {
      await api.addCertificate(context, (ApiConstantsCrew.BASEURL + ApiConstantsCrew.crewCertificates), certImage, certName);
      setState(ViewState.idle);
      return true;
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
      return false;
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
      return false;
    }
  }
}
