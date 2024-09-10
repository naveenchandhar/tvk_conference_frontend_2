// To parse this JSON data, do
//
//     final newUserModel = newUserModelFromJson(jsonString);

import 'dart:convert';

NewUserModel newUserModelFromJson(String str) => NewUserModel.fromJson(json.decode(str));

String newUserModelToJson(NewUserModel data) => json.encode(data.toJson());

class NewUserModel {
  int? id;
  String? mobileNo;
  String? password;

  NewUserModel({
     this.id,
     this.mobileNo,
     this.password,
  });

  factory NewUserModel.fromJson(Map<String, dynamic> json) => NewUserModel(
    id: json["id"],
    mobileNo: json["mobileNo"],
    password: json["password"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobileNo": mobileNo,
    "password": password,
  };
}
