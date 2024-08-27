class DetailBarangModel {
  String barangId,
      kategoriId,
      namaBarang,
      spesifikasi,
      deskripsi,
      gambar,
      kategoriMerkId;
  int berat, harga, stok, terjual;

  DetailBarangModel({
    required this.barangId,
    required this.kategoriId,
    required this.namaBarang,
    required this.spesifikasi,
    required this.deskripsi,
    required this.gambar,
    required this.berat,
    required this.harga,
    required this.stok,
    required this.terjual,
    required this.kategoriMerkId,
  });

  factory DetailBarangModel.fromJson(Map<String, dynamic> json) {
    return DetailBarangModel(
      barangId: json["barang_id"] ?? "",
      kategoriId: json["kategori_id"] ?? "",
      namaBarang: json["nama_barang"] ?? "",
      spesifikasi: json["spesifikasi"] ?? "",
      deskripsi: json["deskripsi"] ?? "",
      gambar: json["gambar"] ?? "",
      berat: json["berat"] ?? 0,
      harga: json["harga"] ?? 0,
      stok: json["stok"] ?? 0,
      terjual: json["terjual"] ?? 0,
      kategoriMerkId: json["kategori_merk_id"] ?? "",
    );
  }
}
