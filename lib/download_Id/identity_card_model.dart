// To parse this JSON data, do
//
//     final identityCardModel = identityCardModelFromJson(jsonString);

import 'dart:convert';

IdentityCardModel identityCardModelFromJson(String str) => IdentityCardModel.fromJson(json.decode(str));

String identityCardModelToJson(IdentityCardModel data) => json.encode(data.toJson());

class IdentityCardModel {
  IdentityCardModel({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory IdentityCardModel.fromJson(Map<String, dynamic> json) => IdentityCardModel(
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
    required this.fileName,
    required this.imgUrl,
    required this.phoneNumber,
  });

  String fileName;
  String imgUrl;
  String phoneNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fileName: json["fileName"],
    imgUrl: json["imgUrl"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "fileName": fileName,
    "imgUrl": imgUrl,
    "phoneNumber": phoneNumber,
  };
}
