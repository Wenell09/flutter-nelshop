import 'dart:convert';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/favorite_user_model.dart';
import 'package:flutter_nelshop/app/data/models/kategori_model.dart';
import 'package:flutter_nelshop/app/data/models/keranjang_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/models/barang_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final currentPage = 0.obs;
  late PageController pageController;
  final barang = <BarangModel>[].obs;
  final kategori = <KategoriModel>[].obs;
  final isLoading = true.obs;
  static final keranjangUser = <KeranjangModel>[].obs;
  static final favoriteUser = <FavoriteUserModel>[].obs;
  static final totalBayar = 0.obs;
  static final totalBerat = 0.obs;
  static final homeUserId = "".obs;

  void getHomeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final getId = prefs.getString("homeUserId") ?? "";
    homeUserId.value = getId;
    if (homeUserId.value.isEmpty) {
      debugPrint("home id user kosong");
    } else {
      debugPrint("home id user : ${homeUserId.value}");
      prefs.setString("homeUserId", homeUserId.value);
      getShoppingCartUser();
      getFavoriteUser();
    }
  }

  Future<List<BarangModel>> getBarang() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/barang"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        barang.value =
            result.map((json) => BarangModel.fromJson(json)).toList();
        barang.value = barang.where((data) => data.terjual >= 100).toList();
        isLoading.value = false;
      } else {
        debugPrint("gagal fetch barang");
      }
    } catch (e) {
      debugPrint("Error : $e");
    }
    return barang;
  }

  Future<List<KategoriModel>> getKategori() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/kategori"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        kategori.value =
            result.map((json) => KategoriModel.fromJson(json)).toList();
      } else {
        debugPrint("gagal fetch kategori");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return kategori;
  }

  static Future<List<KeranjangModel>> getShoppingCartUser() async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/shoppingCart/${homeUserId.value}"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        keranjangUser.value =
            result.map((json) => KeranjangModel.fromJson(json)).toList();
        final int resultTotalBayar = jsonDecode(response.body)["total_bayar"];
        final int resultTotalBerat = jsonDecode(response.body)["total_berat"];
        totalBayar.value = resultTotalBayar;
        totalBerat.value = resultTotalBerat;
      } else {
        keranjangUser.clear();
        totalBayar.value = 0;
        debugPrint("error get shopping cart user");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return keranjangUser;
  }

  static Future<void> addFavoriteUser(
    String barangId,
    String namaBarang,
    int harga,
    String gambar,
    String kategori,
  ) async {
    String jenisKategori = "";
    if (kategori == "KT01") {
      jenisKategori = "Handphone";
    } else {
      jenisKategori = "Laptop";
    }
    try {
      Map<String, dynamic> data = {
        "user_id": homeUserId.value,
        "barang_id": barangId,
        "nama_barang": namaBarang,
        "harga": harga,
        "gambar": gambar,
        "kategori": jenisKategori,
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addFavoriteUser"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          dismissDirection: DismissDirection.horizontal,
          "Berhasil",
          "berhasil menambahkan favorite!",
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        debugPrint("result : ${response.body}");
        HomeController.getFavoriteUser();
      } else {
        debugPrint("result : ${response.body}");
      }
    } catch (e) {
      debugPrint("error :$e");
    }
  }

  static Future<List<FavoriteUserModel>> getFavoriteUser() async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/favoriteUser/${homeUserId.value}"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        favoriteUser.value =
            result.map((json) => FavoriteUserModel.fromJson(json)).toList();
      } else {
        favoriteUser.clear();
        debugPrint("gagal get favorite user");
      }
    } catch (e) {
      debugPrint("error :$e");
    }
    return favoriteUser;
  }

  static Future<void> deleteFavoriteUser(String barangId) async {
    try {
      String uribarangId = "";
      if (barangId.isNotEmpty) {
        uribarangId = "/$barangId";
      }
      final response = await http.delete(Uri.parse(
          "$baseUrl/deletefavoriteUser/${homeUserId.value}$uribarangId"));
      if (response.statusCode == 200) {
        Get.snackbar(
          dismissDirection: DismissDirection.horizontal,
          "Berhasil",
          "berhasil menghapus favorite!",
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        debugPrint("result :${response.body}");
        getFavoriteUser();
      } else {
        debugPrint("gagal hapus favorite user");
      }
    } catch (e) {
      debugPrint("error :$e");
    }
  }

  String formatRupiah(double value) {
    final NumberFormat format = NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp",
      decimalDigits: 0,
    );
    return format.format(value);
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void autoPlay() {
    Future.delayed(const Duration(seconds: 2), () {
      if (pageController.hasClients) {
        int nextPage = (currentPage.value + 1) % 3;
        pageController.animateToPage(nextPage,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
      autoPlay();
    });
  }

  @override
  void onInit() {
    getHomeUserId();
    getBarang();
    getKategori();
    autoPlay();
    pageController = PageController();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
