import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tvk_maanadu/state/state_list_master_model.dart';
import '../state/state_master_model.dart' as sMD;
import '../state/state_model.dart';

import '../../../constants/url_constants.dart';
import '../main.dart';
class StateService {
  static String stateFilteredListForModelUrl = STATE_FILTERED_lIST_FOR_MODEL_URL;
  static String getStateByIdUrl = STATE_BY_ID_URL;
  static String stateListListUrl = STATE_lIST_URL;
  static String stateListUrl = STATE_LIST_URL;


  static getStateListForModel(int row, int pageNo, searchText) async {
    http.Response response = await http.post(
      Uri.parse(
          "${stateFilteredListForModelUrl}?size=${row}&page=${pageNo}&title=${searchText}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      StateListMaster _state = StateListMaster.fromJson(
          jsonDecode(response.body));
      // List<StateList> stateList = _state.stateList;
      return _state;
    } else {
      return [];
    }
  }

  static getStateList() async {
    http.Response response = await http.post(
      Uri.parse(stateListListUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      StateListMaster _state = StateListMaster.fromJson(
          jsonDecode(response.body));
      return _state;
    } else {
      return [];
    }
  }


  static stateDataByIdService(int id) async {
    late http.Response response;
    response = await http.post(Uri.parse("${getStateByIdUrl}/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      sMD.StateMaster StateMaster = sMD.StateMaster.fromJson(
          jsonDecode(response.body));
      sMD.Data? stateMasterData = StateMaster.data;
      return stateMasterData;
    } else {
      return {};
    }
  }

  static getStateListForModelForRegion() async {
    http.Response response = await http.post(
      Uri.parse("${stateFilteredListForModelUrl}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      StateListMaster _state = StateListMaster.fromJson(
          jsonDecode(response.body));
      // List<StateList> stateList = _state.stateList;
      return _state;
    } else {
      return [];
    }
  }

  static getStateListFromBackEnd() async {
    http.Response response = await http.post(Uri.parse(stateListUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      });

    if (response.statusCode == 200) {
      StateModeList stateListData =
      StateModeList.fromJson(jsonDecode(response.body));
      List<StateDatum> stateList = stateListData.stateData;
      return stateList;
    } else {
      return [];
    }
  }


  static getStateListFromBackEnd_tweedle() async {
    // final response = await http
    //     .get(Uri.parse('$stateListUrl?tweedleEntry=true'));
    http.Response response = await http.post(
        Uri.parse('$stateListUrl?tweedleEntry=true'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      });

    if (response.statusCode == 200) {
      StateModeList stateListData =
      StateModeList.fromJson(jsonDecode(response.body));
      List<StateDatum> stateList = stateListData.stateData;
      return stateList;
    } else {
      return [];
    }
  }

}