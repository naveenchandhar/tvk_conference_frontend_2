// To parse this JSON data, do
//
//     final cAssemblyListModel = cAssemblyListModelFromJson(jsonString);

import 'dart:convert';

CAssemblyListModel cAssemblyListModelFromJson(String str) => CAssemblyListModel.fromJson(json.decode(str));

String cAssemblyListModelToJson(CAssemblyListModel data) => json.encode(data.toJson());

class CAssemblyListModel {
  String status;
  List<CAssemblyDatum> cAssemblyData;

  CAssemblyListModel({
    required this.status,
    required this.cAssemblyData,
  });

  factory CAssemblyListModel.fromJson(Map<String, dynamic> json) => CAssemblyListModel(
    status: json["status"],
    cAssemblyData: List<CAssemblyDatum>.from(json["cAssemblyData"].map((x) => CAssemblyDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "cAssemblyData": List<dynamic>.from(cAssemblyData.map((x) => x.toJson())),
  };
}

class CAssemblyDatum {
  String? english;
  int? id;

  CAssemblyDatum({
    this.english,
    this.id,
  });

  factory CAssemblyDatum.fromJson(Map<String, dynamic> json) => CAssemblyDatum(
    english: json["English"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "English": english,
    "id": id,
  };
}
