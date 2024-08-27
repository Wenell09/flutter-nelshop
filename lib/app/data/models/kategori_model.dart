class KategoriModel {
  String kategoriId, kategori;

  KategoriModel({
    required this.kategoriId,
    required this.kategori,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      kategoriId: json["kategori_id"] ?? "",
      kategori: json["kategori"] ?? "",
    );
  }
}
