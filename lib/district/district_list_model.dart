// To parse this JSON data, do
//
//     final districtListModel = districtListModelFromJson(jsonString);

import 'dart:convert';

DistrictListModel districtListModelFromJson(String str) => DistrictListModel.fromJson(json.decode(str));

String districtListModelToJson(DistrictListModel data) => json.encode(data.toJson());

class DistrictListModel {
  DistrictListModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Datum> data;

  factory DistrictListModel.fromJson(Map<String, dynamic> json) => DistrictListModel(
    status: json["status"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.dstctEnglish,
    required this.id,
  });

  String dstctEnglish;
  int id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    dstctEnglish: json["dstctEnglish"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "dstctEnglish": dstctEnglish,
    "id": id,
  };
}
