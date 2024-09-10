import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../json_serialization/error_model.dart' as errorFile;
import '../state/state_delete_master.dart' as SuccessFile;
import 'district_list_master_model.dart';
import 'district_master_model.dart';
import '../Toast_message/toast_message.dart';

import '../../../constants/url_constants.dart';
import '../../../main.dart';
import 'district_list_model.dart';

import 'district_master_model.dart' as dMD;
import 'district_list_model.dart' as dld;
import 'district_master_model.dart';
import 'district_model.dart'as dm;

class DistrictService{
  static String districtListForModelUrl = DISTRICT_LIST_FOR_MODEL_URL;
  static String districtListForTotalModelUrl = DISTRICT_LIST_FOR_TOTAL_MODEL_URL;
   static String districtFilteredListUrl = DISTRICT_FILTERED_LIST_URL;
   static String districtSaveUrl = DISTRICT_SAVE_URL;
   static String districtDeleteUrl = DISTRICT_DELETE_URL;
   static String findDistrictByIdUrl = FIND_DISTRICT_BY_ID;
   static String districtListUrl = DISTRICT_LIST_URL;
   static String districtByIdUrl = DISTRICT_BY_ID_URL;
   static String districtUpdateUrl = DISTRICT_UPDATE_URL;
  static String districtFindAllUrl = DISTRICT_FINDALL_URL;
  static String districtListForState = DISTRICT_FOR_STATE;


  static getDistrictList(int stateId) async {
    http.Response response = await http.post(
      Uri.parse("$districtListUrl/${stateId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      dld.DistrictListModel _district =dld.DistrictListModel.fromJson(jsonDecode(response.body));
      List<dld.Datum> districtList = _district.data;
      return districtList;
    } else {
      return [];
    }
  }

  static getDistrictListForModel(int row, int pageNo, String stateId,searchText, ) async {
    http.Response response = await http.post(
      Uri.parse("${districtFilteredListUrl}?size=${row}&page=${pageNo}&title=${searchText}&stateFilter=${stateId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      DistrictListMasterModel _state =DistrictListMasterModel.fromJson(jsonDecode(response.body));
      // List<StateList> stateList = _state.stateList;
      return _state;
    } else {
      return [];
    }

  }




  static districtSaveService(data, FToast fToast) async {
    late http.Response response;
    try{
      //String token = box.read('token');
      response = await http.post(Uri.parse(districtSaveUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "x-access-token": token
          },
          body: data);
      if (response.statusCode == 200) {
        errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
        showSuccessToast(err.message.toString(),fToast);
        return true;
      } else {
        errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
        showFailureToast(err.message.toString(),fToast);
        return false;
      }

    } catch (e) {
      errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
      showFailureToast(err.message.toString(),fToast);
      return false;
    }

  }




  static districtUpdateService(data, FToast fToast, int id) async {
    late http.Response response;
    try{
      // String token = box.read('token');
      response = await http.put(Uri.parse("${districtUpdateUrl}/${id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "x-access-token": token
          },
          body: data);

      if (response.statusCode == 200) {
        SuccessFile.StateDeleteMaster del =SuccessFile.StateDeleteMaster.fromJson(json.decode(response.body));
        showSuccessToast(del.message.toString(),fToast);

        return true;
      } else {
        return {};
      }
    }catch (e) {
      SuccessFile.StateDeleteMaster del =SuccessFile.StateDeleteMaster.fromJson(json.decode(response.body));
      showFailureToast(del.message.toString(),fToast);
      return null;
    }

  }




  static districtDeleteService(int id, FToast fToast) async {

    late http.Response response;
    try{
      //String token = box.read('token');
      response = await http.delete(Uri.parse("${districtDeleteUrl}/${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-access-token": token
        },
      );

      if (response.statusCode == 200) {
        SuccessFile.StateDeleteMaster del =SuccessFile.StateDeleteMaster.fromJson(json.decode(response.body));
        showSuccessToast(del.message.toString(),fToast);
        return true;
      } else {
        return {};
      }
    }catch (e) {
      errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
      showFailureToast(err.message.toString(),fToast);
      return null;
    }
  }


  static districtDataByIdService(id) async{
    http.Response response = await http.post(
      Uri.parse("${findDistrictByIdUrl}/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );
    if (response.statusCode == 200) {
      dMD.DistrictMasterModel districtMaster =dMD.DistrictMasterModel.fromJson(jsonDecode(response.body));
      dMD.Data districtMasterData= districtMaster.data;
      return districtMasterData;
    } else {
      return [];
    }
  }

  static getDistrictListByState(FToast fToast, String stateId, String searchText) async {
   // String token = box.read('token');
    http.Response response = await http.post(
      Uri.parse("${districtFilteredListUrl}?size=300&page=0&title=${searchText}&stateFilter=${stateId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      DistrictListMasterModel _state =DistrictListMasterModel.fromJson(jsonDecode(response.body));
      List<DistrictList> districtList = _state.districtList;
      return districtList;
    } else {
      return [];
    }
  }

  static getStateList(FToast fToast, String stateId, String searchText) async {
    // String token = box.read('token');
    http.Response response = await http.post(
      Uri.parse("${districtFilteredListUrl}?size=300&page=0&title=${searchText}&stateFilter=${stateId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      DistrictListMasterModel _state =DistrictListMasterModel.fromJson(jsonDecode(response.body));
      List<DistrictList> districtList = _state.districtList;
      return districtList;
    } else {
      return [];
    }
  }

  static getDistrictListFromBackEnd() async {
    http.Response response = await http.post(Uri.parse(districtFindAllUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-access-token": token
        });

    if (response.statusCode == 200) {
      dm.DistrictModeList districtListData =
      dm.DistrictModeList.fromJson(jsonDecode(response.body));
      List<dm.DistrictList>? districtList = districtListData.data?.districtList;
      return districtList;
    } else {
      return [];
    }
  }
  static getDistrictForState (state) async{

    http.Response response = await http.post(Uri.parse("$districtListForState/$state"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "x-access-token": token
      });

    if (response.statusCode == 200) {
      dm.DistrictModeList districtListData =
      dm.DistrictModeList.fromJson(jsonDecode(response.body));
      List<dm.DistrictList> districtList = districtListData.data!.districtList;
      return districtList;
    } else {
      return [];
    }
  }


  // static districtSaveService(data, FToast fToast) async {
  //
  //   late http.Response response;
  //   try{
  //     String token = box.read('token');
  //     response = await http.post(Uri.parse(districtSaveUrl),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           "x-access-token": token
  //         },
  //         body: data);
  //     if (response.statusCode == 200) {
  //       errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
  //       showSuccessToast(err.message.toString(),fToast);
  //       return true;
  //     } else {
  //       return null;
  //     }
  //
  //   } catch (e) {
  //     errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
  //     showFailureToast(err.message.toString(),fToast);
  //     return null;
  //   }
  //
  // }
  //
  // static districtDeleteService(int id, FToast fToast) async {
  //   late http.Response response;
  //   try{
  //     String token = box.read('token');
  //     response = await http.get(Uri.parse("${districtDeleteUrl}/${id}"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "x-access-token": token
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
  //       showSuccessToast(err.message.toString(),fToast);
  //       return true;
  //     } else {
  //       return {};
  //     }
  //   }catch (e) {
  //     errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
  //     showSuccessToast(err.message.toString(),fToast);
  //     return null;
  //   }
  // }
  //
  // static districtDataByIdService(int id) async {
  //   late http.Response response;
  //   response = await http.get(Uri.parse("${districtByIdUrl}/${id}"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       // "x-access-token": token
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     dMD.DistrictMasterModel districtMaster = dMD.DistrictMasterModel.fromJson(jsonDecode(response.body));
  //     dMD.Data districtMasterData=districtMaster.data;
  //     return districtMasterData;
  //   } else {
  //     return {};
  //   }
  //
  // }
  //
  // static districtUpdateService(data, FToast fToast, int id) async {
  //
  //   late http.Response response;
  //   try{
  //     String token = box.read('token');
  //     response = await http.post(Uri.parse("${districtUpdateUrl}/${id}"),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           "x-access-token": token
  //         },
  //         body: data);
  //
  //     if (response.statusCode == 200) {
  //       SuccessFile.StateDeleteMaster del =SuccessFile.StateDeleteMaster.fromJson(json.decode(response.body));
  //       showSuccessToast(del.message.toString(),fToast);
  //       return true;
  //     } else {
  //       return {};
  //     }
  //   }catch (e) {
  //     SuccessFile.StateDeleteMaster del =SuccessFile.StateDeleteMaster.fromJson(json.decode(response.body));
  //     showFailureToast(del.message.toString(),fToast);
  //     return null;
  //   }
  //
  // }
  //
  // static getDistrictReport(String searchText, int row, int pageNo,String stateId,
  //     String districtId, String regionId, String divisionId, String fromDate, String toDate)  async {
  //   late http.Response response;
  //   try{
  //     String token = box.read('token');
  //     http.Response response = await http.get(
  //       Uri.parse("${districtReportUrl}?size=10&page=0&title=undefined&stateFilter=${stateId}&districtFilter=${districtId}&regionFilter=${regionId}&clubFilter=${divisionId}&fromDate=${fromDate}&toDate=${toDate}"),  //localhost:3000   148.72.215.151:3000
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "x-access-token": token
  //       },
  //     );
  //     return response;
      // response = await http.post(Uri.parse("${stateUpdateUrl}/${id}"),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //       "x-access-token": token
      //     },
      //     body: data);
      // if (response.statusCode == 200) {
      //   errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
      //   showSuccessToast(err.message.toString(),fToast);
      //   return true;
      // } else {
      //   return null;
      // }
  //
  //   } catch (e) {
  //     // errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
  //     // showFailureToast(err.message.toString(),fToast);
  //     return null;
  //   }
  // }

  // static getDistrictReportList(String searchText, int row, int pageNo, String stateId,
  //     String districtId, String regionId, String divisionId, String fromDate, String toDate) async {
  //   late http.Response response;
  //   try{
  //     String token = box.read('token');
  //     http.Response response = await http.get(
  //       Uri.parse("${districtReportListUrl}?size=${row}&page=${pageNo}&title=undefined&stateFilter=${stateId}&districtFilter=${districtId}&regionFilter=${regionId}&clubFilter=${divisionId}&fromDate=${fromDate}&toDate=${toDate}"),  //localhost:3000   148.72.215.151:3000
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "x-access-token": token
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       DistrictReportDataListModel _districtReportData =DistrictReportDataListModel.fromJson(jsonDecode(response.body));
  //       // List<StateList> stateList = _state.stateList;
  //       return _districtReportData;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     // errorFile.ErrorModel err = errorFile.ErrorModel.fromJson(json.decode(response.body));
  //     // showFailureToast(err.message.toString(),fToast);
  //     return null;
  //   }
  // }





}
