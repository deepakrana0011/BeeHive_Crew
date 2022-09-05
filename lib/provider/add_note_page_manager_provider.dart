import 'dart:io';

import 'package:beehive/provider/base_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../enum/enum.dart';
import '../helper/dialog_helper.dart';
import '../services/fetch_data_expection.dart';

class AddNotePageManagerProvider extends BaseProvider{

  final titleController = TextEditingController();
  final noteController = TextEditingController();


  File? imageFile;
  List<String> allImageList = [];

  Future addPhotos(BuildContext context, int modes) async {
    Navigator.pop(context);
    final picker = ImagePicker();
    if (modes == 1) {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        allImageList.add(imageFile!.path.toString());
        notifyListeners();
      }
    } else {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        allImageList.add(imageFile!.path.toString());
        notifyListeners();
      }
    }
  }
  removeImageFromList(int index) {
    allImageList.removeAt(index);
    notifyListeners();
  }

  Future addNoteManager(BuildContext context,String projectId) async {
    setState(ViewState.busy);
    try {
      var model = await api.addNoteApi(context, image: allImageList, note: noteController.text, title: titleController.text, assignProjectId: projectId, );
      if (model.success == true) {
        setState(ViewState.idle);
        Navigator.pop(context);
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