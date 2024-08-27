class CityModel {
  String cityId, provinceId, province, type, cityName, postalCode;

  CityModel({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json["city_id"] ?? "",
      provinceId: json["province_id"] ?? "",
      province: json["province"] ?? "",
      type: json["type"] ?? "",
      cityName: json["city_name"] ?? "",
      postalCode: json["postal_code"] ?? "",
    );
  }
}
