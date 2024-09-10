// To parse this JSON data, do
//
//     final conferenceListModel = conferenceListModelFromJson(jsonString);

import 'dart:convert';

ConferenceListModel conferenceListModelFromJson(String str) => ConferenceListModel.fromJson(json.decode(str));

String conferenceListModelToJson(ConferenceListModel data) => json.encode(data.toJson());

class ConferenceListModel {
  int totalElements;
  List<ConferenceList> conferenceList;
  int totalPages;
  int pageNumber;

  ConferenceListModel({
    required this.totalElements,
    required this.conferenceList,
    required this.totalPages,
    required this.pageNumber,
  });

  factory ConferenceListModel.fromJson(Map<String, dynamic> json) => ConferenceListModel(
    totalElements: json["totalElements"],
    conferenceList: List<ConferenceList>.from(json["conferenceList"].map((x) => ConferenceList.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "totalElements": totalElements,
    "conferenceList": List<dynamic>.from(conferenceList.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class ConferenceList {
  int id;
  String name;
  String type;
  DateTime date;
  String startTime;
  int noPeopleAllowed;
  String approvelRequired;
  String venueAddress1;
  String venueAddress2;
  bool isDelete;
  int stateId;
  int districtId;
  int venueStateId;
  int venueDistrictId;
  MstState mstState;
  MstDistrict mstDistrict;

  ConferenceList({
    required this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.startTime,
    required this.noPeopleAllowed,
    required this.approvelRequired,
    required this.venueAddress1,
    required this.venueAddress2,
    required this.isDelete,
    required this.stateId,
    required this.districtId,
    required this.venueStateId,
    required this.venueDistrictId,
    required this.mstState,
    required this.mstDistrict,
  });

  factory ConferenceList.fromJson(Map<String, dynamic> json) => ConferenceList(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    date: DateTime.parse(json["date"]),
    startTime: json["start_time"],
    noPeopleAllowed: json["no_people_allowed"],
    approvelRequired: json["approvel_required"],
    venueAddress1: json["venue_address1"],
    venueAddress2: json["venue_address2"],
    isDelete: json["isDelete"],
    stateId: json["state_id"],
    districtId: json["district_id"],
    venueStateId: json["venue_state_id"],
    venueDistrictId: json["venue_district_id"],
    mstState: MstState.fromJson(json["mst_state"]),
    mstDistrict: MstDistrict.fromJson(json["mst_district"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "no_people_allowed": noPeopleAllowed,
    "approvel_required": approvelRequired,
    "venue_address1": venueAddress1,
    "venue_address2": venueAddress2,
    "isDelete": isDelete,
    "state_id": stateId,
    "district_id": districtId,
    "venue_state_id": venueStateId,
    "venue_district_id": venueDistrictId,
    "mst_state": mstState.toJson(),
    "mst_district": mstDistrict.toJson(),
  };
}

class MstDistrict {
  String dstctEnglish;
  int id;

  MstDistrict({
    required this.dstctEnglish,
    required this.id,
  });

  factory MstDistrict.fromJson(Map<String, dynamic> json) => MstDistrict(
    dstctEnglish: json["dstctEnglish"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "dstctEnglish": dstctEnglish,
    "id": id,
  };
}

class MstState {
  String english;
  int id;

  MstState({
    required this.english,
    required this.id,
  });

  factory MstState.fromJson(Map<String, dynamic> json) => MstState(
    english: json["English"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "English": english,
    "id": id,
  };
}
