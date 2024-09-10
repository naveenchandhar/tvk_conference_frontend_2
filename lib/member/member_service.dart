import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/url_constants.dart';
import '../main.dart';
import 'member_data_model.dart';
import 'member_list_model.dart';
// import 'member_model.dart';

class MemberService {
  static String memberListUrl = MEMBER_LIST_URL;
  static String filteredMemberListUrl = FILTERED_MEMBER_URL;
  static String updateMemberRoleUrl = MEMBER_ROLE_UPDATE_URL;
  static String adminMemberListUrl = ADMIN_MEMBER_LIST_URL;
  static String memberListByIdUrl = MEMBER_BY_ID_URL;

  static getMemberListFromBackEnd(
      row,
      pageNo,
      String stateId,
      String districtId,
      String searchText,
      String parlimentId,
      String assemblyId) async {
    http.Response response = await http.post(
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
      Uri.parse(
          "$memberListUrl?size=$row&page=$pageNo&title=${searchText}&stateFilter=${stateId}&districtFilter=${districtId}&parlimentFilter=${parlimentId}&assemblyFilter=${assemblyId}"),
    );

    if (response.statusCode == 200) {
      MemberModelList memberListData =
          MemberModelList.fromJson(jsonDecode(response.body));
      return memberListData;
    } else {
      return [];
    }
  }

// Member list filtered by state and district

  static getFilteredMemberList(districtId) async {
    Map<String, dynamic> requestData = {
      // 'stateId': stateId,
      'districtId': districtId,
    };
    http.Response response = await http.post(
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
      Uri.parse(filteredMemberListUrl), // Constructing URI correctly
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      FilteredMemberModel filteredData =
          FilteredMemberModel.fromJson(jsonDecode(response.body));
      List<FilteredMemberDatum>? FilteredMemberList =
          filteredData.filteredMember.filteredMemberData;
      return FilteredMemberList;
    } else {
      return [];
    }
  }

//Member Role Save for Approved member

  static saveMemberRole(memberId, roleID) async {
    Map<String, dynamic> requestData = {
      'memberId': memberId,
      'roleId': roleID,
    };

    http.Response response = await http.post(
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
      Uri.parse(updateMemberRoleUrl),
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // final responseList = json.decode(response.body) as List;
      // final roleList = responseList
      //     .map((colorData) => RoleModeList.fromJson(colorData))
      //     .toList();
      return true;
    } else {
      return false;
    }
  }

  static getMemberListReport(
      String stateId, String districtId, String searchText) async {
    late http.Response response;
    try {
      http.Response response = await http.post(
        Uri.parse(
            "${adminMemberListUrl}?title=${searchText}&stateFilter=${stateId}&districtFilter=${districtId}"),
        //localhost:3000   148.72.215.151:3000
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-access-token": token
        },
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  static getMemberListById(int memberid) async {
    String memberListDataUrl = MEMBER_LIST_DATA_URL;
    http.Response response = await http.post(
      Uri.parse("${memberListDataUrl}/${memberid}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      MemberDataModel memberdata =
          MemberDataModel.fromJson(jsonDecode(response.body));
      return memberdata;
    } else {
      return [];
    }
  }
}
