import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CertificationPageProvider extends BaseProvider {
  String profileImage = " ";
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
