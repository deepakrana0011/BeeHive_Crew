import 'package:beehive/provider/base_provider.dart';

class DrawerManagerProvider extends BaseProvider {
  String? _managerName;
  String? _managerProfilePic;
  String? _companyLogo;

  String get managerName => _managerName ?? "";

  String get managerProfilePic => _managerProfilePic ?? "";

  String get companyLogo => _companyLogo ?? "";

  void updateDrawerData(String name, String profilePic, String companyLogo) {
    _companyLogo = companyLogo;
    _managerProfilePic = profilePic;
    _managerName = name;
    customNotify();
  }
}
