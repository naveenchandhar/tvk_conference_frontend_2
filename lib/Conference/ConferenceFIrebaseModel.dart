// To parse this JSON data, do
//
//     final conferenceFirebaseModel = conferenceFirebaseModelFromJson(jsonString);

import 'dart:convert';

ConferenceFirebaseModel conferenceFirebaseModelFromJson(String str) => ConferenceFirebaseModel.fromJson(json.decode(str));

String conferenceFirebaseModelToJson(ConferenceFirebaseModel data) => json.encode(data.toJson());

class ConferenceFirebaseModel {
  int? maleCount;
  int? femaleCount;
  int? totalCount;
  int? publicCount;
  int? policeCount;
  int? pressCount;

  ConferenceFirebaseModel({
    this.maleCount,
    this.femaleCount,
    this.totalCount,
    this.publicCount,
    this.policeCount,
    this.pressCount,
  });

  factory ConferenceFirebaseModel.fromJson(Map<String, dynamic> json) => ConferenceFirebaseModel(
    maleCount: json["maleCount"] ?? 0,
    femaleCount: json["femaleCount"]?? 0,
    totalCount: json["totalCount"]?? 0,
    publicCount: json["public_count"]?? 0,
    policeCount: json["police_count"]?? 0,
    pressCount: json["press_count"]?? 0,
  );

  Map<String, dynamic> toJson() => {
    "maleCount": maleCount,
    "femaleCount": femaleCount,
    "totalCount": totalCount,
    "public_count": publicCount,
    "police_count": policeCount,
    "press_count": pressCount,
  };
}
