import 'dart:io';
import 'package:beehive/constants/api_constants.dart';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/model/get_profile_response_manager.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class ProfilePageManagerProvider extends BaseProvider {
  String profileImage = "";
  String companyIcon = "";
  bool isImageChanged = false;
  bool isCompanyLogo = false;
  bool _updateLoader = false;

  bool get updateLoader => _updateLoader;

  set updateLoader(bool value) {
    _updateLoader = value;
    notifyListeners();
  }

  /*updateImageChanged(){
    isImageChanged = !isImageChanged;
    notifyListeners();
  }
  updateCompanyLogoChanged(){
    isCompanyLogo = !isCompanyLogo;
    notifyListeners();
  }*/

  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  double hColor = 0;
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

  Color? colorOfApp;

  setEditProfilePageController() {
    profileImage = profileResponse!.data!.profileImage == null
        ? ""
        : ApiConstantsCrew.BASE_URL_IMAGE +
            profileResponse!.data!.profileImage!;
    companyIcon = profileResponse!.data!.companyLogo == null
        ? ""
        : ApiConstantsCrew.BASE_URL_IMAGE + profileResponse!.data!.companyLogo!;
    nameController.text =
        profileResponse!.data!.name == null ? "" : profileResponse!.data!.name!;
    titleController.text = profileResponse!.data!.title == null
        ? ""
        : profileResponse!.data!.title!;
    companyController.text = profileResponse!.data!.company == null
        ? ""
        : profileResponse!.data!.company!;
    phoneController.text = profileResponse!.data!.phoneNumber == null
        ? ""
        : profileResponse!.data!.phoneNumber!.toString();
    emailController.text = profileResponse!.data!.email == null
        ? ""
        : profileResponse!.data!.email!;
    addressController.text = profileResponse!.data!.address == null
        ? ""
        : profileResponse!.data!.address!;
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
      profileImage = "";
      profileImage = image.path.toString();
      isImageChanged = !isImageChanged;
      notifyListeners();
    } else {
      companyIcon = "";
      companyIcon = image.path.toString();
      isCompanyLogo = !isCompanyLogo;
      notifyListeners();
    }
  }

  ///Get profile manager api
  GetManagerProfileResponse? profileResponse;

  Future<GetManagerProfileResponse?> getManagerProfile(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    try {
      var model = await api.getManagerProfile(context);
      if (model.success == true) {
        profileResponse = model;
        /* SharedPreference.prefs!.setString(SharedPreference.USER_LOGO, model.data!.companyLogo == null? "" : model.data!.companyLogo!);
        SharedPreference.prefs!.setString(SharedPreference.USER_NAME, model.data!.name == null? "" :model.data!.name! );
        SharedPreference.prefs!.setString(SharedPreference.USER_PROFILE, model.data!.profileImage== null? "" :model.data!.profileImage!);
        SharedPreference.prefs!.setString(SharedPreference.COLORFORDRAWER , model.data!.profileImage== null? "" :model.data!.customColor!);*/
        setState(ViewState.idle);
        return model;
      } else {
        setState(ViewState.idle);
        return model;
      }
    } on FetchDataException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      setState(ViewState.idle);
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
    return null;
  }

  /// update manager profile
  Future updateProfileManager(
    BuildContext context,
  ) async {
    updateLoader = true;
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
          profile: profileImage,
          color: currentColor.toColor().toString().substring(6, 16),
          companyChanged: isCompanyLogo);
      updateLoader = false;
      if (model.success == true) {
        Navigator.pop(context);
      }
    } on FetchDataException catch (e) {
      updateLoader=false;
      DialogHelper.showMessage(context, e.toString());
    } on SocketException catch (e) {
      updateLoader=false;
      DialogHelper.showMessage(context, "internet_connection".tr());
    }
  }
}
