class AlamatModel {
  String alamatId,
      userId,
      namaPenerima,
      noHandphone,
      alamatRumah,
      provinsiId,
      provinsi,
      kotaKabupatenId,
      kotaKabupaten;
  int kodePos, alamatUtama;

  AlamatModel({
    required this.alamatId,
    required this.userId,
    required this.namaPenerima,
    required this.noHandphone,
    required this.alamatRumah,
    required this.provinsiId,
    required this.provinsi,
    required this.kotaKabupatenId,
    required this.kotaKabupaten,
    required this.kodePos,
    required this.alamatUtama,
  });

  factory AlamatModel.fromJson(Map<String, dynamic> json) {
    return AlamatModel(
      alamatId: json["alamat_id"] ?? "",
      userId: json["user_id"] ?? "",
      namaPenerima: json["nama_penerima"] ?? "",
      noHandphone: json["no_handphone"] ?? "",
      alamatRumah: json["alamat_rumah"] ?? "",
      provinsiId: json["provinsi_id"] ?? "",
      provinsi: json["provinsi"] ?? "",
      kotaKabupatenId: json["kota_kabupaten_id"] ?? "",
      kotaKabupaten: json["kota_kabupaten"] ?? "",
      kodePos: json["kode_pos"] ?? 0,
      alamatUtama: json["alamat_utama"] ?? 0,
    );
  }
}
