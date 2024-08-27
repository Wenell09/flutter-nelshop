class FavoriteUserModel {
  String favoriteUserId, userId, barangId, namaBarang, gambar, kategori;
  int harga;

  FavoriteUserModel({
    required this.favoriteUserId,
    required this.userId,
    required this.barangId,
    required this.namaBarang,
    required this.gambar,
    required this.kategori,
    required this.harga,
  });

  factory FavoriteUserModel.fromJson(Map<String, dynamic> json) {
    return FavoriteUserModel(
      favoriteUserId: json["favorite_user_id"],
      userId: json["user_id"],
      barangId: json["barang_id"],
      namaBarang: json["nama_barang"],
      gambar: json["gambar"],
      kategori: json["kategori"],
      harga: json["harga"],
    );
  }
}
