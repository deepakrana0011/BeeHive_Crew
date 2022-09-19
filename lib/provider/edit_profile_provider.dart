import 'dart:io';

import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../model/get_crew_profile_response.dart';
import '../services/fetch_data_expection.dart';

class EditProfileProvider extends BaseProvider {
  GetCrewProfileResponse? getObj;

  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final specialityController = TextEditingController();
  final companyNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  bool imageChanged = false;

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

  upDateImageChanged() {
    imageChanged = true;
    notifyListeners();
  }

  addImage(XFile image) {
    profileImage = image.path.toString();
    notifyListeners();
  }

  setAllController() {
    profileImage =
    "${ApiConstantsCrew.BASE_URL_IMAGE}${getObj!.data!.profileImage == null ? ImageConstants.personIcon : getObj!.data!.profileImage}";
    nameController.text = getObj!.data!.name!;
    titleController.text = getObj!.data!.position!;
    specialityController.text = getObj!.data!.speciality!;
    companyNameController.text = getObj!.data!.company!;
    phoneNumberController.text = getObj!.data!.phoneNumber.toString();
    emailController.text = getObj!.data!.email!;
    addressController.text = getObj!.data!.address!;
    notifyListeners();
  }

  Future getCrewProfile(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.getCrewProfile(context);
      if (model.success == true) {
        SharedPreference.prefs!.setString(SharedPreference.USER_PROFILE, model.data!.profileImage!);
        SharedPreference.prefs!.setString(SharedPreference.USER_NAME, model.data!.name!);
        getObj = model;
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

  Future updateCrewProfile(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.updateCrewProfile(
        context,
        email: emailController.text,
        address: addressController.text,
        name: nameController.text,
        profile: profileImage,
        speciality: specialityController.text,
        phone: phoneNumberController.text,
        title: titleController.text,
        company: companyNameController.text,
        imageChanged: imageChanged,
      );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pop(
          context,
        );
        DialogHelper.showMessage(context, model.message!);
      } else {
        setState(ViewState.idle);
        DialogHelper.showMessage(context, model.message!);
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
