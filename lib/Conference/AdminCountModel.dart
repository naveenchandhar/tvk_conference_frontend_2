class AdminCount {
  int? adminId;
  String? district;
  String? assembly;
  String? adminName;
  String? count;

  AdminCount({
    this.adminId,
    this.district,
    this.assembly,
    this.adminName,
    this.count,
  });

  // Factory method to create an instance of AdminCount from JSON
  factory AdminCount.fromJson(Map<String, dynamic> json) => AdminCount(
    adminId: json["admin_id"],
    district: json["district"],
    assembly: json["assembly"],
    adminName: json["admin_name"],
    count: json["count"],
  );

  // Method to convert AdminCount instance to JSON
  Map<String, dynamic> toJson() => {
    "admin_id": adminId,
    "district": district,
    "assembly": assembly,
    "admin_name": adminName,
    "count": count,
  };
}
