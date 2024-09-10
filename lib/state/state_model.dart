// To parse this JSON data, do
//
//     final stateModeList = stateModeListFromJson(jsonString);

import 'dart:convert';

StateModeList stateModeListFromJson(String str) => StateModeList.fromJson(json.decode(str));

String stateModeListToJson(StateModeList data) => json.encode(data.toJson());

class StateModeList {
  String status;
  List<StateDatum> stateData;

  StateModeList({
    required this.status,
    required this.stateData,
  });

  factory StateModeList.fromJson(Map<String, dynamic> json) => StateModeList(
    status: json["status"],
    stateData: List<StateDatum>.from(json["stateData"].map((x) => StateDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "stateData": List<dynamic>.from(stateData.map((x) => x.toJson())),
  };
}

class StateDatum {
  String english;
  int id;

  StateDatum({
    required this.english,
    required this.id,
  });

  factory StateDatum.fromJson(Map<String, dynamic> json) => StateDatum(
    english: json["English"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "English": english,
    "id": id,
  };
}
