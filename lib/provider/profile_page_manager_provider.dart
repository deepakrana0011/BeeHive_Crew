import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/provider/base_provider.dart';
import 'package:beehive/views_manager/profile_manager/edit_profile_page_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/route_constants.dart';

class ProfilePageManagerProvider extends BaseProvider {
  String profileImage = "";
  String companyIcon = "";
  Color pickerColor = const Color(0xff443a49);
  HSVColor currentColor = HSVColor.fromColor(ColorConstants.blueGradient1Color);
  updateColor(HSVColor color) {
    currentColor = color;
    notifyListeners();
  }

  bool status = false;
  void updateSwitcherStatus(bool value) {
    status = value;
    notifyListeners();
  }

  getDataFromEditProfileScreen(BuildContext context) async {
    HSVColor result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditProfilePageManager()));
    currentColor = result;
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
}
