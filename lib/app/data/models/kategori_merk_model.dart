class KategoriMerkModel {
  String kategoriMerkId, kategoriId, kategoriMerk, gambar;

  KategoriMerkModel({
    required this.kategoriMerkId,
    required this.kategoriId,
    required this.kategoriMerk,
    required this.gambar,
  });

  factory KategoriMerkModel.fromJson(Map<String, dynamic> json) {
    return KategoriMerkModel(
      kategoriMerkId: json["kategori_merk_id"],
      kategoriId: json["kategori_id"],
      kategoriMerk: json["kategori_merk"],
      gambar: json["logo_gambar"],
    );
  }
}
