import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/barang_model.dart';
import 'package:flutter_nelshop/app/data/models/kategori_merk_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KategoriController extends GetxController {
  final kategoriMerk = <KategoriMerkModel>[].obs;
  final barang = <BarangModel>[].obs;
  final kategoriId = Get.arguments["kategoriId"];
  final title = Get.arguments["title"];
  final titleMerk = "".obs;
  final selectedIndex = 0.obs;
  final isLoading = true.obs;

  Future<List<KategoriMerkModel>> getKategoriMerk() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/KategoriMerk"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        kategoriMerk.value =
            result.map((json) => KategoriMerkModel.fromJson(json)).toList();
        kategoriMerk.value = kategoriMerk
            .where((data) => kategoriId == data.kategoriId)
            .toList();
        isLoading.value = false;
      } else {
        debugPrint("gagal fetch kategori merk");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return kategoriMerk;
  }

  Future<List<BarangModel>> getBarangwithMerk(String kategoriMerkId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/barang"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        barang.value =
            result.map((json) => BarangModel.fromJson(json)).toList();
        if (kategoriMerkId.isEmpty) {
          barang.value =
              barang.where((data) => kategoriId == data.kategoriId).toList();
        } else {
          barang.value = barang
              .where(
                (data) =>
                    kategoriId == data.kategoriId &&
                    kategoriMerkId == data.kategoriMerkId,
              )
              .toList();
        }
      } else {
        debugPrint("Gagal get barang");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return barang;
  }

  void getTitleMerk(String merk) {
    titleMerk.value = merk;
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
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
    getKategoriMerk();
    getBarangwithMerk("");
    super.onInit();
  }
}
