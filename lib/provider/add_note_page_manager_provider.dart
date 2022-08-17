import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddNotePageManagerProvider extends BaseProvider{


  File? imageFile;
  List<File?> allImageList = [];


  Future addPhotos(BuildContext context, int modes) async {
    Navigator.pop(context);
    final picker = ImagePicker();
    if (modes == 1) {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        allImageList.add(imageFile);
        notifyListeners();
      }
    } else {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        allImageList.add(imageFile);
        notifyListeners();
      }
    }
  }
  removeImageFromList(int index) {
    allImageList.removeAt(index);
    notifyListeners();
  }




}