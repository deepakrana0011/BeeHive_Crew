import 'package:beehive/provider/base_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class AddCrewPageManagerProvider extends BaseProvider{


  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share("Beehive Network",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }




}