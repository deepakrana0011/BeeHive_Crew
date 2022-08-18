import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CertificationPageProviderManager extends BaseProvider{
  String profileImage = " ";
  removePhoto(){
    profileImage = " ";
    notifyListeners();

  }

  Future addProfilePic(BuildContext context, int modes) async {
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





}