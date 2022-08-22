import 'package:beehive/provider/base_provider.dart';

class OtpPageProvider extends BaseProvider{
  String otp= "";

  updateProvider(String value){

    otp = value;
    notifyListeners();

  }








}