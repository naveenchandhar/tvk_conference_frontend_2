// To parse this JSON data, do
//
//     final stateListModel = stateListModelFromJson(jsonString);

import 'dart:convert';

StateListModel stateListModelFromJson(String str) => StateListModel.fromJson(json.decode(str));

String stateListModelToJson(StateListModel data) => json.encode(data.toJson());

class StateListModel {
  StateListModel({
    required this.status,
    required this.data,
  });

  String status;
  List<Datum> data;

  factory StateListModel.fromJson(Map<String, dynamic> json) => StateListModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.english,
    required this.id,
  });

  String english;
  int id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    english: json["English"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "English": english,
    "id": id,
  };
}
