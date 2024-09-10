// To parse this JSON data, do
//
//     final districtListMasterModel = districtListMasterModelFromJson(jsonString);

import 'dart:convert';

DistrictListMasterModel districtListMasterModelFromJson(String str) => DistrictListMasterModel.fromJson(json.decode(str));

String districtListMasterModelToJson(DistrictListMasterModel data) => json.encode(data.toJson());

class DistrictListMasterModel {
  DistrictListMasterModel({
    this.totalElements,
    required this.districtList,
    this.totalPages,
    this.pageNumber,
  });

  int? totalElements;
  List<DistrictList> districtList;
  int? totalPages;
  int? pageNumber;

  factory DistrictListMasterModel.fromJson(Map<String, dynamic> json) => DistrictListMasterModel(
    totalElements: json["totalElements"],
    districtList: List<DistrictList>.from(json["districtList"].map((x) => DistrictList.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "totalElements": totalElements,
    "districtList": List<dynamic>.from(districtList.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class DistrictList {
  DistrictList({
    required this.id,
    required this.stateId,
    required this.dstctEnglish,
    required this.dstctTamil,
    this.sortOrder,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.mstState,
  });

  int id;
  int stateId;
  String dstctEnglish;
  String dstctTamil;
  int? sortOrder;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;
  MstState? mstState;

  factory DistrictList.fromJson(Map<String, dynamic> json) => DistrictList(
    id: json["id"],
    stateId: json["stateId"],
    dstctEnglish: json["dstctEnglish"],
    dstctTamil: json["dstctTamil"],
    sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
    isDelete: json["isDelete"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    mstState: MstState.fromJson(json["mst_state"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateId": stateId,
    "dstctEnglish": dstctEnglish,
    "dstctTamil": dstctTamil,
    "sortOrder": sortOrder == null ? null : sortOrder,
    "isDelete": isDelete,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "mst_state": mstState?.toJson(),
  };
}

class MstState {
  MstState({
    this.id,
    this.english,
    this.tamil,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? english;
  String? tamil;
  int? countryId;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MstState.fromJson(Map<String, dynamic> json) => MstState(
    id: json["id"],
    english: json["English"],
    tamil:json["Tamil"],
    isDelete: json["isDelete"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "English": english,
    "Tamil": tamil,
    "isDelete": isDelete,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}



