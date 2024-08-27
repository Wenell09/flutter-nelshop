import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/models/barang_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailBrandsController extends GetxController {
  final barang = <BarangModel>[].obs;
  final titleBrand = "".obs;
  final isLoading = true.obs;

  Future<List<BarangModel>> getBarangwithMerk(String kategoriMerkId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/barang"));
      if (response.statusCode == 200) {
        isLoading.value = false;
        final List result = jsonDecode(response.body)["data"];
        barang.value =
            result.map((json) => BarangModel.fromJson(json)).toList();
        barang.value = barang
            .where(
              (data) => kategoriMerkId == data.kategoriMerkId,
            )
            .toList();
      } else {
        debugPrint("Gagal get barang");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return barang;
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
    final kategoriMerkId = Get.arguments["kategoriMerkId"];
    final title = Get.arguments["title"];
    titleBrand.value = title;
    getBarangwithMerk(kategoriMerkId);
    super.onInit();
  }

  @override
  void dispose() {
    titleBrand.value = "";
    barang.clear();
    super.dispose();
  }
}
