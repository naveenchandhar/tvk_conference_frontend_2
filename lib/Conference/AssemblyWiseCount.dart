// To parse this JSON data, do
//
//     final assemblyWiseCount = assemblyWiseCountFromJson(jsonString);

import 'dart:convert';

AssemblyWiseCount assemblyWiseCountFromJson(String str) => AssemblyWiseCount.fromJson(json.decode(str));

String assemblyWiseCountToJson(AssemblyWiseCount data) => json.encode(data.toJson());

class AssemblyWiseCount {
  String? status;
  String? message;
  List<Datum>? data;

  AssemblyWiseCount({
    this.status,
    this.message,
    this.data,
  });

  factory AssemblyWiseCount.fromJson(Map<String, dynamic> json) => AssemblyWiseCount(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? assemblyId;
  String? name;
  String? maleCount;
  String? femaleCount;

  Datum({
    this.assemblyId,
    this.name,
    this.maleCount,
    this.femaleCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    assemblyId: json["assembly_id"],
    name: json["name"],
    maleCount: json["male_count"],
    femaleCount: json["female_count"],
  );

  Map<String, dynamic> toJson() => {
    "assembly_id": assemblyId,
    "name": name,
    "male_count": maleCount,
    "female_count": femaleCount,
  };
}
