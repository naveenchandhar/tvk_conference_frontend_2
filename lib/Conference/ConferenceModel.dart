// To parse this JSON data, do
//
//     final conferenceModel = conferenceModelFromJson(jsonString);

import 'dart:convert';

ConferenceModel conferenceModelFromJson(String str) => ConferenceModel.fromJson(json.decode(str));

String conferenceModelToJson(ConferenceModel data) => json.encode(data.toJson());

class ConferenceModel {
  String status;
  String message;
  Data data;

  ConferenceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ConferenceModel.fromJson(Map<String, dynamic> json) => ConferenceModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  int? publicCount;
  int? policeCount;
  int? pressCount;
  String? type;
  int? noPeopleAllowed;
  DateTime? date;
  String? startTime;

  Data({
    this.id,
    this.name,
    this.publicCount,
    this.policeCount,
    this.pressCount,
    this.type,
    this.noPeopleAllowed,
    this.date,
    this.startTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    publicCount: json["public_count"],
    policeCount: json["police_count"],
    pressCount: json["press_count"],
    type: json["type"],
    noPeopleAllowed: json["no_people_allowed"],
    date: DateTime.parse(json["date"]),
    startTime: json["start_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "public_count": publicCount,
    "police_count": policeCount,
    "press_count": pressCount,
    "type": type,
    "no_people_allowed": noPeopleAllowed,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
  };
}
