import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'main.dart';

class LocaleCont extends GetxController {

  // bool isSwitched = prefs.getBool("isSwitched")!;
  Locale locale = Locale('en', "US");         // Locale("ta", 'TA');
  Locale locale2 =Locale("ta", 'IN');         // Locale("ta", 'TA');
  updateLocale(Locale a) {
    locale = a;
    update();
  }
}
