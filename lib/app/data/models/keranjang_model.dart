class KeranjangModel {
  String keranjangId, userId, barangId, namaBarang, gambar, kategori;
  int harga, quantity, totalHarga;

  KeranjangModel({
    required this.keranjangId,
    required this.userId,
    required this.barangId,
    required this.namaBarang,
    required this.gambar,
    required this.kategori,
    required this.harga,
    required this.quantity,
    required this.totalHarga,
  });

  factory KeranjangModel.fromJson(Map<String, dynamic> json) {
    return KeranjangModel(
        keranjangId: json["keranjang_id"],
        userId: json["user_id"],
        barangId: json["barang_id"],
        namaBarang: json["nama_barang"],
        gambar: json["gambar"],
        kategori: json["kategori"],
        harga: json["harga"],
        quantity: json["quantity"],
        totalHarga: json["total_harga"]);
  }
}
