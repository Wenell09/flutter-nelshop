class UserModel {
  String userId, role, nama, email;

  UserModel({
    required this.userId,
    required this.role,
    required this.nama,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] ?? "",
      role: json["role"] ?? "",
      nama: json["nama"] ?? "",
      email: json["email"] ?? "",
    );
  }
}
