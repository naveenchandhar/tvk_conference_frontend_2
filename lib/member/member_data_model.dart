// To parse this JSON data, do
//
//     final memberDataModel = memberDataModelFromJson(jsonString);

import 'dart:convert';

MemberDataModel memberDataModelFromJson(String str) =>
    MemberDataModel.fromJson(json.decode(str));

String memberDataModelToJson(MemberDataModel data) =>
    json.encode(data.toJson());

class MemberDataModel {
  String status;
  Data data;

  MemberDataModel({
    required this.status,
    required this.data,
  });

  factory MemberDataModel.fromJson(Map<String, dynamic> json) =>
      MemberDataModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String? nameFirstEn;
  String? voterId;
  int? stateId;
  int? districtId;
  int? assembleyConstituencyId;
  AssembleyConstituency? mstState;
  MstDistrict? mstDistrict;
  AssembleyConstituency? parlimentaryConstituency;
  AssembleyConstituency? assembleyConstituency;
  Role? role;
  String? sex;
  DateTime? dob;
  String? mobileNo;
  String? idCardNo;

  Data({
    required this.id,
    this.voterId,
    this.nameFirstEn,
    this.stateId,
    this.districtId,
    this.assembleyConstituencyId,
    this.mstState,
    this.mstDistrict,
    this.parlimentaryConstituency,
    this.assembleyConstituency,
    this.role,
    this.sex,
    this.dob,
    this.mobileNo,
    this.idCardNo,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
          id: json["id"],
          voterId: json["voterId"] ?? "",
          nameFirstEn: json["Name_First_en"] ?? "",
          stateId: json["stateId"] ?? 0,
          districtId: json["districtId"] ?? 0,
          assembleyConstituencyId: json["assembleyConstituencyId"] ?? 0,
          mstState: json["mst_state"] == null
              ? null
              : AssembleyConstituency.fromJson(json["mst_state"]),
          mstDistrict: json["mst_district"] == null
              ? null
              : MstDistrict.fromJson(json["mst_district"]),
          parlimentaryConstituency: json["ParlimentaryConstituency"] == null
              ? null
              : AssembleyConstituency.fromJson(
              json["ParlimentaryConstituency"]),
          assembleyConstituency: json["AssembleyConstituency"] == null
              ? null
              : AssembleyConstituency.fromJson(json["AssembleyConstituency"]),
          role: json["role"] == null ? null : Role.fromJson(json["role"]),
          sex: json["Sex"] ?? "",
          dob: json["DOB"] == null ? null : DateTime.parse(json["DOB"]),
          mobileNo: json["mobileNo"] ?? "",
          idCardNo: json["IDCardNo"] ??"",
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "voterId": voterId,
        "Name_First_en": nameFirstEn,
        "stateId": stateId,
        "districtId": districtId,
        "assembleyConstituencyId": assembleyConstituencyId,
        "mst_state": mstState?.toJson(),
        "mst_district": mstDistrict?.toJson(),
        "ParlimentaryConstituency": parlimentaryConstituency?.toJson(),
        "AssembleyConstituency": assembleyConstituency?.toJson(),
        "role": role?.toJson(),
        "Sex": sex,
        "DOB": dob,
        "mobileNo": mobileNo,
        "IDCardNo": idCardNo,
      };
}

class AssembleyConstituency {
  String english;

  AssembleyConstituency({
    required this.english,
  });

  factory AssembleyConstituency.fromJson(Map<String, dynamic> json) =>
      AssembleyConstituency(
        english: json["English"],
      );

  Map<String, dynamic> toJson() =>
      {
        "English": english,
      };
}

class MstDistrict {
  String dstctEnglish;

  MstDistrict({
    required this.dstctEnglish,
  });

  factory MstDistrict.fromJson(Map<String, dynamic> json) =>
      MstDistrict(
        dstctEnglish: json["dstctEnglish"],
      );

  Map<String, dynamic> toJson() =>
      {
        "dstctEnglish": dstctEnglish,
      };
}

class Role {
  String role;

  Role({
    required this.role,
  });

  factory Role.fromJson(Map<String, dynamic> json) =>
      Role(
        role: json["role"],
      );

  Map<String, dynamic> toJson() =>
      {
        "role": role,
      };
}
