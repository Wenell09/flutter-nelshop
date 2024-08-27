class ProvinceModel {
  String provinceId, province;

  ProvinceModel({
    required this.provinceId,
    required this.province,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      provinceId: json["province_id"] ?? "",
      province: json["province"] ?? "",
    );
  }
}
