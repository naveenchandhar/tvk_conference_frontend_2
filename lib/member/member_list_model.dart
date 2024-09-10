// To parse this JSON data, do
//
//     final memberModelList = memberModelListFromJson(jsonString);
// To parse this JSON data, do
//
//     final memberModelList = memberModelListFromJson(jsonString);

import 'dart:convert';

MemberModelList memberModelListFromJson(String str) => MemberModelList.fromJson(json.decode(str));

String memberModelListToJson(MemberModelList data) => json.encode(data.toJson());

class MemberModelList {
  int totalElements;
  List<MemberDatum> memberData;
  int totalPages;
  int pageNumber;

  MemberModelList({
    required this.totalElements,
    required this.memberData,
    required this.totalPages,
    required this.pageNumber,
  });

  factory MemberModelList.fromJson(Map<String, dynamic> json) => MemberModelList(
    totalElements: json["totalElements"],
    memberData: List<MemberDatum>.from(json["memberData"].map((x) => MemberDatum.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "totalElements": totalElements,
    "memberData": List<dynamic>.from(memberData.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class MemberDatum {
  int id;
  String nameFirstEn;
  YConstituency? mstState;
  MstDistrict? mstDistrict;
  YConstituency? parlimentaryConstituency;
  YConstituency? assembleyConstituency;
  Role role;

  MemberDatum({
    required this.id,
    required this.nameFirstEn,
    required this.mstState,
    required this.mstDistrict,
    required this.parlimentaryConstituency,
    required this.assembleyConstituency,
    required this.role,
  });

  factory MemberDatum.fromJson(Map<String, dynamic> json) => MemberDatum(
    id: json["id"],
    nameFirstEn: json["Name_First_en"] ?? "",
    mstDistrict: json["mst_district"] == null ? null : MstDistrict.fromJson(json["mst_district"]),
    mstState: json["mstState"] == null ? null : YConstituency.fromJson(json["mstState"]),
    parlimentaryConstituency: json["ParlimentaryConstituency"] == null ? null : YConstituency.fromJson(json["ParlimentaryConstituency"]),
    assembleyConstituency: json["AssembleyConstituency"] == null ? null : YConstituency.fromJson(json["AssembleyConstituency"]),
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Name_First_en": nameFirstEn,
    "mst_district": mstDistrict?.toJson(),
    "mstState": mstState?.toJson(),
    "ParlimentaryConstituency": parlimentaryConstituency?.toJson(),
    "AssembleyConstituency": assembleyConstituency?.toJson(),
    "role": role.toJson(),
  };
}

class YConstituency {
  String english;

  YConstituency({
    required this.english,
  });

  factory YConstituency.fromJson(Map<String, dynamic> json) => YConstituency(
    english: json["English"],
  );

  Map<String, dynamic> toJson() => {
    "English": english,
  };
}

class MstDistrict {
  String dstctEnglish;

  MstDistrict({
    required this.dstctEnglish,
  });

  factory MstDistrict.fromJson(Map<String, dynamic> json) => MstDistrict(
    dstctEnglish: json["dstctEnglish"],
  );

  Map<String, dynamic> toJson() => {
    "dstctEnglish": dstctEnglish,
  };
}

class Role {
  String role;

  Role({
    required this.role,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
  };
}




//Filtered MemberList
// To parse this JSON data, do
//
//     final filteredMemberModel = filteredMemberModelFromJson(jsonString);

FilteredMemberModel filteredMemberModelFromJson(String str) =>
    FilteredMemberModel.fromJson(json.decode(str));

String filteredMemberModelToJson(FilteredMemberModel data) =>
    json.encode(data.toJson());

class FilteredMemberModel {
  final FilteredMember filteredMember;

  FilteredMemberModel({
    required this.filteredMember,
  });

  factory FilteredMemberModel.fromJson(Map<String, dynamic> json) =>
      FilteredMemberModel(
        filteredMember: FilteredMember.fromJson(json["filteredMember"]),
      );

  Map<String, dynamic> toJson() => {
        "filteredMember": filteredMember.toJson(),
      };
}

class FilteredMember {
  final List<FilteredMemberDatum>? filteredMemberData;

  FilteredMember({
    this.filteredMemberData,
  });

  factory FilteredMember.fromJson(Map<String, dynamic> json) => FilteredMember(
        filteredMemberData: List<FilteredMemberDatum>.from(
          json["filteredMemberData"].map(
            (x) => FilteredMemberDatum.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "filteredMemberData":
            List<dynamic>.from(filteredMemberData!.map((x) => x.toJson())),
      };
}

class FilteredMemberDatum {
  final String? nameFirstEn;
  final int? id;
  final dynamic? roleId;

  FilteredMemberDatum({
    this.nameFirstEn,
    this.id,
    this.roleId,
  });

  factory FilteredMemberDatum.fromJson(Map<String, dynamic> json) =>
      FilteredMemberDatum(
        nameFirstEn: json["Name_First_en"] ?? "", // Set empty string if null
        id: json["id"] ?? 0, // Set 0 if null
        roleId: json["roleId"] ?? "", // Set empty string if null
      );

  Map<String, dynamic> toJson() => {
        "Name_First_en": nameFirstEn,
        "id": id,
        "roleId": roleId,
      };
}
