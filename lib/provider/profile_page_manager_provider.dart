import 'dart:io';

import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/helper/shared_prefs.dart';
import 'package:beehive/model/get_profile_response_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/profile_manager/edit_profile_page_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/route_constants.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ProfilePageManagerProvider extends BaseProvider {
  String profileImage = "";
  String companyIcon = "";
  bool isImageChanged = false;
  bool isCompanyLogo = false;
  updateImageChanged(){
    isImageChanged = !isImageChanged;
    notifyListeners();
  }
  updateCompanyLogoChanged(){
    isCompanyLogo = !isCompanyLogo;
    notifyListeners();
  }

  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  double hColor =0;
  double sColor = 0;
  double vColor = 0;


  HSVColor currentColor = HSVColor.fromColor(ColorConstants.blueGradient1Color);
  updateColor(HSVColor color) {
    currentColor = color;
    hColor = color.hue;
    sColor = color.saturation;
    vColor = color.value;
    notifyListeners();
  }

  bool status = false;
  void updateSwitcherStatus(bool value) {
    status = value;
    notifyListeners();
  }

 Future getDataFromEditProfileScreen(BuildContext context) async {
    HSVColor result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePageManager()));
    currentColor = result;
    notifyListeners();
  }
  Color? colorOfApp;


  setEditProfilePageController() {
    profileImage =
        ApiConstantsCrew.BASE_URL_IMAGE + profileResponse!.data!.profileImage!;
    companyIcon =
        ApiConstantsCrew.BASE_URL_IMAGE + profileResponse!.data!.companyLogo!;
    nameController.text = profileResponse!.data!.name!;
    titleController.text = profileResponse!.data!.title!;
    companyController.text = profileResponse!.data!.company!;
    phoneController.text = profileResponse!.data!.phoneNumber!.toString();
    emailController.text = profileResponse!.data!.email!;
    addressController.text = profileResponse!.data!.address!;
    notifyListeners();
  }

  /// This is used for get the user image and set these images to the profile and icon here te the number profileOrCompanyIcon is used to identify weather it is for profile or Icon
  Future addProfilePic(
      BuildContext context, int modes, int profileOrCompanyIcon) async {
    final picker = ImagePicker();
    Navigator.pop(context);
    if (modes == 1) {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        addImage(pickedImage, profileOrCompanyIcon);
      }
    } else {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        addImage(pickedImage, profileOrCompanyIcon);
      }
    }
  }

  addImage(XFile image, int profileOrCompanyIcon) {
    if (profileOrCompanyIcon == 1) {
      profileImage = image.path.toString();
      notifyListeners();
    } else {
      companyIcon = image.path.toString();
      notifyListeners();
    }
  }

  ///Get profile manager api
  GetManagerProfileResponse? profileResponse;
  Future getManagerProfile(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.getManagerProfile(context);
      if (model.success == true) {
        profileResponse = model;
        SharedPreference.prefs!.setString(SharedPreference.USER_LOGO, model.data!.companyLogo!);
        SharedPreference.prefs!.setString(SharedPreference.USER_NAME, model.data!.name!);
        SharedPreference.prefs!.setString(SharedPreference.USER_PROFILE, model.data!.profileImage!);
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

  Future updateProfileManager(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.updateManagerProfile(context,
          email: emailController.text,
          address: addressController.text,
          phone: phoneController.text,
          title: titleController.text,
          companyLogoChanged: companyIcon,
          company: companyController.text,
          imageChanged: isImageChanged,
          name: nameController.text,
          profile: profileImage, color: currentColor, companyChanged: isCompanyLogo);
      if (model.success == true) {
        setState(ViewState.idle);
          Navigator.pop(context,currentColor);
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
