// To parse this JSON data, do
//
//     final districtModeList = districtModeListFromJson(jsonString);

import 'dart:convert';

DistrictModeList districtModeListFromJson(String str) => DistrictModeList.fromJson(json.decode(str));

String districtModeListToJson(DistrictModeList data) => json.encode(data.toJson());

class DistrictModeList {
  Data? data;

  DistrictModeList({
    this.data,
  });

  factory DistrictModeList.fromJson(Map<String, dynamic> json) => DistrictModeList(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<DistrictList> districtList;

  Data({
    required this.districtList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    districtList: List<DistrictList>.from(json["districtList"].map((x) => DistrictList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "districtList": List<dynamic>.from(districtList.map((x) => x.toJson())),
  };
}

class DistrictList {
  int? id;
  String? dstctEnglish;
  String? dstctTamil;
  int? sortOrder;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? stateId;

  DistrictList({
     this.id,
     this.dstctEnglish,
     this.dstctTamil,
     this.sortOrder,
     this.isDelete,
     this.createdAt,
     this.updatedAt,
     this.stateId,
  });

  factory DistrictList.fromJson(Map<String, dynamic> json) => DistrictList(
    id: json["id"]??0,
    dstctEnglish: json["dstctEnglish"]??"",
    dstctTamil: json["dstctTamil"]??"",
    sortOrder: json["sortOrder"]??"",
    isDelete: json["isDelete"]??"",
    createdAt: DateTime.parse(json["createdAt"]??""),
    updatedAt: DateTime.parse(json["updatedAt"]??""),
    stateId: json["stateId"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dstctEnglish": dstctEnglish,
    "dstctTamil": dstctTamil,
    "sortOrder": sortOrder,
    "isDelete": isDelete,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "stateId": stateId,
  };
}
