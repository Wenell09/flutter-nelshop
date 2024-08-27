class BarangModel {
  String barangId, kategoriId, namaBarang, gambar, kategoriMerkId;
  int harga, terjual;

  BarangModel({
    required this.barangId,
    required this.kategoriId,
    required this.namaBarang,
    required this.gambar,
    required this.harga,
    required this.terjual,
    required this.kategoriMerkId,
  });

  factory BarangModel.fromJson(Map<String, dynamic> json) {
    return BarangModel(
      barangId: json["barang_id"] ?? "",
      kategoriId: json["kategori_id"] ?? "",
      namaBarang: json["nama_barang"] ?? "",
      gambar: json["gambar"] ?? "",
      harga: json["harga"] ?? 0,
      terjual: json["terjual"] ?? 0,
      kategoriMerkId: json["kategori_merk_id"] ?? "",
    );
  }
}
