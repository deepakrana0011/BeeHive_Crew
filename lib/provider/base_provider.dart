import 'package:beehive/enum/enum.dart';
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  bool _isDisposed = false;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    if (!_isDisposed) {
      notifyListeners();
    }
  }




  bool loading = false;

  updateLoadingStatus(bool val){
    loading = val;
    notifyListeners();
  }

  bool data = false;

  updateData(bool val){
    data = val;
    notifyListeners();
  }


  void customNotify() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }
}
