import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/detail_barang_model.dart';
import 'package:flutter_nelshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_nelshop/app/modules/myAccount/controllers/my_account_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailController extends GetxController {
  final barangId = Get.arguments;
  final detailBarang = <DetailBarangModel>[].obs;
  final currentPage = 0.obs;
  final quantity = 1.obs;
  final isLoading = true.obs;

  Future<List<DetailBarangModel>> getDetailBarang() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/barang/$barangId"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        detailBarang.value =
            result.map((json) => DetailBarangModel.fromJson(json)).toList();
        isLoading.value = false;
      } else {
        debugPrint("gagal get detail barang");
      }
    } catch (e) {
      debugPrint("Error:$e");
    }
    return detailBarang;
  }

  Future<void> addToCart(String namaBarang, int harga, String gambar, int berat,
      String kategoriId) async {
    try {
      final totalHarga = harga * quantity.value;
      String kategori = "";
      if (kategoriId == "KT01") {
        kategori = "Handphone";
      } else {
        kategori = "Laptop";
      }
      Map<String, dynamic> data = {
        "user_id": MyAccountController.userId.value,
        "barang_id": barangId,
        "nama_barang": namaBarang,
        "harga": harga,
        "gambar": gambar,
        "berat": berat,
        "kategori": kategori,
        "quantity": quantity.value,
        "total_harga": totalHarga,
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addShoppingCart"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          dismissDirection: DismissDirection.horizontal,
          "Berhasil",
          "berhasil menambahkan ke keranjang!",
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        debugPrint("result : ${response.body}");
        quantity.value = 1;
        HomeController.getShoppingCartUser();
      } else {
        debugPrint("result : ${response.body}");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
  }

  void changePage(int value) {
    currentPage.value = value;
  }

  void tambahQuantity(int index) {
    for (var detail in detailBarang) {
      if (detail.stok == quantity.value) {
        quantity.value = detail.stok;
      } else {
        quantity.value += index;
      }
    }
  }

  void kurangQuantity(int index) {
    if (quantity.value == 1) {
      quantity.value = 1;
    } else {
      quantity.value -= index;
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

  @override
  void onInit() {
    getDetailBarang();
    super.onInit();
  }
}
