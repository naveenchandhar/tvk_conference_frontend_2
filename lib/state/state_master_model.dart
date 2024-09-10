// To parse this JSON data, do
//
//     final stateMaster = stateMasterFromJson(jsonString);

import 'dart:convert';

StateMaster stateMasterFromJson(String str) => StateMaster.fromJson(json.decode(str));

String stateMasterToJson(StateMaster data) => json.encode(data.toJson());

class StateMaster {
  StateMaster({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory StateMaster.fromJson(Map<String, dynamic> json) => StateMaster(
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
    this.id,
    this.english,
    this.tamil,
    this.countryId,
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
