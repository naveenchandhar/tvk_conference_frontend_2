// To parse this JSON data, do
//
//     final stateListMaster = stateListMasterFromJson(jsonString);

import 'dart:convert';

StateListMaster stateListMasterFromJson(String str) => StateListMaster.fromJson(json.decode(str));

String stateListMasterToJson(StateListMaster data) => json.encode(data.toJson());

class StateListMaster {
  StateListMaster({
    this.totalElements,
    required this.stateList,
    this.totalPages,
    this.pageNumber,
  });

  int? totalElements;
  List<StateList> stateList;
  int? totalPages;
  int? pageNumber;

  factory StateListMaster.fromJson(Map<String, dynamic> json) => StateListMaster(
    totalElements: json["totalElements"],
    stateList: List<StateList>.from(json["stateList"].map((x) => StateList.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "totalElements": totalElements,
    "stateList": List<dynamic>.from(stateList.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class StateList {
  StateList({
    required this.id,
    required this.english,
    required this.tamil,
    this.countryId,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String english;
  String tamil;
  String? countryId;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
    id: json["id"],
    english: json["English"],
    tamil: json["Tamil"],
    countryId: json["countryId"],
    isDelete: json["isDelete"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "English": english,
    "Tamil": tamil,
    "countryId": countryId,
    "isDelete": isDelete,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
