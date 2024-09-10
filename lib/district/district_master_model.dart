// To parse this JSON data, do
//
//     final districtMasterModel = districtMasterModelFromJson(jsonString);

import 'dart:convert';

DistrictMasterModel districtMasterModelFromJson(String str) => DistrictMasterModel.fromJson(json.decode(str));

String districtMasterModelToJson(DistrictMasterModel data) => json.encode(data.toJson());

class DistrictMasterModel {
  DistrictMasterModel({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory DistrictMasterModel.fromJson(Map<String, dynamic> json) => DistrictMasterModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    this.stateId,
    this.dstctEnglish,
    this.dstctTamil,
    this.sortOrder,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int? stateId;
  String? dstctEnglish;
  String? dstctTamil;
  int? sortOrder;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    stateId: json["stateId"],
    dstctEnglish: json["dstctEnglish"],
    dstctTamil: json["dstctTamil"],
    sortOrder: json["sortOrder"],
    isDelete: json["isDelete"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
