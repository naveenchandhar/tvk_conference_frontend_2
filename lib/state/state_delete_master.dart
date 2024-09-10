// To parse this JSON data, do
//
//     final stateDeleteMaster = stateDeleteMasterFromJson(jsonString);

import 'dart:convert';

StateDeleteMaster stateDeleteMasterFromJson(String str) => StateDeleteMaster.fromJson(json.decode(str));

String stateDeleteMasterToJson(StateDeleteMaster data) => json.encode(data.toJson());

class StateDeleteMaster {
  StateDeleteMaster({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<int> data;

  factory StateDeleteMaster.fromJson(Map<String, dynamic> json) => StateDeleteMaster(
    status: json["status"],
    message: json["message"],
    data: List<int>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
