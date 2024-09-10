
import 'dart:convert';
import 'dart:io'as io;
import 'dart:io';
import 'package:tvk_maanadu/Conference/ConferenceFIrebaseModel.dart';
import "package:universal_html/html.dart"as html;
import '../Conference/ConferenceListModel.dart' as consLst;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/url_constants.dart';
import "package:http/http.dart" as http;

import '../main.dart';
import '../Toast_message/toast_message.dart';
import 'ConferenceModel.dart' as conDatum;
import 'AssemblyWiseCount.dart'as ASC;

class ConferenceService{

  final String saveConferenceUrl = SAVE_CONFERENCE_URL;
  final String findAllConferenceUrl = FINDALL_CONFERENCE_URL;
  final String saveMemberConferenceUrl = SAVE_SCAN_MEMBER_CONFERENCE_URL;

  static String findOneConferenceUrl = FIND_ONE_CONFERENCE_URL;
  final String updateMemberConferenceUrl = UPDATE_SCAN_MEMBER_CONFERENCE_URL;
  final String firebaseRefreshConferenceUrl = FIREBASE_REFRESH_CONFERENCE_URL;
  static String assemblyWiseConferenceUrl = ASSEMBLY_WISECONFERENCE_URL;

  static String findOneCardConferenceUrl = FIND_ONE_CARD_CONFERENCE_URL;
  static String assemblyWiseCardScanConferenceUrl = ASSEMBLY_WISECONFERENCE_CARDSCAN_URL;
  final String saveCardScanConferenceUrl = SAVE_CARD_SCAN_MEMBER_CONFERENCE_URL;
  final String updateCardScanMemberConferenceUrl = UPDATE_CARD_SCAN_MEMBER_CONFERENCE_URL;
  final String imageGenerateConferenceUrl = CONFERENCE_GENERATEIMAGE;

  Future<dynamic> saveConference(Map<String, dynamic> jsonData, FToast fToast) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(saveConferenceUrl), // Adjust endpoint as needed
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        showSuccessToast(responseData["message"], fToast);
        return true;
      } else {
        throw Exception('Failed to save attendances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to save attendances');
    }
  }


  // Future<consLst.ConferenceListModel>
   findAllConference(int row, int pageNo,String searchText ) async {
    http.Response response = await http.post(
      Uri.parse("${findAllConferenceUrl}?size=${row}&page=${pageNo}&title=${searchText}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // "x-access-token": token
      },
    );

    if (response.statusCode == 200) {
      consLst.ConferenceListModel stdLst = consLst.ConferenceListModel.fromJson(jsonDecode(response.body));
      return stdLst;
    } else {
      throw Exception('Failed to save attendances: ${response.statusCode}');
    }
  }

  Future<dynamic> saveScanMember(Map<String, dynamic> jsonData, FToast fToast,) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(saveMemberConferenceUrl), // Adjust endpoint as needed
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData["message"];
      } else {
        throw Exception('Failed to save attendances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to save attendances');
    }
  }

  Future<dynamic> saveScanCardMember(Map<String, dynamic> jsonData, FToast fToast,) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(saveCardScanConferenceUrl), // Adjust endpoint as needed
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData["message"];
      } else {
        throw Exception('Failed to save attendances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to save attendances');
    }
  }

  static getConferenceData(conferenceID) async {
    try {
      final response = await http.post(
        Uri.parse(findOneConferenceUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token,
        },
        body: jsonEncode(<String, dynamic>{
          'id': conferenceID.toString(),
        }),
      );

      if (response.statusCode == 200) {
        ConferenceFirebaseModel singleConferenceLst = ConferenceFirebaseModel.fromJson(jsonDecode(response.body));
        // conDatum.ConferenceModel singleConferenceLst = conDatum.ConferenceModel.fromJson(jsonDecode(response.body));
        // conDatum.Data confData = singleConferenceLst.data;
        return singleConferenceLst;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  static getCardConferenceData(conferenceID) async {
    try {
      final response = await http.post(
        Uri.parse(findOneCardConferenceUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token,
        },
        body: jsonEncode(<String, dynamic>{
          'id': conferenceID.toString(),
        }),
      );

      if (response.statusCode == 200) {
        ConferenceFirebaseModel singleConferenceLst = ConferenceFirebaseModel.fromJson(jsonDecode(response.body));
        // conDatum.ConferenceModel singleConferenceLst = conDatum.ConferenceModel.fromJson(jsonDecode(response.body));
        // conDatum.Data confData = singleConferenceLst.data;
        return singleConferenceLst;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }


  Future<dynamic> updateOtherMember(Map<String, dynamic> jsonData, FToast fToast, int conferenceId) async {
    try {
      final Map<String, dynamic> data = {
        'conference_id': conferenceId,
        'updateData': jsonData,
      };
      final http.Response response = await http.post(
        Uri.parse(updateMemberConferenceUrl), // Adjust endpoint as needed
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // showSuccessToast(responseData["message"], fToast);
        return true;
      } else {
        throw Exception('Failed to save attendances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to save attendances');
    }
  }

  Future<dynamic> updateScanCardMember(Map<String, dynamic> jsonData, FToast fToast, int conferenceId) async {
    try {
      final Map<String, dynamic> data = {
        'conference_id': conferenceId,
        'updateData': jsonData,
      };
      final http.Response response = await http.post(
        Uri.parse(updateCardScanMemberConferenceUrl), // Adjust endpoint as needed
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // showSuccessToast(responseData["message"], fToast);
        return true;
      } else {
        throw Exception('Failed to save attendances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to save attendances');
    }
  }

  Future<dynamic> refreshConference(Map<String, dynamic> jsonData, FToast fToast,) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(firebaseRefreshConferenceUrl), // Adjust endpoint as needed
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // return responseData["message"];
        return true;
      } else {
        throw Exception('Failed to save attendances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to save attendances');
    }
  }

  Future<List<ASC.Datum>> assemblyWiseCount(Map<String, dynamic> jsonData) async {
    try {
      final response = await http.post(
        Uri.parse(assemblyWiseConferenceUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token,
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        ASC.AssemblyWiseCount assemblyWiseCount =ASC.AssemblyWiseCount.fromJson(jsonDecode(response.body));
        List<ASC.Datum> assemblyCount = assemblyWiseCount.data!;

        // ConferenceFirebaseModel singleConferenceLst = ConferenceFirebaseModel.fromJson(jsonDecode(response.body));
        // conDatum.ConferenceModel singleConferenceLst = conDatum.ConferenceModel.fromJson(jsonDecode(response.body));
        // conDatum.Data confData = singleConferenceLst.data;
        return assemblyCount;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<ASC.Datum>> assemblyWiseCountCardScan(Map<String, dynamic> jsonData) async {
    try {
      final response = await http.post(
        Uri.parse(assemblyWiseCardScanConferenceUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token,
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        ASC.AssemblyWiseCount assemblyWiseCount =ASC.AssemblyWiseCount.fromJson(jsonDecode(response.body));
        List<ASC.Datum> assemblyCount = assemblyWiseCount.data!;

        // ConferenceFirebaseModel singleConferenceLst = ConferenceFirebaseModel.fromJson(jsonDecode(response.body));
        // conDatum.ConferenceModel singleConferenceLst = conDatum.ConferenceModel.fromJson(jsonDecode(response.body));
        // conDatum.Data confData = singleConferenceLst.data;
        return assemblyCount;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<void> generateImage(Map<String, dynamic> jsonData, FToast fToast, Map<String, dynamic> cardValue) async {
    Map<String, dynamic> jsonbody = {
      'bodyValues': jsonData,
      'cardValue': cardValue,
    };
    final response = await http.post(
      Uri.parse(imageGenerateConferenceUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonbody),
    );

    // final http.Response r = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      Uint8List fileBytes = response.bodyBytes;
      var now = DateTime.now();
      var formattedDate = "${now.hour}${now.minute}${now.second}";

      if (kIsWeb) {
        final blob = html.Blob([fileBytes], 'application/pdf'); // Set MIME type for PDF
        final url = html.Url.createObjectUrl(blob);

        final anchorElement = html.AnchorElement(href: url)
          ..setAttribute('download', 'GeneratedDocument-${formattedDate}.pdf') // Change file extension to .pdf
          ..click();

        // Clean up the object URL
        await Future.delayed(Duration(seconds: 1));
        anchorElement.remove();
        html.Url.revokeObjectUrl(url);
      } else {
        try {
          if (io.Platform.isAndroid) {
            final directory = await getExternalStorageDirectory();
            final downloadDirectory = Directory('${directory!.path}/Download');

            if (!await downloadDirectory.exists()) {
              await downloadDirectory.create(recursive: true);
            }

            final filePath = '${downloadDirectory.path}/GeneratedImage-${formattedDate}.pdf';
            final file = File(filePath);
            await file.writeAsBytes(fileBytes);

            print("File saved at ${filePath}");
          } else {
            // Handle iOS or other platforms
            final directory = await getTemporaryDirectory();
            final filePath = '${directory.path}/GeneratedImage-${formattedDate}.png';
            io.File(filePath).writeAsBytesSync(fileBytes);
            showSuccessToast(
              "File saved at Temporary directory as GeneratedImage-${formattedDate}.png",
              fToast,
            );
          }
        } catch (e) {
          print("Error saving file: $e");
          showSuccessToast("Failed to save file", fToast);
        }
      }
    } else {
      showSuccessToast(
        "File does not download properly",
        fToast,
      );
    }
  }
}
