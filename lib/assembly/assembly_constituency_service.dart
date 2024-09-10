import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/url_constants.dart';
import 'assembly_constituency_list_model.dart';



class AssemblyService{
  static getAssemblyTotalListByDistrict(int districtId) async {
    String getAssemblyListByDistrictUrl = CONST_ASSEMBLY_LIST_BY_DISTRICTID_URL;
    http.Response response = await http.post(
      Uri.parse("$getAssemblyListByDistrictUrl/$districtId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      CAssemblyListModel cAssembly =CAssemblyListModel.fromJson(jsonDecode(response.body));
      List<CAssemblyDatum> cAssemblyList = cAssembly.cAssemblyData;
      return cAssemblyList;
    } else {
      return [];
    }
  }
}