import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nelshop/app/data/constant/base_url.dart';
import 'package:flutter_nelshop/app/data/models/kategori_merk_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BrandsController extends GetxController {
  final kategoriMerk = <KategoriMerkModel>[].obs;
  final isLoading = true.obs;

  Future<List<KategoriMerkModel>> getKategoriMerk() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/kategoriMerk"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        kategoriMerk.value =
            result.map((json) => KategoriMerkModel.fromJson(json)).toList();
        isLoading.value = false;
      } else {
        debugPrint("Gagal get kategori merk");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return kategoriMerk;
  }

  @override
  void onInit() {
    getKategoriMerk();
    super.onInit();
  }
}
