
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Validator{
  static validateDistrictEnglishName({ required String englishName}) {
    if (englishName == null) {
      return null;
    }

    if (englishName.isEmpty) {
      return 'Please_enter_English_Name'.tr;
    }

    return null;
  }

  static validateDistrictTamilName({ required String tamilName}) {
    if (tamilName == null) {
      return null;
    }

    if (tamilName.isEmpty) {
      return 'Please_enter_Tamil_Name'.tr;
    }

    return null;
  }
}