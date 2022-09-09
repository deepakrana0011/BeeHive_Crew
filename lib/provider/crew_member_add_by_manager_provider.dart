import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class CrewMemberAddByManagerProvider extends BaseProvider {
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final specialityController = TextEditingController();
  final companyController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  String profileImage = " ";
  Future addProfilePic(BuildContext context, int modes) async {
    Navigator.pop(context);
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
    profileImage = image.path.toString();
    notifyListeners();
  }

  bool isImageChanged = false;

  updateImageChanged() {
    isImageChanged = !isImageChanged;
    notifyListeners();
  }

  Future addNewCrewByManager(BuildContext context, String projectId) async {
    setState(ViewState.busy);
    try {
      var model = await api.addNewCrew(
        context,
        speciality: specialityController.text,
        title: titleController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        company: companyController.text,
        imageChanged: isImageChanged,
        projectId: projectId,
        name: nameController.text,
        profile: profileImage,
      );
      if (model.success == true) {
        Navigator.pop(context);
        setState(ViewState.idle);
        DialogHelper.showMessage(context, model.message!);
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
