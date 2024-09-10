// To parse this JSON data, do
//
//     final userDataTokenModel = userDataTokenModelFromJson(jsonString);

import 'dart:convert';

UserDataTokenModel userDataTokenModelFromJson(String str) => UserDataTokenModel.fromJson(json.decode(str));

String userDataTokenModelToJson(UserDataTokenModel data) => json.encode(data.toJson());

class UserDataTokenModel {
  String? name;
  String? password;
  int? id;
  int? adminFlag;
  int? iat;

  UserDataTokenModel({
     this.name,
     this.password,
     this.id,
     this.adminFlag,
     this.iat,
  });

  factory UserDataTokenModel.fromJson(Map<String, dynamic> json) => UserDataTokenModel(
    name: json["name"]??"",
    password: json["password"]??"",
    id: json["id"]??0,
    adminFlag: json["adminFlag"]??0,
    iat: json["iat"]??0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "id": id,
    "adminFlag": adminFlag,
    "iat": iat,
  };
}
